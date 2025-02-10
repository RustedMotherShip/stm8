#ifndef _TIM2_LIB_H
#define _TIM2_LIB_H

struct TIM2_CR1_
{
	uint8_t CEN:1;
	uint8_t UDIS:1;
	uint8_t URS:1;
	uint8_t OPM:1;
	uint8_t DIR:1;
	uint8_t CMS:2;
	uint8_t ARPE:1;
	
} typedef TIM2_CR1_t;

struct TIM2_CR2_
{
	uint8_t CCPC:1;
	uint8_t reserve:1;
	uint8_t COMS:1;
	uint8_t reserve1:1;
	uint8_t MMS:3;
	uint8_t reserve2:1; 

} typedef TIM2_CR2_t;

struct TIM2_SMCR_
{
	uint8_t SMS:3;
	uint8_t reserve:1;
	uint8_t TS:3;
    uint8_t MSM:1;

} typedef TIM2_SMCR_t;

struct TIM2_ETR_
{
	uint8_t ETF:4;
	uint8_t ETPS:2;
	uint8_t ECE:1;
    uint8_t ETP:1;   

} typedef TIM2_ETR_t;

struct TIM2_IER_
{
	uint8_t UIE:1;
	uint8_t CC1IE:1;
	uint8_t CC2IE:1;
	uint8_t CC3IE:1;
	uint8_t CC4IE:1;
	uint8_t COMIE:1;
	uint8_t TIE:1;
    uint8_t BIE:1;

} typedef TIM2_IER_t;

struct TIM2_SR1_
{
	uint8_t UIF:1;
	uint8_t CC1IF:1;
	uint8_t CC2IF:1;
	uint8_t CC3IF:1;
	uint8_t CC4IF:1;
	uint8_t COMIF:1;
	uint8_t TIF:1;
    uint8_t BIF:1;

} typedef TIM2_SR1_t;

struct TIM2_SR2_
{
	uint8_t reserve:1;
	uint8_t CC1OF:1;
	uint8_t CC2OF:1;
	uint8_t CC3OF:1;
	uint8_t CC4OF:1;
    uint8_t reserve1:3;

} typedef TIM2_SR2_t;

struct TIM2_EGR_
{
	uint8_t UG:1;
	uint8_t CC1G:1;
	uint8_t CC2G:1;
	uint8_t CC3G:1;
	uint8_t CC4G:1;
	uint8_t COMG:1; 
	uint8_t TG:1;
    uint8_t BG:1;
      
} typedef TIM2_EGR_t;

struct TIM2_CCMR1_
{
	uint8_t CC1S:2;
	uint8_t OC1FE:1;
	uint8_t OC1PE:1;
	uint8_t OC1M:3;
    uint8_t OC1CE:1;   

} typedef TIM2_CCMR1_t;

struct TIM2_CCMR2_
{
	uint8_t CC2S:2;
	uint8_t OC2FE:1;
	uint8_t OC2PE:1;
	uint8_t OC2M:3;
    uint8_t OC2CE:1;   

} typedef TIM2_CCMR2_t;

struct TIM2_CCMR3_
{
	uint8_t CC3S:2;
	uint8_t OC3FE:1;
	uint8_t OC3PE:1;
	uint8_t OC3M:3;
    uint8_t OC3CE:1;   

} typedef TIM2_CCMR3_t;

struct TIM2_CCMR4_
{
	uint8_t CC4S:2;
	uint8_t OC4FE:1;
	uint8_t OC4PE:1;
	uint8_t OC4M:3;
    uint8_t OC4CE:1;   

} typedef TIM2_CCMR4_t;

struct TIM2_CCER1_
{
	uint8_t CC1E:1;
	uint8_t CC1P:1;
	uint8_t CC1NE:1;
	uint8_t CC1NP:1;
	uint8_t CC2E:1;
	uint8_t CC2P:1;  
	uint8_t CC2NE:1;
    uint8_t CC2NP:1;   

} typedef TIM2_CCER1_t;

struct TIM2_CCER2_
{
	uint8_t CC3E:1;
	uint8_t CC3P:1;
	uint8_t CC3NE:1;
	uint8_t CC3NP:1;
	uint8_t CC4E:1; 
	uint8_t CC4P:1;
    uint8_t reserve:2;   
   
} typedef TIM2_CCER2_t;

