/* ADC */
struct ADC_DBxR_
{
	uint8_t reserve:8;

} typedef ADC_DBxR_t;

struct ADC_CSR_
{
	uint8_t EOC:1;
	uint8_t AWD:1;
	uint8_t EOCIE:1;
	uint8_t AWDIE:1;
	uint8_t CH:4;

} typedef ADC_CSR_t;

struct ADC_CR1_
{
	uint8_t reserve:1;
	uint8_t SPSEL:3;
	uint8_t reserve1:2;
	uint8_t CONT:1;
	uint8_t ADON:1;

} typedef ADC_CR1_t;

struct ADC_CR2_
{
	uint8_t reserve:1;
	uint8_t EXTTRIG:1;
	uint8_t EXTSEL:2;
	uint8_t ALIGN:1;
	uint8_t reserve1:1;
	uint8_t SCAN:1;
	uint8_t reserve2:1;

} typedef ADC_CR2_t;

struct ADC_CR3_
{
	uint8_t DBUF:1;
	uint8_t OVR:1;
	uint8_t reserve:6;

} typedef ADC_CR3_t;

#define ADC_DBxR ((volatile ADC_DBxR_t *)0x53E0)
#define ADC_CSR ((volatile ADC_CSR_t *)0x5400)
#define ADC_CR1 *(volatile unsigned char *)0x5401
#define ADC_CR2 *(volatile unsigned char *)0x5402
#define ADC_CR3 *(volatile unsigned char *)0x5403
#define ADC_DRH *(volatile unsigned char *)0x5404
#define ADC_DRL *(volatile unsigned char *)0x5405
#define ADC_TDRH *(volatile unsigned char *)0x5406
#define ADC_TDRL *(volatile unsigned char *)0x5407
#define ADC_HTRH *(volatile unsigned char *)0x5408
#define ADC_HTRL *(volatile unsigned char *)0x5409
#define ADC_LTRH *(volatile unsigned char *)0x540A
#define ADC_LTRL *(volatile unsigned char *)0x540B
#define ADC_AWSRH *(volatile unsigned char *)0x540C
#define ADC_AWSRL *(volatile unsigned char *)0x540D
#define ADC_AWCRH *(volatile unsigned char *)0x540E
#define ADC_AWCRL *(volatile unsigned char *)0x540F
