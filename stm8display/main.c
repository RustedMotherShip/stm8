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
    uint8_t buf[5] = {0};
    i2c_read(I2C_DISPLAY_ADDR,5,buf);
    buf[0] = 0xA4;
    buf[1] = 0xA5;
    buf[2] = 0xA6;
    buf[3] = 0xA7;
    buf[4] = 0xA8;
    i2c_write(I2C_DISPLAY_ADDR,5,buf);
    
    while(1);

}

/*
 __  __________   ____  
|  \/   _   _  | |  _ \ 
| |\/| | | | | |_| |_) |
| |  | | | | |  _   _ < 
|_|  |_| |_| |_| |_| \_\
                    Inc. 
*/
