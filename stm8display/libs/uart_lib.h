#include <stdint.h>

uint8_t *tx_buf_pointer;
uint8_t *rx_buf_pointer;
uint8_t buf_pos;
uint8_t buf_size;

struct UART1_SR_
{
	uint8_t PE:1;
	uint8_t FE:1;
	uint8_t NF:1;
	uint8_t ORLHE:1;
	uint8_t IDLE:1;
	uint8_t RXNE:1;
	uint8_t TC:1;
	uint8_t TXE:1;
	
} typedef UART1_SR_t;

struct UART1_DR_
{
	uint8_t DR;
	
} typedef UART1_DR_t;

struct UART1_BRR1_
{
	uint8_t DIV;
	
} typedef UART1_BRR1_t;

struct UART1_BRR2_
{
	uint8_t LSB:4;
	uint8_t MSB:4;
	
} typedef UART1_BRR2_t;

struct UART1_CR1_
{
	uint8_t PEIN:1;
	uint8_t PS:1;
	uint8_t PCEN:1;
	uint8_t WAKE:1;
	uint8_t M:1;
	uint8_t UARTD:1;
	uint8_t T8:1;
	uint8_t R8:1;
	
} typedef UART1_CR1_t;

struct UART1_CR2_
{
	uint8_t SBK:1;
	uint8_t RWU:1;
	uint8_t REN:1;
	uint8_t TEN:1;
	uint8_t ILIEN:1;
	uint8_t RIEN:1;
	uint8_t TCIEN:1;
	uint8_t TIEN:1;
	
} typedef UART1_CR2_t;

struct UART1_CR3_
{
	uint8_t LBCL:1;
	uint8_t CPHA:1;
	uint8_t CPOL:1;
	uint8_t CLKEN:1;
	uint8_t STOP:2;
	uint8_t LINEN:1;
	uint8_t reserve:1;
	
} typedef UART1_CR3_t;

struct UART1_CR4_
{
	uint8_t ADD:4;
	uint8_t LBDF:1;
	uint8_t LBDL:1;
	uint8_t LBDIEN:1;
	uint8_t reserve:1;
	
} typedef UART1_CR4_t;

struct UART1_CR5_
{
	uint8_t reserve:1;
	uint8_t IREN:1;
	uint8_t IRLP:1;
	uint8_t HDSEL:1;
	uint8_t NACK:1;
	uint8_t SCEN:1;
	uint8_t reserve1:2;
	
} typedef UART1_CR5_t;

struct UART1_GTR_
{
	uint8_t GT;
	
} typedef UART1_GTR_t;

struct UART1_PSCR_
{
	uint8_t PSC;
	
} typedef UART1_PSCR_t;

/* UART */
#define UART1_SR ((volatile UART1_SR_t *)0x5230)
#define UART1_DR ((volatile UART1_DR_t *)0x5231)
#define UART1_BRR1 ((volatile UART1_BRR1_t *)0x5232)
#define UART1_BRR2 ((volatile UART1_BRR2_t *)0x5233)
#define UART1_CR1 ((volatile UART1_CR1_t *)0x5234)
#define UART1_CR2 ((volatile UART1_CR2_t *)0x5235)
#define UART1_CR3 ((volatile UART1_CR3_t *)0x5236)
#define UART1_CR4 ((volatile UART1_CR4_t *)0x5237)
#define UART1_CR5 ((volatile UART1_CR5_t *)0x5238)
#define UART1_GTR ((volatile UART1_GTR_t *)0x5239)
#define UART1_PSCR ((volatile UART1_PSCR_t *)0x523A)

#define UART1_T_vector 0x11
#define UART1_R_vector 0x12

#define wfi() {__asm__("wfi\n");}


// #include <stdarg.h>
// #include <stdint.h>
// struct UART1_SR_
// {
// 	uint8_t PE:1;
// 	uint8_t FE:1;
// 	uint8_t NF:1;
// 	uint8_t ORLHE:1;
// 	uint8_t IDLE:1;
// 	uint8_t RXNE:1;
// 	uint8_t TC:1;
// 	uint8_t TXE:1;
	
// } typedef UART1_SR_t;

// struct UART1_DR_
// {
// 	uint8_t DR;
	
// } typedef UART1_DR_t;

// struct UART1_BRR1_
// {
// 	uint8_t DIV;
	
// } typedef UART1_BRR1_t;

// struct UART1_BRR2_
// {
// 	uint8_t LSB:4;
// 	uint8_t MSB:4;
	
// } typedef UART1_BRR2_t;

// struct UART1_CR1_
// {
// 	uint8_t PEIN:1;
// 	uint8_t PS:1;
// 	uint8_t PCEN:1;
// 	uint8_t WAKE:1;
// 	uint8_t M:1;
// 	uint8_t UARTD:1;
// 	uint8_t T8:1;
// 	uint8_t R8:1;
	
// } typedef UART1_CR1_t;

// struct UART1_CR2_
// {
// 	uint8_t SBK:1;
// 	uint8_t RWU:1;
// 	uint8_t REN:1;
// 	uint8_t TEN:1;
// 	uint8_t ILIEN:1;
// 	uint8_t RIEN:1;
// 	uint8_t TCIEN:1;
// 	uint8_t TIEN:1;
	
// } typedef UART1_CR2_t;

// struct UART1_CR3_
// {
// 	uint8_t LBCL:1;
// 	uint8_t CPHA:1;
// 	uint8_t CPOL:1;
// 	uint8_t CLKEN:1;
// 	uint8_t STOP:2;
// 	uint8_t LINEN:1;
// 	uint8_t reserve:1;
	
// } typedef UART1_CR3_t;

// struct UART1_CR4_
// {
// 	uint8_t ADD:4;
// 	uint8_t LBDF:1;
// 	uint8_t LBDL:1;
// 	uint8_t LBDIEN:1;
// 	uint8_t reserve:1;
	
// } typedef UART1_CR4_t;

// struct UART1_CR5_
// {
// 	uint8_t reserve:1;
// 	uint8_t IREN:1;
// 	uint8_t IRLP:1;
// 	uint8_t HDSEL:1;
// 	uint8_t NACK:1;
// 	uint8_t SCEN:1;
// 	uint8_t reserve1:2;
	
// } typedef UART1_CR5_t;

// struct UART1_GTR_
// {
// 	uint8_t GT;
	
// } typedef UART1_GTR_t;

// struct UART1_PSCR_
// {
// 	uint8_t PSC;
	
// } typedef UART1_PSCR_t;

// /* UART */
// #define UART1_SR ((volatile UART1_SR_t *)0x5230)
// #define UART1_DR ((volatile UART1_DR_t *)0x5231)
// #define UART1_BRR1 ((volatile UART1_BRR1_t *)0x5232)
// #define UART1_BRR2 ((volatile UART1_BRR2_t *)0x5233)
// #define UART1_CR1 ((volatile UART1_CR1_t *)0x5234)
// #define UART1_CR2 ((volatile UART1_CR2_t *)0x5235)
// #define UART1_CR3 ((volatile UART1_CR3_t *)0x5236)
// #define UART1_CR4 ((volatile UART1_CR4_t *)0x5237)
// #define UART1_CR5 ((volatile UART1_CR5_t *)0x5238)
// #define UART1_GTR ((volatile UART1_GTR_t *)0x5239)
// #define UART1_PSCR ((volatile UART1_PSCR_t *)0x523A)