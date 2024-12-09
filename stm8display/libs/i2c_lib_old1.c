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
    uint8_t trash_reg = (uint8_t)I2C_SR3;
    trash_reg = (uint8_t)I2C_DR;
    trash_reg = (uint8_t)I2C_SR1;
    trash_reg = (uint8_t)I2C_SR2;
    
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
    //trash_clean();
    data;
    trash_clean();
    uart_write("byte -");
    uart_write((unsigned char *)I2C_DR);
    uart_write("\n");
    while (!(I2C_SR1 -> TXE));
    I2C_DR -> DR = 0x28;
    trash_clean();
    uart_write("byte send\n");
    while(!(I2C_SR1 -> BTF));
    trash_clean();
    //while (!(I2C_SR1 -> BTF));
    int result = I2C_SR2 -> AF;
    uart_write("DR byte\n");
    // (uint8_t)I2C_SR3;
    // (uint8_t)I2C_DR;
    //int result = 0;
    uart_write("AF -> ");
    uart_write((result ? "1" : "0"));
    uart_write("\n");
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
    uart_write("WHILE start\n");
    while (!(I2C_SR1 -> ADDR) && !(I2C_SR2 -> AF));
    (uint8_t)I2C_SR3;
    uart_write("WHILE passed\n");  
    return I2C_SR1 -> ADDR;
}

void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data)
{
    if(i2c_send_address(dev_addr, 0))//Проверка на АСК бит
    {

        uart_write("PIVO\n");
        uart_write("predfor\n");
        //while (!(I2C_SR1 -> TXE));
        data;
        size;
        for(int i = 0;i < 25;i++)
        {
            uart_write("for\n");
            i2c_send_byte(0x29);//Проверка на АСК бит
            //uart_write("for2\n");
            //i2c_send_byte(0x28);//Проверка на АСК бит
            // {
            //     uart_write("error send byte\n");
            //     break;
            // }
            //uart_write("if passed\n");    
        }
        uart_write("postforif\n");
    }
    uart_write("predstop\n");
    //while (!(I2C_SR1 -> TXE) && !(I2C_SR1 -> BTF));
    i2c_stop();
    uart_write("poststop\n");
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