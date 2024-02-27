/* Simple "Hello World" UART output  */
#include <string.h>
#include <stdint.h>
#include "stm8.h"

/* Simple busy loop delay */
void delay(unsigned long count) {
    while (count--)
        nop();
}

int uart_write(const char *str) {
    char i;
    for(i = 0; i < strlen(str); i++) {
        while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
        UART1_DR = str[i];
    }
    return(i); // Bytes sent
}

int i2c_scan()
{

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
    I2C_CR1 = 0x01;  // Включаем I2C, настраиваем в режим мастера

    // Установка частоты передачи данных 100 кГц
    I2C_FREQR = 16;  // Устанавливаем частоту тактирования микроконтроллера (например, 16 МГц)
    I2C_CCRL = 0x50;  // Загружаем нижние 8 бит делителя для получения 100 кГц
    I2C_CCRH = 0x00;  // Обнуляем верхние биты делителя


    while(1) {
        uart_write("Hello World!\r\n");
        delay(400000L);
    }
}