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

struct ADC_DRH_
{
	uint8_t DH;

} typedef ADC_DRH_t;

struct ADC_DRL_
{
	uint8_t DH;

} typedef ADC_DRL_t;

struct ADC_TDRH_
{
	uint8_t TD;

} typedef ADC_TDRH_t;

struct ADC_TDRL_
{
	uint8_t TD;

} typedef ADC_TDRL_t;

struct ADC_HTRH_
{
	uint8_t HT;

} typedef ADC_HTRH_t;

struct ADC_HTRL_
{
	uint8_t reserve:6;
	uint8_t HT:2;

} typedef ADC_HTRL_t;

struct ADC_LTRH_
{
	uint8_t HT;

} typedef ADC_HTRH_t;

struct ADC_LTRL_
{
	uint8_t reserve:6;
	uint8_t HT:2;

} typedef ADC_HTRL_t;

struct ADC_AWSRH_
{
	uint8_t reserve:6;
	uint8_t AWS:2;

} typedef ADC_AWSRH_t;

struct ADC_AWSRL_
{
	uint8_t AWS;

} typedef ADC_AWSRL_t;

struct ADC_AWCRH_
{
	uint8_t reserve:6;
	uint8_t AWEN:2;

} typedef ADC_AWCRH_t;

struct ADC_AWCRL_
{
	uint8_t AWEN;

} typedef ADC_AWCRL_t;

#define ADC_DBxR ((volatile ADC_DBxR_t *)0x53E0)
#define ADC_CSR ((volatile ADC_CSR_t *)0x5400)
#define ADC_CR1 ((volatile ADC_CR1_t *)0x5401)
#define ADC_CR2 ((volatile ADC_CR2_t *)0x5402)
#define ADC_CR3 ((volatile ADC_CR3_t *)0x5403)
#define ADC_DRH ((volatile ADC_DRH_t *0x5404)
#define ADC_DRL ((volatile ADC_DRL_t *)0x5405)
#define ADC_TDRH ((volatile ADC_TDRH_t *)0x5406)
#define ADC_TDRL ((volatile ADC_TDRL_t *)0x5407)
#define ADC_HTRH ((volatile ADC_HTRH_t *)0x5408)
#define ADC_HTRL ((volatile  ADC_HTRL_t *)0x5409)
#define ADC_LTRH ((volatile  ADC_LTRH_t *)0x540A)
#define ADC_LTRL ((volatile  ADC_LTRL_t *)0x540B)
#define ADC_AWSRH ((volatile ADC_AWSRH_t *)0x540C)
#define ADC_AWSRL ((volatile ADC_AWSRL_t *)0x540D)
#define ADC_AWCRH ((volatile ADC_AWCRH_t *)0x540E)
#define ADC_AWCRL ((volatile ADC_AWCRL_t *)0x540F)
