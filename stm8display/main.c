#include "main.h"

char buffer[256] = {0};
char a[3] = {0};


void uart_init(void){
    CLK_CKDIVR = 0;

    // Setup UART1 (TX=D5)
    UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
    UART1_CR2 |= UART_CR2_REN; // Receiver enable
    UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
    // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683
    UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
}

// void UART_TX(unsigned char value)
// {
//     UART1_DR = value;
//     while(!(UART1_SR & UART_SR_TXE));
// }

// int uart_write(const char *str) {
//     char i;
//     for(i = 0; i < strlen(str); i++) {
//          // !Transmit data register empty
//         UART_TX(str[i]);
//     }
    
//     return(i); // Bytes sent
// }
unsigned char UART_RX(void)
{
    //uart_write("RX_start\n");
    while(!(UART1_SR & UART_SR_TXE));
    //uart_write("while end\n");
    return UART1_DR;
}
int uart_read(void)
{
    //uart_write("Start reading\n");
    memset(buffer, 0, sizeof(buffer));
    //uart_write("memset\n");
    int i = 0;
    while(i<256)
    {
        
        if(UART1_SR & UART_SR_RXNE)
        {
        //uart_write("if\n");
        buffer[i] = UART_RX();
        if(buffer[i] == '\r')
        {
            return 1;
            break;
        }
        if(buffer[i] < 32 || buffer[i] > 126);
        else
            i++;
        }
    }
    //uart_write("end\n");
    return 0;
}

int main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    uart_init();
    i2c_init();     

    while(1) {
        uart_write("1-> ");
        uart_write((unsigned char *)i2c_scan());
        uart_write(" <-\n");
    }
}

/*
 __  __________   ____  
|  \/   _   _  | |  _ \ 
| |\/| | | | | |_| |_) |
| |  | | | | |  _   _ < 
|_|  |_| |_| |_| |_| \_\
                    Inc. 
*/
