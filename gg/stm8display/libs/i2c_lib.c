#include "i2c_lib.h"

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
    I2C_CR2 -> START = 1;// Отправляем стартовый сигнал
    while(!I2C_SR1 -> SB);// Ожидание отправки стартового сигнала
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
    while(!I2C_SR1 -> ADDR)
    if(I2C_SR2 -> AF)
        return 0;
    clr_sr1();
    clr_sr3();
    return 1;
}

uint8_t i2c_read_byte(void)
{
    while(!I2C_SR1 -> RXNE);
    return I2C_DR -> DR;
}

void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data)
{
    if(i2c_send_address(dev_addr, 1))//проверка на ACK
    {
        I2C_CR2 -> ACK = 1;//включение ответа на посылки 
        for(int i = 0;i < size-1;i++) //цикл чтения данных с шины
        {
            data[i] = i2c_read_byte();//функция записи байта в элемент массива
        }
        I2C_CR2 -> ACK = 0;//выключение ответа на посылки
        uart_write_byte(0x00);
        data[size-1] = i2c_read_byte();
        uart_write_byte(0x01);
        i2c_stop();
    }
    uart_write_byte(0x02);
    i2c_stop();
    i2c_stop();
    uart_write_byte(0x03); 
}

uint8_t i2c_send_byte(uint8_t data)
{
    I2C_DR -> DR = data; //Отправка данных
    while(!I2C_SR1 -> TXE)
    if(I2C_SR2 -> AF)
        return 1;
    return 0;//флаг ответа
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