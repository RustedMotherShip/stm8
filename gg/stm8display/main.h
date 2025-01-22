#ifndef _MAIN_H
#define _MAIN_H

#define I2C_DISPLAY_ADDR 0x3C
#define I2C_GY_302_ADDR 0x68
#include <stdint.h>

#include "pics/splash.h"

#include "libs/uart_lib.h"

#include "libs/i2c_lib.h"
void i2c_init(void);


#include "libs/ssd1306_lib.h"


#include "stm8.h"

#endif