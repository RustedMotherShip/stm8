#include "stm8.h"
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
char buffer[256] = {0};
uint8_t current_dev = 0;
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



void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
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

void status_check(void){
    char rx_binary_chars[9]={0};
    uart_write("\nI2C_REGS >.<\n");
    convert_int_to_binary(I2C_SR1, rx_binary_chars);
    uart_write("\nSR1 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(I2C_SR2, rx_binary_chars);
    uart_write("SR2 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(I2C_SR3, rx_binary_chars);
    uart_write("SR3 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(I2C_CR1, rx_binary_chars);
    uart_write("CR1 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(I2C_CR2, rx_binary_chars);
    uart_write("CR2 -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
    convert_int_to_binary(I2C_DR, rx_binary_chars);
    uart_write("DR -> ");
    uart_write(rx_binary_chars);
    uart_write(" <-\n");
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
    UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
    // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683
    UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
}



void i2c_init(void) {
    /* Set clock to full speed (16 Mhz) */
    

    // Включение I2C
    //----------- Setup I2C ------------------------
    I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
    I2C_FREQR= 16;                  // peripheral frequence =16MHz
    I2C_CCRH = 0;                   // =0
    I2C_CCRL = 80;                  // 100kHz for I2C
    I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
    I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
    I2C_OARH = I2C_OARH | 0x40;     // see reference manual
    I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
}
//I2C_CR2 = I2C_CR2 | (1 << 0)


void i2c_start(void) {
    I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
    while(!(I2C_SR1 & (1 << 0)));
    //uart_write("Start generated\n"); // Ожидание отправки стартового сигнала
}

void i2c_send_address(uint8_t address) {
    I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
    while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
}

void i2c_stop(void) {
    I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
    //uart_write("Stop generated\n");
}



void i2c_scan(void) {
    for (uint8_t addr = 1; addr < 127; addr++) {
        i2c_start();
        i2c_send_address(addr);
        if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
            // Адрес подтвержден, устройство найдено
            uart_write("SM ");
            char rx_int_chars[4]={0};
            convert_int_to_chars(addr, rx_int_chars);
            uart_write(rx_int_chars); 
            uart_write("\r\n");
            current_dev = addr;
            status_check();
        }
        i2c_stop();
        I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
        //delay(10000); // Небольшая задержка для стабилизации шины
    }
    //uart_write("Devs Not Found");
}


int uart_read(void)
{

    for(int o = 0; 0 < 256; o++)
    {
        buffer[o] = 0;
    }
    int i = 0;
    while(i < 256)
    {
        while(!(UART1_SR & UART_SR_RXNE));
        buffer[i] = UART1_DR;
        if(buffer[i] == '\n' || buffer[i] == '\0')
        {
            buffer[i] = '\0';
            uart_write("flag_S");
            return 1;
            break;
        }
        i++;
    }
    return 0;




    // for(int i = 0; i < 256; i++) {
    //     uart_write("flag1");
    //     while(!(UART1_SR & UART_SR_RXNE)); // !Transmit data register empty
    //     uart_write("flag2");
    //     //status_check();
        
    //     uart_write("flag3\n");
    //     char b[2]={UART1_DR,'\0'};
    //     uart_write(b);// + '\0');
    //     //status_check();

    //     uart_write("\n>buffer start<\n");
    //     // for(int i = 0; i < 256; i++)
    //     // {
    //     //     uart_write(&buffer[i] + '\0');
    //     //     uart_write("\n>____________<\n");
    //     // }
    //     // uart_write("> buffer end <");
    // }
    
    // return 0;
}


int main(void)
{
    uart_init();
    uart_write("SS\n");

    while(uart_read())
    {
        uart_write("\n>buffer start<\n");
        for(int i = 0; i < 256; i++)
        {
            uart_write(&buffer[i] + '\0');
            uart_write(" ");
        }
        uart_write("> buffer end <");
    }; 
    i2c_init();
    //status_check();

    //while (1) {
        i2c_scan(); 
    //}
        return 0;
}




// void i2c_send_address(uint8_t address) {
//     I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
//     // Ждем подтверждения адреса или таймаута
//     while (!(I2C_SR1 & I2C_SR1_ADDR) && !(I2C_SR1 & I2C_SR1_AF)); 
//     if (I2C_SR1 & I2C_SR1_ADDR) {
//         I2C_SR1 &= ~I2C_SR1_ADDR; // Очистка флага адреса, если он был установлен
//     }
// }