struct TIM2_CNTRH_
{
    uint8_t CNT;

} typedef TIM2_CNTRH_t;

struct TIM2_CNTRL_
{
    uint8_t CNT;    

} typedef TIM2_CNTRL_t;

struct TIM2_PSCR_
{
	uint8_t PSC:4;
	uint8_t reserve:4;

} typedef TIM2_PSCR_t;

struct TIM2_ARRH_
{
    uint8_t ARR;  

} typedef TIM2_ARRH_t;

struct TIM2_ARRL_
{
    uint8_t ARR;

} typedef TIM2_ARRL_t;

struct TIM2_RCR_
{
    uint8_t REP;

} typedef TIM2_RCR_t;

struct TIM2_CCR1H_
{
    uint8_t CCR1;

} typedef TIM2_CCR1H_t;

struct TIM2_CCR1L_
{
    uint8_t CCR1;

} typedef TIM2_CCR1L_t;

struct TIM2_CCR2H_
{
    uint8_t CCR2;

} typedef TIM2_CCR2H_t;

struct TIM2_CCR2L_
{
    uint8_t CCR2;

} typedef TIM2_CCR2L_t;

struct TIM2_CCR3H_
{
    uint8_t CCR3;

} typedef TIM2_CCR3H_t;

struct TIM2_CCR3L_
{
    uint8_t CCR3;

} typedef TIM2_CCR3L_t;

struct TIM2_IRQ_
{
	union
	{
		uint8_t all;
		struct {
			uint8_t BIF:1;
			uint8_t TIF:1;
			uint8_t COMIF:1;
			uint8_t CC4IF:1;
			uint8_t CC3IF:1;
			uint8_t CC2IF:1;
			uint8_t CC1IF:1;
			uint8_t UIF:1;
		};
	};
	
} typedef TIM2_IRQ_t;

#define TIM2_CR1 ((TIM2_CR1_t *)0x5300)
#define TIM2_CR2 ((TIM2_CR2_t *)0x5301)
#define TIM2_SMCR ((TIM2_SMCR_t *)0x5302)
#define TIM2_IER ((TIM2_IER_t *)0x5303)
#define TIM2_SR1 ((TIM2_SR1_t *)0x5304)
#define TIM2_SR2 ((TIM2_SR2_t *)0x5305)
#define TIM2_EGR ((TIM2_EGR_t *)0x5306)
#define TIM2_CCMR1 ((TIM2_CCMR1_t *)0x5307)
#define TIM2_CCMR2 ((TIM2_CCMR2_t *)0x5308)
#define TIM2_CCMR3 ((TIM2_CCMR3_t *)0x5309)
#define TIM2_CCER1 ((TIM2_CCER1_t *)0x530A)
#define TIM2_CCER2 ((TIM2_CCER2_t *)0x530B)
#define TIM2_CNTRH ((TIM2_CNTRH_t *)0x530C)
#define TIM2_CNTRL ((TIM2_CNTRL_t *)0x530D)
#define TIM2_PSCR ((TIM2_PSCR_t *)0x530E)
#define TIM2_ARRH ((TIM2_ARRH_t *)0x530F)
#define TIM2_ARRL ((TIM2_ARRL_t *)0x5310)
#define TIM2_CCR1H ((TIM2_CCR1H_t *)0x5311)
#define TIM2_CCR1L ((TIM2_CCR1L_t *)0x5312)
#define TIM2_CCR2H ((TIM2_CCR2H_t *)0x5313)
#define TIM2_CCR2L ((TIM2_CCR2L_t *)0x5314)
#define TIM2_CCR3H ((TIM2_CCR3H_t *)0x5315)
#define TIM2_CCR3L ((TIM2_CCR3L_t *)0x5316)

void delay_ms(uint8_t ticks);
void delay_s(uint8_t ticks);

#define wfi() {__asm__("wfi\n");}
#define enableInterrupts()    {__asm__("rim\n");}  /* enable interrupts */
#define disableInterrupts()   {__asm__("sim\n");}  /* disable interrupts */

#define TIM2_vector 0x0D

TIM2_IRQ_t TIM2_IRQ = {0};

#endif