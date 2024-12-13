#include "main.h"
void setup(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    
    uart_init(9600,0);
    i2c_init();

    enableInterrupts();
}
int main(void)
{
    setup();
    
    uint8_t buf[5];
    buf[0] = 0xA4;
    buf[1] = 0xA5;
    buf[2] = 0xA6;
    buf[3] = 0xA7;
    buf[4] = 0xA8;
    i2c_write(0x66,5,buf);
    while(1);
    // uint8_t buf1[256] = {0};
    // buf1[0] = 0x01;
    // buf1[1] = 0x02;
    // i2c_write(I2C_DISPLAY_ADDR,25,buf1);
    
    // for(int i = 0;i < 256;i++)
    // {
    //     //i2c_write(I2C_DISPLAY_ADDR,2,buf);
    // }
    //return 0;
}

/*
 __  __________   ____  
|  \/   _   _  | |  _ \ 
| |\/| | | | | |_| |_) |
| |  | | | | |  _   _ < 
|_|  |_| |_| |_| |_| \_\
                    Inc. 
*/
