#include "stm8.h"
#include <string.h>
#include <stdint.h>
/* Simple busy loop delay */
void delay(unsigned long count) {
    while (count--)
        nop();
}

int uart_write_line(const char *str) {
    char i;
    for(i = 0; i < strlen(str); i++) {
        while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
        UART1_DR = str[i];
    }
    return(i); // Bytes sent
}

void uart_write_char(char str_char) {
    while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
        UART1_DR = str_char;
    }


int main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;

    // Setup UART1 (TX=D5)
    UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
    // UART1_CR2 |= UART_CR2_REN; // Receiver enable
    UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
    // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683
    UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)

    // Включение I2C
    I2C_CR1 = 0x01;  // включаем подключение к шине
    I2C_FREQR = 0x01;  
    I2C_CCRL = 0x50;  // Загружаем нижние 8 бит делителя для получения 100 кГц
    I2C_CCRH = 0x00;  // Обнуляем верхние биты делителя


    //while(1) {
        uart_write_line("Start Scanning\n");

        for(char addr = 0x00; addr < 0xFF;addr++)
        {
            //char buff[2] = {&addr, 0}
            uart_write_line("_______Start______\n");
            uart_write_line("Dev ->  ");
            uart_write_char(addr);
            uart_write_line("  <- Dev\n");
            //uart_write(&buff);
            //if(I2C_DR >> 7 == 1)
            I2C_DR = addr;
            //uart_write_line("Status 1 - " + I2C_SR1 + "\n\0");
            //uart_write_char(I2C_SR1)
            //uart_write_line("Status 2 - " + I2C_SR2 + '\n\0');
            //uart_write_line("Status 3 - " + I2C_SR3 + '\n\0');
            uart_write_line("_______Stop_______\n");
            delay(1000000L);

        }
        
    //}
}