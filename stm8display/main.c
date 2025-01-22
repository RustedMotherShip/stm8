    #include "main.h"
//#include "pics/splash.h"

void setup(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    
    uart_init(9600,0);
    //i2c_init();

    enableInterrupts();
}



void gg(void)
{
    //display_init();
    //display_clean();
    //display_buffer_fill_entire(splash);
    uart_write_byte(0xAA);
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