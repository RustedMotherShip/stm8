#include "stm8.h"
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
/* Simple busy loop delay */
void delay(unsigned long count) {
    while (count--)
        nop();
}
void UART_TX(unsigned char value)
{
    UART1_DR = value;
    while(!(UART1_SR & UART_SR_TXE));
}
unsigned char UART_RX(void)
{   
    while(!(UART1_SR & UART_SR_RXNE));
    return UART1_DR;
}
int uart_write(const char *str) {
    char i;

    for(i = 0; i < strlen(str); i++) {
         // !Transmit data register empty
        UART_TX(str[i]);
    }
    return(i); // Bytes sent
}

void convert_int_to_binary(int num, char* rx_binary_chars) {
    // Проверяем каждый бит числа, начиная со старшего
    for(int i = 7; i >= 0; i--) {
        // Установка соответствующего бита в строке
        rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
    }
    rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
}

void status_check(void){
    char rx_binary_chars[9]={0};
    uart_write("UART_REGS >.<\n");
    convert_int_to_binary(UART1_SR, rx_binary_chars);
    uart_write("\nSR -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_DR, rx_binary_chars);
    uart_write("DR -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_BRR1, rx_binary_chars);
    uart_write("BRR1 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_BRR2, rx_binary_chars);
    uart_write("BRR2 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_CR1, rx_binary_chars);
    uart_write("CR1 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_CR2, rx_binary_chars);
    uart_write("CR2 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_CR3, rx_binary_chars);
    uart_write("CR3 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_CR4, rx_binary_chars);
    uart_write("CR4 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_CR5, rx_binary_chars);
    uart_write("CR5 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_GTR, rx_binary_chars);
    uart_write("GTR -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(UART1_PSCR, rx_binary_chars);
    uart_write("PSCR -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
}





void uart_init(void){
    CLK_CKDIVR = 0;

    // Setup UART1 (TX=D5)
    UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
    UART1_CR2 |= UART_CR2_REN; // Receiver enable
    UART1_CR2 |= UART_CR2_ILIEN; //String Enable
    UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
    // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683
    UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
}

int uart_read(void)
{
    //uart_write("Start");
    char buffer[256]={0};
    int i = 0;
    while(i<5)
    {
        //uart_write("While");
        if(UART1_SR & UART_SR_RXNE)
        {
        //status_check();//TXE RXNE IDLE OR/LHE
        //uart_write("IF PASSED\n");
        buffer[i] = UART_RX();
        //uart_write(&buffer[i]+'\0');
        //uart_write(" \n");
        //status_check();
        if(buffer[i] == '\r\n' || buffer[i] == '\0')
        {
            //uart_write("flag_S");
            return 1;
            break;
        }
        i++;
        }
        else
        {
        
        for(int g = 0;g < i; g++)
            UART_TX(buffer[g]);
        //status_check();
        break;
        }
    }
    //uart_write("End");
    return 0;
}

int main(void)
{
    uart_init();
    uart_write("ECHO START\n");
    while(uart_read()<1);
    uart_write("ECHO end\n");
    return 0;
}