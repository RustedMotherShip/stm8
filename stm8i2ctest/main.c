#include "stm8.h"
#include <string.h>
#include <stdint.h>
#include <stdlib.h>

/*commands 
SS - program start
SM  - what source mounted(found)
SR (addr) (bytes) - read bytes from dev
SW (addr) (bytes) (byte 1) ... (bytes N) - write bytes to dev
SN - mount next dev
ST (addr) - set dev addr manually
RM - set dev number 0
DB - all registers check
*/
char buffer[255] = {0};
char a[3] = {0};
#define addr_p 3;
uint8_t d_addr = 0;
uint8_t p_size = 0;
uint8_t d_size = 0;
uint8_t p_bytes = 0;
uint8_t data_buf[255] = {0};
uint8_t current_dev = 119;
/* Simple busy loop delay */
void delay(unsigned long count) {
    while (count--)
        nop();
}
/*
 ______        __  ____  _____ _____ ____  
|  _ \ \      / / |  _ \| ____|  ___/ ___| 
| |_) \ \ /\ / /  | | | |  _| | |_  \___ \ 
|  _ < \ V  V /   | |_| | |___|  _|  ___) |
|_| \_\ \_/\_/    |____/|_____|_|   |____/ 
*/
void UART_TX(unsigned char value)
{
    UART1_DR = value;
    while(!(UART1_SR & UART_SR_TXE));
}
unsigned char UART_RX(void)
{
    while(!(UART1_SR & UART_SR_TXE));
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
int uart_read(void)
{
    memset(buffer, 0, sizeof(buffer));
    int i = 0;
    while(i<256)
    {
        if(UART1_SR & UART_SR_RXNE)
        {
        buffer[i] = UART_RX();
        if(buffer[i] == '\r\n' )
        {
            return 1;
            break;
        }
        i++;
        }
    }
    return 0;
}
/*
  ____ ___  _   ___     _______ ____ _____   ____  _____ _____ ____  
 / ___/ _ \| \ | \ \   / / ____|  _ \_   _| |  _ \| ____|  ___/ ___| 
| |  | | | |  \| |\ \ / /|  _| | |_) || |   | | | |  _| | |_  \___ \ 
| |__| |_| | |\  | \ V / | |___|  _ < | |   | |_| | |___|  _|  ___) |
 \____\___/|_| \_|  \_/  |_____|_| \_\|_|   |____/|_____|_|   |____/ 
*/

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
        rx_int_chars[2] ='\0'; // Заканчиваем строку символом конца строки
    } else {
        // Если число имеет одну цифру
        rx_int_chars[0] = num + '0';
        rx_int_chars[1] ='\0';
    }
}

uint8_t convert_chars_to_int(char* rx_chars_int, const int i) {
    uint8_t result = 0;

    for (int o = 0; o < i; o++) {
        
        result = (result * 10) + (rx_chars_int[o] - '0');
    }

    return result;
}


void convert_int_to_binary(int num, char* rx_binary_chars) {
    // Проверяем каждый бит числа, начиная со старшего
    for(int i = 7; i >= 0; i--) {
        // Установка соответствующего бита в строке
        rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
    }
    rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
}
/*
 ____  _   _ _____ _____ _____ ____    ____  _____ _____ ____  
| __ )| | | |  ___|  ___| ____|  _ \  |  _ \| ____|  ___/ ___| 
|  _ \| | | | |_  | |_  |  _| | |_) | | | | |  _| | |_  \___ \ 
| |_) | |_| |  _| |  _| | |___|  _ <  | |_| | |___|  _|  ___) |
|____/ \___/|_|   |_|   |_____|_| \_\ |____/|_____|_|   |____/ 
*/

void get_addr_from_buff(void)
{
    uint8_t counter = 0;
    uint8_t i = 3;
    while(1)
    {
        if(buffer[i] == ' ' || buffer[i] == '\r\n')
        {
            p_size = i+1;
            break;
        }
        i++;
        counter++;
    }
    memcpy(a, &buffer[3], counter);
    d_addr = convert_chars_to_int(a, counter);
}

void get_size_from_buff(void)
{
    memset(a, 0, sizeof(a));
    uint8_t counter = 0;
    uint8_t i = p_size;
    while(1)
    {
        if(buffer[i] == ' ' || buffer[i] == '\r\n')
        {

            p_bytes = i+1;
            break;
        }
        i++;
        counter++;
    }

    memcpy(a, &buffer[p_size], counter);
    d_size = convert_chars_to_int(a, counter);
}
void char_buffer_to_int(void)
{
    memset(a, 0, sizeof(a));
    uint8_t counter = d_size;
    uint8_t i = p_bytes;
    uint8_t int_buf_i = 0;

    for(int o = 0; o < counter;o++)
    {
    uint8_t number_counter = 0;
    while(1)
    {
        if(buffer[i] == ' ')
        {
            i++;
            break;
        }
        else if(buffer[i] == '\r\n')
            break;
        else
            i++;
        
        number_counter++;
    }
    memcpy(a, &buffer[i - number_counter], number_counter);
    data_buf[int_buf_i] = convert_chars_to_int(a, number_counter);
    int_buf_i++;
    }
}
/*
 ____ _____ __  __  ___    ____  _____ _____ ____  
/ ___|_   _|  \/  |( _ )  |  _ \| ____|  ___/ ___| 
\___ \ | | | |\/| |/ _ \  | | | |  _| | |_  \___ \ 
 ___) || | | |  | | (_) | | |_| | |___|  _|  ___) |
|____/ |_| |_|  |_|\___/  |____/|_____|_|   |____/ 
*/
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
/*
 ___ ____   ____   ____  _____ _____ ____  
|_ _|___ \ / ___| |  _ \| ____|  ___/ ___| 
 | |  __) | |     | | | |  _| | |_  \___ \ 
 | | / __/| |___  | |_| | |___|  _|  ___) |
|___|_____|\____| |____/|_____|_|   |____/ 
*/

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
void i2c_write(void){
    I2C_DR = d_addr; // Отправка адреса регистра
    for(int i = 0;i < d_size;i++)
    {
        I2C_DR = data_buf[i];
        while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
    }
}

