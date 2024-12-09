#include "i2c_lib.h"

void i2c_irq(void) __interrupt(I2C_vector)
{
  disableInterrupts();
  memset(&I2C_IRQ, 0, sizeof(I2C_IRQ));
  if(I2C_SR1 -> SB) 
  {
  	I2C_IRQ.SB = 1;
    I2C_ITR -> ITEVTEN = 0;
  }
  if(I2C_SR1 -> ADDR) 
  {
  	I2C_IRQ.ADDR = 1;
    I2C_ITR -> ITEVTEN = 0;
  }
  if(I2C_SR1 -> BTF) 
  {
  	I2C_IRQ.BTF = 1;
    I2C_ITR -> ITEVTEN = 0;
  }
  if(I2C_SR1 -> TXE) 
  {
  	I2C_IRQ.TXE = 1;
    I2C_ITR -> ITBUFEN = 0;
  } 
  if(I2C_SR1 -> RXNE) 
  {
  	I2C_IRQ.RXNE = 1;
    I2C_ITR -> ITBUFEN = 0;
  }    
  if(I2C_SR2 -> AF) 
  {
  	I2C_IRQ.AF = 1;
    I2C_ITR -> ITERREN = 0;
  }
  enableInterrupts(); 
  //memset(I2C_ITR, 0, sizeof(I2C_ITR));
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
	I2C_ITR -> ITEVTEN = 1;//Включение прерываний для обработки сигнала старт
    I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
    while(I2C_ITR -> ITEVTEN);// Ожидание отправки стартового сигнала
    //while(1);
}

void i2c_stop(void)
{
     I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
}

uint8_t i2c_send_byte(unsigned char data)
{
	I2C_ITR -> ITBUFEN = 1;
	I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
	I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
    I2C_DR -> DR = data; //Отправка данных
    while(I2C_ITR -> ITBUFEN || I2C_ITR -> ITERREN);
    return I2C_IRQ.AF;
}

uint8_t i2c_read_byte(unsigned char *data){
    while (!(I2C_SR1 -> RXNE));
    data = (unsigned char *)I2C_DR -> DR;
    return 0;
     
}



    
uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
{
    I2C_ITR -> ITEVTEN = 1; //Включение прерываний на отправку
    I2C_ITR -> ITERREN = 1; //Включение прерываний на ошибки
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
    while(I2C_ITR -> ITEVTEN || I2C_ITR -> ITERREN);
    return I2C_IRQ.ADDR;
}

void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
{
    if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
    {
        for(int i = 0;i < size;i++)
        {
            if(i2c_send_byte(data[i]))//Проверка на АСК бит
            {
                break;
            } 
        }
    }
    i2c_stop();
}

void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data){
    I2C_CR2 -> ACK = 1;
    if(i2c_send_address(dev_addr,1))
    for(int i = 0;i < size;i++)
    {
        i2c_read_byte((unsigned char *)data[i]);
    }
    I2C_CR2 -> ACK = 0;
}
uint8_t i2c_scan(void) 
{
    for (uint8_t addr = 1; addr < 127; addr++)
    {
        if(i2c_send_address(addr, 0))
        {
            i2c_stop();
            return addr;
        }
        I2C_SR2 -> AF = 0;
        uart_write("error addr\n"); //Очистка флага ошибки
    }
    i2c_stop();
    return 0;
}