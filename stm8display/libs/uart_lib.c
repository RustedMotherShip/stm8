#include "uart_lib.h"
void uart_write(uint8_t *data_buf);
void uart_transmission_irq(void) __interrupt(UART1_T_vector)
{
  if(UART1_SR -> TXE) 
  {
    if(tx_buf_pointer[buf_pos] != '\0' && buf_size>buf_pos)
      UART1_DR -> DR = tx_buf_pointer[buf_pos++];
    else {
      UART1_CR2 -> TIEN = 0;
    }
  }
    
}
void uart_reciever_irq(void) __interrupt(UART1_R_vector)
{
  
  uint8_t trash_reg = 0;
  if(UART1_SR -> RXNE)
  {
    trash_reg = UART1_DR -> DR;
    if(trash_reg != '\n' && buf_size>buf_pos)
      rx_buf_pointer[buf_pos++] = trash_reg;
    else {
      UART1_CR2 -> RIEN = 0;
    }
  }
    
}
void uart_init(unsigned int baudrate,uint8_t stopbit)
{

    // Setup UART1 (TX=D5)
    UART1_CR2 -> TEN = 1; // Transmitter enable
    UART1_CR2 -> REN = 1; // Receiver enable
    switch(stopbit)
    {
        case 2:
            UART1_CR3 -> STOP = 2;
        break;
        case 3:
            UART1_CR3 -> STOP = 3;
        break;
        default:
            UART1_CR3 -> STOP = 0;
        break;
    }
    switch(baudrate)
    {
    case (unsigned int)2400:
        UART1_BRR2 -> MSB = 0x01;
        UART1_BRR1 -> DIV = 0xA0;
        UART1_BRR2 -> LSB = 0x0B; 
    break;
    case (unsigned int)19200:
        UART1_BRR1 -> DIV = 0x34;
        UART1_BRR2 -> LSB = 0x01;
    break;
    case (unsigned int)57600:
        UART1_BRR1 -> DIV = 0x11;
        UART1_BRR2 -> LSB = 0x06;
    break;
    case (unsigned int)115200:
        UART1_BRR1 -> DIV = 0x08;
        UART1_BRR2 -> LSB = 0x0B;
    break;
    case (unsigned int)230400:
        UART1_BRR1 -> DIV = 0x04;
        UART1_BRR2 -> LSB = 0x05;
    break;
    case (unsigned int)460800:
        UART1_BRR1 -> DIV = 0x02;
        UART1_BRR2 -> LSB = 0x03;
    break;
    case (unsigned int)921600:
        UART1_BRR1 -> DIV = 0x01;
        UART1_BRR2 -> LSB = 0x01;
    break;
    default:
        UART1_BRR1 -> DIV = 0x68;
        UART1_BRR2 -> LSB = 0x03;
    break;
    }
}

int uart_read_byte(uint8_t *data)
{
    while(!(UART1_SR -> RXNE));
    data = (uint8_t *)UART1_DR -> DR;
    return 1;
}

int uart_write_byte(uint8_t data)
{
    UART1_DR -> DR = data;
    while(!(UART1_SR -> TXE));
    return 1;
}

void uart_write(uint8_t *data_buf)
{
  tx_buf_pointer = data_buf;
  buf_pos = 0;
  buf_size = 0;
  while (data_buf[buf_size++] != '\0');
  UART1_CR2 -> TIEN = 1;
  while(UART1_CR2 -> TIEN);
}
void uart_read(uint8_t *data_buf,int size)
{
    rx_buf_pointer = data_buf;
    uart_write("rx_buf_pointer\n");
    buf_pos = 0;
    uart_write("buf_pos\n");
    buf_size = size;
    uart_write("buf_size\n");
    UART1_CR2 -> RIEN = 1;
    uart_write("RIEN\n");
    while(UART1_CR2 -> RIEN);
}




// #include "uart_lib.h"

// void uart_init(unsigned int baudrate,uint8_t stopbit)
// {

//     // Setup UART1 (TX=D5)
//     UART1_CR2 -> TEN = 1; // Transmitter enable
//     UART1_CR2 -> REN = 1; // Receiver enable
//     switch(stopbit)
//     {
//         case 2:
//             UART1_CR3 -> STOP = 2;
//         break;
//         case 3:
//             UART1_CR3 -> STOP = 3;
//         break;
//         default:
//             UART1_CR3 -> STOP = 0;
//         break;
//     }
//     switch(baudrate)
//     {
//     case (unsigned int)2400:
//         UART1_BRR2 -> MSB = 0x01;
//         UART1_BRR1 -> DIV = 0xA0;
//         UART1_BRR2 -> LSB = 0x0B; 
//     break;
//     case (unsigned int)19200:
//         UART1_BRR1 -> DIV = 0x34;
//         UART1_BRR2 -> LSB = 0x01;
//     break;
//     case (unsigned int)57600:
//         UART1_BRR1 -> DIV = 0x11;
//         UART1_BRR2 -> LSB = 0x06;
//     break;
//     case (unsigned int)115200:
//         UART1_BRR1 -> DIV = 0x08;
//         UART1_BRR2 -> LSB = 0x0B;
//     break;
//     case (unsigned int)230400:
//         UART1_BRR1 -> DIV = 0x04;
//         UART1_BRR2 -> LSB = 0x05;
//     break;
//     case (unsigned int)460800:
//         UART1_BRR1 -> DIV = 0x02;
//         UART1_BRR2 -> LSB = 0x03;
//     break;
//     case (unsigned int)921600:
//         UART1_BRR1 -> DIV = 0x01;
//         UART1_BRR2 -> LSB = 0x01;
//     break;
//     default:
//         UART1_BRR1 -> DIV = 0x68;
//         UART1_BRR2 -> LSB = 0x03;
//     break;
//     }
// }

// int uart_read_byte(uint8_t *data)
// {
//     while(!(UART1_SR -> RXNE));
//     data = (uint8_t *)UART1_DR -> DR;
//     return 1;
// }

// int uart_write_byte(uint8_t data)
// {
//     UART1_DR -> DR = data;
//     while(!(UART1_SR -> TXE));
//     return 1;
// }

// int uart_write(uint8_t *data_buf)
// {
//     int count = 0;
//     for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
//     count += uart_write_byte(data_buf[i]);
//     return count;
// }
// int uart_read(uint8_t *data_buf)
// {
//     int count = 0;
//     for (int i = 0; data_buf[i] != '\0'; i++) // Цикл до нулевого терминатора
//     count += uart_read_byte((unsigned char *)data_buf[i]);
//     return count;
// }
