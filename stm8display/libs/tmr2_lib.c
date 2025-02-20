#include "tmr2_lib.h"

void tmr2_irq(void) __interrupt(TIM2_vector)
{
	
	disableInterrupts();
  	TIM2_IRQ.all = 0;//обнуление флагов регистров

  	if(TIM2_SR1 -> UIF)//прерывание таймера
  	{
	    TIM2_IRQ.UIF = 1;
	    TIM2_IER -> UIE = 0;
  	}
  	enableInterrupts();
}
void delay_s(uint8_t ticks)
{
	for(int i = 0;i<ticks;i++)
	{
		TIM2_SR1 -> UIF = 0;
		TIM2_ARRH->ARR = 0x03;
		TIM2_ARRL->ARR = 0xD1;
		TIM2_PSCR -> PSC = 0x0E;
		TIM2_IER -> UIE = 1;
		TIM2_CR1-> CEN = 1;
		while(TIM2_IER -> UIE);	
	}
	TIM2_CR1-> CEN = 0;
}
void delay_ms(uint8_t ticks)
{
	for(int i = 0;i<ticks;i++)
	{
		TIM2_SR1 -> UIF = 0;
		TIM2_ARRH->ARR = 0x00;
		TIM2_ARRL->ARR = 0x7D;
		TIM2_PSCR -> PSC = 0x0F;
		TIM2_IER -> UIE = 1;
		TIM2_CR1-> CEN = 1;
		while(TIM2_IER -> UIE);	
	}
	TIM2_CR1-> CEN = 0;
}