void i2c_read(void){
    I2C_DR = (current_dev << 1) & (1 << 0);
    while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));

    I2C_DR = d_addr;
    while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
    i2c_stop();
    for(int i = 0;i < d_size;i++)
    {
        data_buf[i] = I2C_DR;
        while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));

    }
}
void i2c_scan(void) {
    for (uint8_t addr = current_dev; addr < 127; addr++) {
        i2c_start();
        i2c_send_address(addr);
        if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
            // Адрес подтвержден, устройство найдено
            current_dev = addr;
            i2c_stop();
            break;
        }
        i2c_stop();
        I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
    }
}


/*
  ____ ___  __  __ __  __    _    _   _ ____    ____  _____ _____ ____  
 / ___/ _ \|  \/  |  \/  |  / \  | \ | |  _ \  |  _ \| ____|  ___/ ___| 
| |  | | | | |\/| | |\/| | / _ \ |  \| | | | | | | | |  _| | |_  \___ \ 
| |__| |_| | |  | | |  | |/ ___ \| |\  | |_| | | |_| | |___|  _|  ___) |
 \____\___/|_|  |_|_|  |_/_/   \_\_| \_|____/  |____/|_____|_|   |____/ 
*/
void cm_SM(void)
{
    char cur_dev[4]={0};
    convert_int_to_chars(current_dev, cur_dev);
    uart_write("SM ");
    uart_write(cur_dev);
    uart_write("\r\n");
}
void cm_SN(void)
{
    i2c_scan();
    cm_SM();
}
void cm_RM(void)
{
    current_dev = 0;
    uart_write("RM\n");
}

void cm_DB(void)
{
    status_check();
}

void cm_ST(void)
{
    get_addr_from_buff();
    current_dev = d_addr;
    uart_write("ST\n");
}
void cm_SR(void)
{
    i2c_start();
    i2c_send_address(current_dev);
    i2c_read();
    i2c_stop();
}
void cm_SW(void)
{
    char ar[4]={0};
    i2c_start();
    i2c_send_address(current_dev);
    i2c_write();
    i2c_stop();
    uart_write("SW ");
    convert_int_to_chars(d_addr, ar);
    uart_write(ar);
    uart_write(" ");
    convert_int_to_chars(d_size, ar);
    uart_write(ar);
    uart_write("\r\n");
}
/*
 ____    _  _____  _      _   _    _    _   _ ____  _     _____ ____  
|  _ \  / \|_   _|/ \    | | | |  / \  | \ | |  _ \| |   | ____|  _ \ 
| | | |/ _ \ | | / _ \   | |_| | / _ \ |  \| | | | | |   |  _| | |_) |
| |_| / ___ \| |/ ___ \  |  _  |/ ___ \| |\  | |_| | |___| |___|  _ < 
|____/_/   \_\_/_/   \_\ |_| |_/_/   \_\_| \_|____/|_____|_____|_| \_\
*/
int data_handler(void)
{
    p_size = 0;
    p_bytes = 0;
    d_addr = 0;
    d_size = 0;
    memset(a, 0, sizeof(a));
    memset(data_buf, 0, sizeof(data_buf));
    if(memcmp(&buffer[0],"SM",2) == 0)
        return 1;
    if(memcmp(&buffer[0],"SN",2) == 0)
        return 2;
    if(memcmp(&buffer[0],"ST",2) == 0)
        return 5;
    if(memcmp(&buffer[0],"RM",2) == 0)
        return 6;
    if(memcmp(&buffer[0],"DB",2) == 0)
        return 7;

    get_addr_from_buff();
    get_size_from_buff();

    if(memcmp(&buffer[0],"SR",2) == 0)
        return 3;

    char_buffer_to_int();

    if(memcmp(&buffer[0],"SW",2) == 0)
        return 4;
    return 0;

}

void command_switcher(void)
{
    char ar[4]={0};

    switch(data_handler())
    {
        case 1:
            cm_SM();
        break;
        case 2:
            cm_SN();
        break;
        case 3:
            cm_SR();
        break;
        case 4:
            cm_SW();
        break;
        case 5:
            cm_ST();
        break;
        case 6:
            cm_RM();
        break;
        case 7:
            cm_DB();
        break;
    }
}


void main(void)
{
    uart_init();
    i2c_init();
    uart_write("SS\n");
    while(1)
    {
        uart_read();
        command_switcher();
    }; 
}
/*
 __  __________   ____  
|  \/   _   _  | |  _ \ 
| |\/| | | | | |_| |_) |
| |  | | | | |  _   _ < 
|_|  |_| |_| |_| |_| \_\
                    Inc. 
*/