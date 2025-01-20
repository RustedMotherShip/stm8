#include "ssd1306_lib.h"

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
    setup_buf[2] = 0x00;
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
    buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
}

void display_buffer_fill_entire(uint8_t *in_data)
{

    display_set_params_to_write();
    uint8_t part[129]={0x40};

    for(int page = 0;page <= 384;page+=128)
    {
        for (int height = 0; height < 8; height++) 
        {
            for (int width = 0; width < 128; width++) 
            {
                display_draw_pixel(&part[1], width, height, get_bit(in_data[page+(height*16) + (width / 8)], 7 - (width % 8)));
            }
        }
    i2c_write(I2C_DISPLAY_ADDR, 129, part);
    }
}

void display_clean(void)
{
    uint8_t clean_buf[129] = {0x40};
    //инициализация массива
    display_set_params_to_write();
    //установка адреса старта
    for(int i = 0;i<4;i++)
        i2c_write(I2C_DISPLAY_ADDR,129,clean_buf);
    //обнуление экрана
}