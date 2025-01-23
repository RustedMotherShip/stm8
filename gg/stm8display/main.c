#include "main.h"

void setup(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    
    //uart_init(9600,0);
    i2c_init();

    enableInterrupts();
}

void gg(void)
{
    ssd1306_init();
    ssd1306_clean();
    ssd1306_buffer_splash();
    
}
 
int main(void)
{
    setup();
    gg();
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