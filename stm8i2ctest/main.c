#include "stm8.h"
#include <string.h>
#include <stdint.h>
#include <stdlib.h>

/* Simple busy loop delay */
void delay(unsigned long count) {
    while (count--)
        nop();
}

void convert_int_to_chars(int num, char* rx_int_chars) {
    if (num > 99) {
        // Если число имеет три цифры
        rx_int_chars[0] = num / 100 + '0';
        rx_int_chars[1] = num / 10 % 10 + '0';
        rx_int_chars[2] = num % 10 + '0';
        rx_int_chars[3] ='\0';

    } else if (num > 9) {
        // Если число имеет две цифры
        rx_int_chars[0] = num / 10 + '0';
        rx_int_chars[1] = num % 10 + '0';
        rx_int_chars[2] ='\0';

        //rx_int_chars[3] = '\0'; // Заканчиваем строку символом конца строки
    } else {
        // Если число имеет одну цифру
        rx_int_chars[0] = num + '0';
        rx_int_chars[1] ='\0';
    }
}

void convert_int_to_binary(int num, char* rx_binary_chars) {
    // Проверяем каждый бит числа, начиная со старшего
    for(int i = 7; i >= 0; i--) {
        // Установка соответствующего бита в строке
        rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
    }
    rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
}




int uart_write_line(const char *str) {
    char i;
    for(i = 0; i < strlen(str); i++) {
        while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
        UART1_DR = str[i];
    }
    return(i); // Bytes sent
}

void status_check(void){
    char rx_binary_chars[9]={0};
    convert_int_to_binary(I2C_SR1, rx_binary_chars);
    uart_write_line("SR1 -> ");
    uart_write_line(rx_binary_chars);
    uart_write_line(" <-\n");
    convert_int_to_binary(I2C_SR2, rx_binary_chars);
    uart_write_line("SR2 -> ");
    uart_write_line(rx_binary_chars);
    uart_write_line(" <-\n");
    convert_int_to_binary(I2C_SR3, rx_binary_chars);
    uart_write_line("SR3 -> ");
    uart_write_line(rx_binary_chars);
    uart_write_line(" <-\n");
    convert_int_to_binary(I2C_CR1, rx_binary_chars);
    uart_write_line("CR1 -> ");
    uart_write_line(rx_binary_chars);
    uart_write_line(" <-\n");
    convert_int_to_binary(I2C_CR2, rx_binary_chars);
    uart_write_line("CR2 -> ");
    uart_write_line(rx_binary_chars);
    uart_write_line(" <-\n");
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
    //----------- Setup I2C ------------------------
    I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
    //I2C_FREQR= 16;                  // peripheral frequence =16MHz
    //I2C_CCRH = 0;                   // =0
    //I2C_CCRL = 80;                  // 100kHz for I2C
    I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
    I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
    I2C_OARH = I2C_OARH | 0x40;     // see reference manual
    I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
    status_check();
    //------------- End Setup --------------------- // Обнуляем верхние биты делителя

    //
    //while(1) {
        uart_write_line("Start Scanning\n");

        for(uint8_t addr = 0x00; addr < 0xFF;addr++)
        {
            //char buff[2] = {&addr, 0}
            uart_write_line("_______Start______\n");
            uart_write_line("Dev ->  ");
            char rx_int_chars[4]={0};
            
            convert_int_to_chars(addr, rx_int_chars);
            uart_write_line(rx_int_chars);
            uart_write_line("  <- Dev\n");
            //status_check();
            //uart_write(&buff);
            //if(I2C_DR >> 7 == 1)
            //uart_write_line("flag-2\n");
            //status_check();
            I2C_CR2 = I2C_CR2 | (1 << 2); // Set ACK bit
            //uart_write_line("flag-1\n");
            //status_check();
            I2C_CR2 = I2C_CR2 | (1 << 0); // START
            //uart_write_line("flag0\n");
            //status_check();
            while (!(I2C_SR1 & (1 << 0)));
            //uart_write_line("flag1\n");

            //I2C_SR1 = I2C_SR1 | 0x00;
            I2C_DR = I2C_DR | addr;
            //status_check();
            //uart_write_line("flag2\n");

            //uart_write_line("Status 1 - " + I2C_SR1 + "\n\0");

            //while (!(I2C_SR1 & (1 << 1)));
            I2C_SR1 = 0x00;
            I2C_SR3 = 0x00;
            I2C_CR2 = I2C_CR2 | (1 << 1); // STOP
            status_check();
            //uart_write_line("Status 2 - " + I2C_SR2 + '\n\0');
            //uart_write_line("Status 3 - " + I2C_SR3 + '\n\0');
            uart_write_line("_______Stop_______\n");
            //delay(1000000L);

        }
        
    //}
        return 0;
}


