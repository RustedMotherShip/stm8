#include <stdint.h>

#include "i2c_lib.h"
#define WHITE 1
#define BLACK 0
#define SSD1306_LCDWIDTH 128
#define SSD1306_LCDHEIGHT 32
#define I2C_DISPLAY_ADDR 0x3C

void display_init(void);
void display_set_params_to_write(void);
void display_draw_pixel(uint8_t *buffer, uint8_t x, uint8_t y, uint8_t color);
void display_buffer_fill_entire(uint8_t *in_data);
void display_clean(void);