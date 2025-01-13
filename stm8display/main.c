#include "main.h"
#include "pics/splash.h"

void setup(void)
{
    /* Set clock to full speed (16 Mhz) */
    CLK_CKDIVR = 0;
    
    uart_init(9600,0);
    i2c_init();

    enableInterrupts();
}

void delay(uint16_t ticks)
{
   while(ticks > 0)
   {
    ticks-=2;
    ticks+=1;
   } 
}

void display_init(void)
{
    uint8_t setup_buf[7] = {0x00,0xAE,0xD5,0x80,0xA8,0x1F,0xAF};
    i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
    setup_buf[1] = 0x1F;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0xD3;
    setup_buf[2] = 0x00;
    setup_buf[3] = 0x40;
    setup_buf[4] = 0x8D;
    i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
    setup_buf[1] = 0x14;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0xDB;
    setup_buf[2] = 0x40;
    setup_buf[3] = 0xA4;
    setup_buf[4] = 0xA6;
    i2c_write(I2C_DISPLAY_ADDR,5,setup_buf);
    setup_buf[1] = 0xDA;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0x02;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0x81;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0x8F;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0xD9;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0xF1;
    i2c_write(I2C_DISPLAY_ADDR,2,setup_buf);
    setup_buf[1] = 0x20;
    setup_buf[2] = 0x01;
    setup_buf[3] = 0xA1;
    setup_buf[4] = 0xC8;
    i2c_write(I2C_DISPLAY_ADDR,7,setup_buf);
}

void display_set_params_to_write(void)
{
    uint8_t set_params_buf[8] = {0x00,0x22,0x00,0x03,0x00,0x21,0x00,0x7F};
    i2c_write(I2C_DISPLAY_ADDR,8,set_params_buf);
}
#define WHITE 1
#define BLACK 0
#define SSD1306_LCDWIDTH 128
#define SSD1306_LCDHEIGHT 32

void display_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
{

  switch(color)
  {
    case WHITE:
      buffer[x + (y / 8) * SSD1306_LCDWIDTH] |=  (1 << (y & 7));
      break;
    case BLACK:
      buffer[x + (y / 8) * SSD1306_LCDWIDTH] &= ~(1 << (y & 7));
      break;
    default:
      break;
  }
}

void display_buffer_fill(uint8_t x, uint8_t y,uint8_t *in_data, uint8_t *out_data,uint8_t width, uint8_t height, uint8_t color)
{
  uint8_t byteWidth = (width + 7) / 8;

  for(int j = 0; j < height; j++) {
    for(int i = 0; i < width; i++) {
      if(in_data[j * byteWidth + i / 8] & (128 >> (i & 7)))
        display_draw_pixel(out_data,x + i, y + j, color);
    }
  }
}


void display_set(uint8_t **data)
{
    data;
    display_set_params_to_write();
    for (int i = 0; i < 512; i += 32) 
    {
        uint8_t set_buf[33] = {0x40};
        for(int o = 0; o < 32; o++)
            set_buf[o+1] = data[i+o][1];
        i2c_write(I2C_DISPLAY_ADDR,33,set_buf);
    }
}

void display_clean(void)
{
    uint8_t clean_buf[33] = {0x40};
    //инициализация массива
    display_set_params_to_write();
    //установка адреса старта
    for(int i = 0;i<16;i++)
        i2c_write(I2C_DISPLAY_ADDR,33,clean_buf);
    //обнуление экрана
}

void gg(void)
{
    display_init();

    display_clean();
    uint8_t buffer[512] = {0};
    display_buffer_fill(0,0,splash,buffer,128,32,WHITE);
    //display_set(buffer);
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






void display_splash(void)
{
    uint8_t black_buf[9] = {0x40};
    uint8_t white_buf[9] = {0x40};
    for(int i = 1;i<9;i++)
        white_buf[i] = 0xFF;
    display_set_params_to_write();
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    //
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    //
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    //
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,white_buf);
    i2c_write(I2C_DISPLAY_ADDR,9,black_buf);

    //обнуление экрана
}