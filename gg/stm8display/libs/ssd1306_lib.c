#include "ssd1306_lib.h"

int get_bit(int data,int bit)
{
    return ((data >> bit) & 1) ? 1 : 0;
}
int set_bit(int data,int bit, int value)
{
    int mask = 1 << bit ;
    switch(value)
    {
        case 1:
            data |= mask;
        break;

        default:
            data &= ~mask;
        break;
    }
    return data;
}

void ssd1306_init(void)
{

    uint8_t setup_buf[27] = {COMMAND, DISPLAY_OFF, 
                            SET_DISPLAY_CLOCK_DIV, 0x80,
                            SET_MULTIPLEX, 0x1F,
                            SET_DISPLAY_OFFSET, 0x00,
                            SET_START_LINE,
                            CHARGE_PUMP, 0x14,
                            VCOM_DETECT, 0x40,
                            DISPLAY_ALL_ON_RESUME,
                            NORMAL_DISPLAY,
                            SET_COM_PINS, 0x02,
                            SET_CONTRAST, 0x8F,
                            PRECHARGE_PERIOD, 0xF1,
                            MEMORY_MODE, 0x00,
                            SEG_REMAP,
                            COM_SCAN_DIR, 0x1F,
                            DISPLAY_ON};

    i2c_write(I2C_DISPLAY_ADDR, 27, setup_buf);
}

void ssd1306_set_params_to_write(void)
{
    uint8_t set_params_buf[7] = {COMMAND,
                                 SET_PAGE_ADDRESS,0x00,0x03,
                                 SET_COLUMN_ADDRESS,0x00,0x7F};

    i2c_write(I2C_DISPLAY_ADDR,7,set_params_buf);
}

void ssd1306_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color)
{
    buffer[x + ((y / 8) * SSD1306_LCDWIDTH)] = set_bit(buffer[x + ((y / 8) * SSD1306_LCDWIDTH)],(y % 8),color);
}

void ssd1306_buffer_clean(void)
{
    memset(buffer,0,512);
}
void ssd1306_send_buffer(void)
{
    for(int j = 0;j<4;j++)
    {
        if(i2c_send_address(I2C_DISPLAY_ADDR, 0))//Проверка на АСК бит
        {
            i2c_send_byte(SET_DISPLAY_START_LINE)
            for(int i = 0;i < 128;i++)
            {
                if(i2c_send_byte(buffer[i]))//Проверка на АСК бит
                {
                    break;//ошибка отправки нет ACK бита -> выход из цикла
                } 
            }
            i2c_stop();
        }
        else
        i2c_stop();
    }
}
void ssd1306_buffer_splash(void)
{

    ssd1306_set_params_to_write();
    uint8_t part[129]={SET_DISPLAY_START_LINE};

    for(int page = 0;page <= 384;page+=128)
    {
        for (int height = 0; height < 8; height++) 
        {
            for (int width = 0; width < 128; width++) 
            {
                ssd1306_draw_pixel(&part[1], width, height, get_bit(buffer[page+(height*16) + (width / 8)], 7 - (width % 8)));
            }
        }
    i2c_write(I2C_DISPLAY_ADDR, 129, part);
    }
}

void ssd1306_buffer_write(int x, int y, const uint8_t *data)
{
    uint8_t i, j, byteWidth = (w + 7) / 8;

    for (int height = 0; height < 8; height++)
    {
        for (int width = 0; width < 8; width++)
            if(data[j * byteWidth + i / 8] & (128 >> (i & 7)))
            ssd1306_draw_pixel(x + i, y + j, color);
    }
}

void ssd1306_clean(void)
{
    uint8_t clean_buf[129] = {SET_DISPLAY_START_LINE};
    //инициализация массива
    ssd1306_set_params_to_write();
    //установка адреса старта
    for(int i = 0;i<4;i++)
        i2c_write(I2C_DISPLAY_ADDR,129,clean_buf);
    //обнуление экрана
}