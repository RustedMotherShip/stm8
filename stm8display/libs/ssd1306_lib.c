#define I2C_DISPLAY_ADDR 0x3C

void setup_display(void)
{
	uint8_t setup_buf[7] = {0x00,0xAE,0xD5,0x80,0xA8,0x2E,0xAF}
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,5);
	setup_buf[1] = 0x1F;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0xD3;
	setup_buf[2] = 0x00;
	setup_buf[3] = 0x40;
	setup_buf[4] = 0x8D;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,5);
	setup_buf[1] = 0x14;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0xDB;
	setup_buf[2] = 0x40;
	setup_buf[3] = 0xA4;
	setup_buf[4] = 0xA6;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,5);
	setup_buf[1] = 0xDA;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0x02;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0x81;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0x8F;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0xD9;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0xF1;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
	setup_buf[1] = 0x20;
	setup_buf[2] = 0x00;
	setup_buf[3] = 0xA1;
	setup_buf[4] = 0xC8;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,5);
	setup_buf[1] = 0xA7;
	i2c_write(I2C_DISPLAY_ADDR,setup_buf,2);
}

// 0x00
// 0xAE
// 0xD5
// 0x80
// 0xA8
//stop
// 0x00
// 0x1F
//stop
// 0x00
// 0xD3
// 0x00
// 0x40
// 0x8D
//stop
// 0x00
// 0x14
//stop
// 0x00
// 0x20
// 0x00
// 0xA1
// 0xC8
//stop
// 0x00
// 0xDA
//stop
// 0x00
// 0x02
//stop
// 0x00
// 0x81
//stop
// 0x00
// 0x8F
//stop
// 0x00
// 0xD9
//stop
// 0x00
// 0xF1
//stop
// 0x00
// 0xDB
// 0x40
// 0xA4
// 0xA6
// 0x2E
// 0xAF
//stop
// 0x00
// 0xA7

uint8_t img[32] = {
  0b00000000,0b00000011,0b11000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000,
  0b00000000,0b00000010,0b01000000,0b00000000
}
uint8_t img_converted[32] = {
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b11111111,
  0b00000001,
  0b00000001,
  0b11111111,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000,
  0b00000000
}

ptr = &buf[0][0]