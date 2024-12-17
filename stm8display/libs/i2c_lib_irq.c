#include "i2c_lib.h"

void i2c_irq(void) __interrupt(I2C_vector)
{
  
  disableInterrupts();
  I2C_IRQ.all = 0;//обнуление флагов регистров

  if(I2C_SR1 -> ADDR)//прерывание адреса
  {
    clr_sr1();
    I2C_IRQ.ADDR = 1;
    clr_sr3();//EV6
    I2C_ITR -> ITEVTEN = 0;
    uart_write_byte(0xE1);
    return;
  }

  if(I2C_SR1 -> TXE) //прерывание регистра данных(он пуст)
  {
    I2C_IRQ.TXE = 1;
    I2C_ITR -> ITBUFEN = 0;
    I2C_ITR -> ITEVTEN = 0;
    I2C_ITR -> ITERREN = 0;
    uart_write_byte(0xEA);
    return;
  } 
  if(I2C_SR1 -> RXNE) //прерывание регистра данных(он не пуст)
  {
    I2C_IRQ.RXNE = 1;
    I2C_ITR -> ITBUFEN = 0;
    I2C_ITR -> ITEVTEN = 0;
    I2C_ITR -> ITERREN = 0;
    uart_write_byte(0xEB);
    return;
  } 

  if(I2C_SR1 -> SB)//EV5 прерывание стартового импульса
  {
  	I2C_IRQ.SB = 1;
    I2C_ITR -> ITEVTEN = 0;
    uart_write_byte(0xE2);
    return;
  }
  if(I2C_SR1 -> BTF) //прерывание отправки данных
  {
  	I2C_IRQ.BTF = 1;
    I2C_ITR -> ITEVTEN = 0;
    uart_write_byte(0xE3);
    return;
  }
   
  if(I2C_SR2 -> AF) //прерывание ошибки NACK
  {
  	I2C_IRQ.AF = 1;
    I2C_ITR -> ITEVTEN = 0;
    I2C_ITR -> ITERREN = 0;
    I2C_ITR -> ITBUFEN = 0;
    uart_write_byte(0xEE);
    return;
  }

  enableInterrupts(); 
}
void i2c_init(void)
{
    // Включение I2C
    //----------- Setup I2C ------------------------
    I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
    I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
    I2C_CCRH -> CCR = 0;// =0
    I2C_CCRL -> CCR = 80;// 100kHz for I2C
    I2C_CCRH -> FS = 0;// set standart mode(100кHz)
    I2C_OARH -> ADDMODE = 0;// 7-bit address mode
    I2C_OARH -> ADDCONF = 1;// see reference manual
    I2C_CR1 -> PE = 1;// PE=1, enable I2C
}

void i2c_start(void)
{
    //uart_write("i2c_start\n");
	I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
    I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
    while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
}

void i2c_stop(void)
{
    I2C_CR2 -> STOP = 1;// Отправка стопового сигнала  
}

uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
{
    switch(rw_type)
    {
    case 1:
        address = address << 1;
        address |= 0x01; // Отправка адреса устройства с битом на чтение
    break;
    default:
        address = address << 1; // Отправка адреса устройства с битом на запись
    break;
    }
    i2c_start();
    I2C_DR -> DR = address;
    I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
    I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
    while(I2C_ITR -> ITEVTEN && I2C_ITR -> ITERREN);
    //uart_write_byte(I2C_IRQ.ADDR);
    //uart_write_byte(I2C_SR1 -> ADDR);
    return !I2C_IRQ.AF;
}

uint8_t i2c_read_byte(unsigned char data){
    //uart_write("read_byte\n");
    I2C_DR -> DR = 0;
    I2C_ITR -> ITBUFEN = 1;
    I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
    I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
    //uart_write("irq_enable_read_byte\n");

    while(I2C_ITR -> ITERREN && I2C_ITR -> ITEVTEN);
    while(!I2C_IRQ.RXNE)
    uart_write_byte(0x11);//ожидание прерывания
    data = I2C_DR -> DR;
    //uart_write("irq_pass_read_byte\n");
    //uart_write("data_read\n");
    return 0;
}

uint8_t i2c_send_byte(unsigned char data)
{
    I2C_ITR -> ITBUFEN = 1;
    I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
    I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
    I2C_DR -> DR = data; //Отправка данных
    while(I2C_ITR -> ITERREN && I2C_ITR -> ITEVTEN);//ожидание прерывания
    return I2C_IRQ.AF;//флаг ответа
}


void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
{
    if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
    for(int i = 0;i < size;i++)
        {
            if(i2c_send_byte(data[i]))//Проверка на АСК бит
            {
                break;//ошибка отправки нет ACK бита -> выход из цикла
            } 
        }
    i2c_stop();
}

void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
{
    if(i2c_send_address(dev_addr, 1))//проверка на ACK
    {
        uart_write_byte(I2C_IRQ.ADDR);
        uart_write_byte(I2C_SR1 -> ADDR);
        I2C_CR2 -> ACK = 1;//включение ответа на посылки 
        for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
        {
            i2c_read_byte(data[i]);//функция записи байта в элемент массива
        }
        I2C_CR2 -> ACK = 0;//выключение ответа на посылки
        i2c_read_byte(data[size]);
    }
    i2c_stop(); 
}
uint8_t i2c_scan(void) 
{
    for (uint8_t addr = 1; addr < 127; addr++)
    {
        if(i2c_send_address(addr, 0))//отправка адреса на проверку 
        {
            i2c_stop();//адрес совпал 
            return addr;// выход из цикла
        }
        I2C_SR2 -> AF = 0;//очистка флага ошибки
    }
    i2c_stop();//совпадений нет выход из функции
    return 0;
}