#include "main.h"

void setup(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    
    uart_init(9600,0);
    i2c_init();

    enableInterrupts();
}

void gg(void)
{
    ssd1306_init();
    ssd1306_send_buffer();
    delay_s(1);

    menu_set_paragraph(menu);
    delay_s(1);

    //menu_set_paragraph(color);
    // delay_s(1);

    //menu_set_paragraph(segment);
    // delay_s(1);

    // menu_set_paragraph(settings);
    // delay_s(1);

    // menu_set_paragraph(menu);
    // delay_s(1);
    
    
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


