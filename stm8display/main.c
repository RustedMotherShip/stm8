#include "main.h"

void params_default_conf(void)
{
    params_value.current_red = 255;
    params_value.current_green = 255;
    params_value.current_blue = 255;

    params_value.current_first = 0;
    params_value.current_second = 15;

    params_value.current_sens = 10;
    params_value.current_vers = 0xA1;
}

void setup(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    
    params_value.all = 0;

    uart_init(9600,0);
    i2c_init();
    ssd1306_init();
    ssd1306_send_buffer();
    params_default_conf();

    enableInterrupts();
    delay_s(1);
}


void gg(void)
{
    menu_set_paragraph(menu);
    delay_s(1);

    menu_set_paragraph(color);
    delay_s(1);

    // menu_set_paragraph(segment);
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


