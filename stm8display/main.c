#include "main.h"

int main(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    uart_init(9600,0);
    i2c_init();
    i2c_scan();
    uint8_t buf[1];
    buf[0] = 0xA4;
    i2c_write(I2C_DISPLAY_ADDR,1,buf);
    for(int i = 0;i < 256;i++)
    {
        i2c_write(I2C_DISPLAY_ADDR,1,buf);
    }
    return 0;
}

/*
 __  __________   ____  
|  \/   _   _  | |  _ \ 
| |\/| | | | | |_| |_) |
| |  | | | | |  _   _ < 
|_|  |_| |_| |_| |_| \_\
                    Inc. 
*/
