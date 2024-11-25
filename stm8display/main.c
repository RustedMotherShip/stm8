#include "main.h"

int main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    uart_init(9600,0);
    i2c_init();
    //i2c_scan();
    uint8_t buf[2];
    buf[0] = 0xA4;
    buf[1] = 0xA5;
    //i2c_write(I2C_DISPLAY_ADDR,2,buf);

    uint8_t buf1[256] = {0};
    buf1[0] = 0x01;
    buf1[1] = 0x02;
    i2c_write(I2C_DISPLAY_ADDR,25,buf1);
    while(1);
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
