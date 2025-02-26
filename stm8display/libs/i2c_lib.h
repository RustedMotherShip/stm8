#ifndef _I2C_LIB_H
#define _I2C_LIB_H

#include <stdint.h>

struct I2C_CR1_
{
	uint8_t PE:1;
	uint8_t reserve:5;
	uint8_t ENGC:1;
	uint8_t NOSTRETCH:1;
	
} typedef I2C_CR1_t;

struct I2C_CR2_
{
	uint8_t START:1;
	uint8_t STOP:1;
	uint8_t ACK:1;
	uint8_t POS:1;
	uint8_t reserve:3;
	uint8_t SWRST:1;

} typedef I2C_CR2_t;

struct I2C_FREQR_
{
	uint8_t FREQ:6;
	uint8_t reserve:2;

} typedef I2C_FREQR_t;

struct I2C_OARL_
{
	uint8_t RW_ADD:1;
	uint8_t ADD:7;
	
} typedef I2C_OARL_t;

struct I2C_OARH_
{
	uint8_t ADDCONF:1;
	uint8_t reserve:3;
	uint8_t ADD:2;
	uint8_t reserve1:1;
	uint8_t ADDMODE:1;

} typedef I2C_OARH_t;

struct I2C_DR_
{
	uint8_t DR;
	
} typedef I2C_DR_t;

struct I2C_SR1_
{
	uint8_t SB:1;
	uint8_t ADDR:1;
	uint8_t BTF:1;
	uint8_t ADD10:1;
	uint8_t STOPF:1;
	uint8_t reserve:1;
	uint8_t RXNE:1;
	uint8_t TXE:1;

} typedef I2C_SR1_t;

struct I2C_SR2_
{
	uint8_t BERR:1;
	uint8_t ARLO:1;
	uint8_t AF:1;
	uint8_t OVR:1;
	uint8_t reserve:1;
	uint8_t WUFH:1;
	uint8_t reserve1:2;

} typedef I2C_SR2_t;

struct I2C_SR3_
{
	uint8_t MSL:1;
	uint8_t DUALF:1;
	uint8_t reserve:2;
	uint8_t GENCALL:1;
	uint8_t reserve1:1;
	uint8_t TRA:1;
	uint8_t BUSY:1;
	
} typedef I2C_SR3_t;

struct I2C_ITR_
{
	uint8_t ITERREN:1;
	uint8_t ITEVTEN:1;
	uint8_t ITBUFEN:1;
	uint8_t reserve:5;
	
} typedef I2C_ITR_t;

struct I2C_CCRL_
{
	uint8_t CCR;
	
} typedef I2C_CCRL_t;

struct I2C_CCRH_
{
	uint8_t CCR:4;
	uint8_t reserve:2;
	uint8_t DUTY:1;
	uint8_t FS:1;
	
} typedef I2C_CCRH_t;

struct I2C_TRISER_
{
	uint8_t TRISE:6;
	uint8_t reserve:2;
	
} typedef I2C_TRISER_t;

struct I2C_IRQ_
{
	union
	{
		uint8_t all;
		struct {
			uint8_t SB:1;
			uint8_t ADDR:1;
			uint8_t BTF:1;
			uint8_t RXNE:1;
			uint8_t TXE:1;
			uint8_t AF:1;
			uint8_t reserve:2;
		};
	};
	
} typedef I2C_IRQ_t;
/* I2C */
#define I2C_CR1 ((I2C_CR1_t *)0x5210)
#define I2C_CR2 ((I2C_CR2_t *)0x5211)
#define I2C_FREQR ((I2C_FREQR_t *)0x5212)
#define I2C_OARL ((I2C_OARL_t *)0x5213)
#define I2C_OARH ((I2C_OARH_t *)0x5214)
#define I2C_DR ((I2C_DR_t *)0x5216)
#define I2C_SR1 ((I2C_SR1_t *)0x5217)
#define I2C_SR2 ((I2C_SR2_t *)0x5218)
#define I2C_SR3 ((I2C_SR3_t *)0x5219)
#define I2C_ITR ((I2C_ITR_t *)0x521A)
#define I2C_CCRL ((I2C_CCRL_t *)0x521B)
#define I2C_CCRH ((I2C_CCRH_t *)0x521C)
#define I2C_TRISER ((I2C_TRISER_t *)0x521D)
#define I2C_PECR ((I2C_PECR_t *)0x521E)

#define I2C_vector 0x13

I2C_IRQ_t I2C_IRQ = {0};

#define wfi() {__asm__("wfi\n");}
#define clr_sr1() {__asm__("ld a,0x5217\n");}  // очистка SR1 	
#define clr_sr3() {__asm__("ld a,0x5219\n");}  // очистка SR3 
#define enableInterrupts()    {__asm__("rim\n");}  /* enable interrupts */
#define disableInterrupts()   {__asm__("sim\n");}  /* disable interrupts */

void i2c_init(void);
void i2c_start(void);
void i2c_stop(void);
uint8_t i2c_send_address(uint8_t address,uint8_t rw_type);
uint8_t i2c_read_byte(void);
void i2c_read(uint8_t dev_addr, uint8_t size,uint8_t *data);
uint8_t i2c_send_byte(uint8_t data);
void i2c_write(uint8_t dev_addr,uint8_t size,uint8_t *data);
uint8_t i2c_scan(void);

void i2c_start_irq(void);
void i2c_stop_irq(void);
uint8_t i2c_send_address_irq(uint8_t address,uint8_t rw_type);
uint8_t i2c_read_byte_irq(unsigned char data);
void i2c_read_irq(uint8_t dev_addr, uint8_t size,uint8_t *data);
uint8_t i2c_send_byte_irq(uint8_t data);
void i2c_write_irq(uint8_t dev_addr,uint8_t size,uint8_t *data);
uint8_t i2c_scan_irq(void);

#endif