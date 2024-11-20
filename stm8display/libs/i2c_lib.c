#include "i2c_lib.h"
/*
 ___ ____   ____   
|_ _|___ \ / ___|  
 | |  __) | |      
 | | / __/| |___   
|___|_____|\____|  
*/

void delay(uint16_t ticks)
{
   while(ticks > 0)
   {
    ticks-=2;
    ticks+=1;
   } 
}
void trash_clean(void)
{
    uint8_t trash_reg = (unsigned char)I2C_DR;
    trash_reg = (unsigned char)I2C_SR1;
    trash_reg = (unsigned char)I2C_SR2;
    trash_reg = (unsigned char)I2C_SR3;
}
void i2c_init(void) {
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

void i2c_start(void) {
    I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
    while(!(I2C_SR1 -> SB));// Ожидание отправки стартового сигнала
}

uint8_t i2c_send_byte(unsigned char data){
    uart_write("start send byte\n");
    while (!(I2C_SR1 -> TXE));
    uart_write("while passed\n");
    I2C_DR -> DR = data;
    //while (!(I2C_SR1 -> TXE));
    uart_write("DR byte\n");
    int result = I2C_SR2 -> AF;
    return result;
}

uint8_t i2c_read_byte(unsigned char *data){
    while (!(I2C_SR1 -> RXNE));
    data = (unsigned char *)I2C_DR -> DR;
    return 0;
     
}

void i2c_stop(void) {
     I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
}

    
uint8_t i2c_send_address(uint8_t address,uint8_t rw_type) 
{
    i2c_start();
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
    I2C_DR -> DR = address;//Отправка адреса
    delay(250);
    (uint8_t)I2C_SR3;
    int result = I2C_SR1 -> ADDR;
    return result;
}

void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
{
    if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
    {
        uart_write("PIVO\n");
        for(int i = 0;i < size;i++)
        {
            uart_write("for\n");
            if(i2c_send_byte(data[i]))//Проверка на АСК бит
            {
                uart_write("error send byte\n");
                break;
            } 
            uart_write("if passed\n");    
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
        I2C_SR2 -> AF = 0; //Очистка флага ошибки
    }
    i2c_stop();
    return 0;
}