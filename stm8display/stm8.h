/*
 * Register definitions for STM8S103 (and STM8S003)
 * Still incomplete.
 */
#ifndef _STH8_H
#define _STH8_H
/* Handy macros for GPIO */
#define CONCAT(a, b)    a##_##b
#define PORT(a, b)      CONCAT(a , b)
#define CLRBIT(REG, VALUE) REG &= ~VALUE
#define SETBIT(REG, VALUE) REG |=  VALUE

#define PIN0    (1 << 0)
#define PIN1    (1 << 1)
#define PIN2    (1 << 2)
#define PIN3    (1 << 3)
#define PIN4    (1 << 4)
#define PIN5    (1 << 5)
#define PIN6    (1 << 6)
#define PIN7    (1 << 7)

/* Register addresses */

/* Clock */
#define CLK_CKDIVR	*(volatile unsigned char *)0x50C6

/* GPIO */
#define PA_ODR *(volatile unsigned char *)0x5000
#define PA_IDR *(volatile unsigned char *)0x5001
#define PA_DDR *(volatile unsigned char *)0x5002
#define PA_CR1 *(volatile unsigned char *)0x5003
#define PA_CR2 *(volatile unsigned char *)0x5004

#define PB_ODR *(volatile unsigned char *)0x5005
#define PB_IDR *(volatile unsigned char *)0x5006
#define PB_DDR *(volatile unsigned char *)0x5007
#define PB_CR1 *(volatile unsigned char *)0x5008
#define PB_CR2 *(volatile unsigned char *)0x5009

#define PC_ODR *(volatile unsigned char *)0x500A
#define PC_IDR *(volatile unsigned char *)0x500B
#define PC_DDR *(volatile unsigned char *)0x500C
#define PC_CR1 *(volatile unsigned char *)0x500D
#define PC_CR2 *(volatile unsigned char *)0x500E

#define PD_ODR *(volatile unsigned char *)0x500F
#define PD_IDR *(volatile unsigned char *)0x5010
#define PD_DDR *(volatile unsigned char *)0x5011
#define PD_CR1 *(volatile unsigned char *)0x5012
#define PD_CR2 *(volatile unsigned char *)0x5013



/* Timers */


/* Note these are for STM8S103 and STM8S003
   STM8S105,104/207/208 are different */
#define TIM4_CR1 *(volatile unsigned char *)0x5340
#define TIM4_CR2 *(volatile unsigned char *)0x5341
#define TIM4_SMCR *(volatile unsigned char *)0x5342
#define TIM4_IER *(volatile unsigned char *)0x5343
#define TIM4_SR *(volatile unsigned char *)0x5344
#define TIM4_EGR *(volatile unsigned char *)0x5345
#define TIM4_CNTR *(volatile unsigned char *)0x5346
#define TIM4_PSCR *(volatile unsigned char *)0x5347
#define TIM4_ARR *(volatile unsigned char *)0x5348

/* SPI */
#define SPI_CR1 *(volatile unsigned char *)0x5200
#define SPI_CR2 *(volatile unsigned char *)0x5201
#define SPI_ICR *(volatile unsigned char *)0x5202
#define SPI_SR *(volatile unsigned char *)0x5203
#define SPI_DR *(volatile unsigned char *)0x5204
#define SPI_CRCPR *(volatile unsigned char *)0x5205
#define SPI_RXCRCR *(volatile unsigned char *)0x5206
#define SPI_TXCRCR *(volatile unsigned char *)0x5207

#define SPI_CR1_LSBFIRST (1 << 7)
#define SPI_CR1_SPE (1 << 6)
#define SPI_CR1_BR(br) ((br) << 3)
#define SPI_CR1_MSTR (1 << 2)
#define SPI_CR1_CPOL (1 << 1)
#define SPI_CR1_CPHA (1 << 0)

#define SPI_CR2_BDM (1 << 7)
#define SPI_CR2_BDOE (1 << 6)
#define SPI_CR2_CRCEN (1 << 5)
#define SPI_CR2_CRCNEXT (1 << 4)
#define SPI_CR2_RXONLY (1 << 2)
#define SPI_CR2_SSM (1 << 1)
#define SPI_CR2_SSI (1 << 0)

#define SPI_ICR_TXIE (1 << 7)
#define SPI_ICR_RXIE (1 << 6)
#define SPI_ICR_ERRIE (1 << 5)
#define SPI_ICR_WKIE (1 << 4)

#define SPI_SR_BSY (1 << 7)
#define SPI_SR_OVR (1 << 6)
#define SPI_SR_MODF (1 << 5)
#define SPI_SR_CRCERR (1 << 4)
#define SPI_SR_WKUP (1 << 3)
#define SPI_SR_TXE (1 << 1)
#define SPI_SR_RxNE (1 << 0)

#define ADC_CSR_EOC (1 << 7)
#define ADC_CSR_AWD (1 << 6)
#define ADC_CSR_EOCIE (1 << 5)
#define ADC_CSR_AWDIE (1 << 4)

#define ADC_CR1_CONT (1 << 1)
#define ADC_CR1_ADON (1 << 0)

#define ADC_CR2_EXTTRIG (1 << 6)
#define ADC_CR2_EXTSEL (1 << 4)
#define ADC_CR2_ALIGN (1 << 3)
#define ADC_CR2_SCAN (1 << 1)


/* Interrupt commands */
#define enableInterrupts()    {__asm__("rim\n");}  /* enable interrupts */
#define disableInterrupts()   {__asm__("sim\n");}  /* disable interrupts */
#define rim()                 {__asm__("rim\n");}  /* enable interrupts */
#define sim()                 {__asm__("sim\n");}  /* disable interrupts */
#define nop()                 {__asm__("nop\n");}  /* No Operation */
#define trap()                {__asm__("trap\n");} /* Trap (soft IT) */
#define wfi()                 {__asm__("wfi\n");}  /* Wait For Interrupt */
#define halt()                {__asm__("halt\n");} /* Halt */


#define ISR(name,vector) void name(void) __interrupt(vector - 2)

/* Interrupt numbers */
#define TIM2_OVR_UIF_IRQ 13
#define TIM3_OVR_UIF_IRQ 15
#define ADC1_EOC_IRQ 22
#define TIM4_OVR_UIF_IRQ 23

#endif

// // Note that the vector counts start from 0, i.e. the (addr_vector - 0x8000) / 4
// // In SDCC however, RESET and TRAP are left out in this count, i.e. IRQ0 is at
// // address 0x8008. So we use this macro to allow the below vector definitions from
// // iostm8s003f3.h to still work.
// #define ISR(name,vector) void name(void) __interrupt(vector - 2)

// #define AWU_vector                           0x03
// #define EXTI_PORTA_vector                    0x05
// #define EXTI_PORTB_vector                    0x06
// #define EXTI_PORTC_vector                    0x07
// #define EXTI_PORTD_vector                    0x08
// #define EXTI_PORTE_vector                    0x09
// #define SPI_TXE_vector                       0x0C
// #define SPI_RXNE_vector                      0x0C
// #define SPI_WKUP_vector                      0x0C
// #define SPI_CRCERR_vector                    0x0C
// #define SPI_OVR_vector                       0x0C
// #define SPI_MODF_vector                      0x0C
// #define TIM1_OVR_UIF_vector                  0x0D
// #define TIM1_CAPCOM_BIF_vector               0x0D
// #define TIM1_CAPCOM_TIF_vector               0x0D
// #define TIM1_CAPCOM_CC1IF_vector             0x0E
// #define TIM1_CAPCOM_CC2IF_vector             0x0E
// #define TIM1_CAPCOM_CC3IF_vector             0x0E
// #define TIM1_CAPCOM_CC4IF_vector             0x0E
// #define TIM1_CAPCOM_COMIF_vector             0x0E
// #define TIM2_OVR_UIF_vector                  0x0F
// #define TIM2_CAPCOM_CC1IF_vector             0x10
// #define TIM2_CAPCOM_TIF_vector               0x10
// #define TIM2_CAPCOM_CC2IF_vector             0x10
// #define TIM2_CAPCOM_CC3IF_vector             0x10
// #define UART1_T_TXE_vector                   0x13
// #define UART1_T_TC_vector                    0x13
// #define UART1_R_OR_vector                    0x14
// #define UART1_R_RXNE_vector                  0x14
// #define UART1_R_IDLE_vector                  0x14
// #define UART1_R_PE_vector                    0x14
// #define UART1_R_LBDF_vector                  0x14
// #define I2C_ADD10_vector                     0x15
// #define I2C_ADDR_vector                      0x15
// #define I2C_OVR_vector                       0x15
// #define I2C_STOPF_vector                     0x15
// #define I2C_BTF_vector                       0x15
// #define I2C_WUFH_vector                      0x15
// #define I2C_RXNE_vector                      0x15
// #define I2C_TXE_vector                       0x15
// #define I2C_BERR_vector                      0x15
// #define I2C_ARLO_vector                      0x15
// #define I2C_AF_vector                        0x15
// #define I2C_SB_vector                        0x15
// #define ADC1_AWS0_vector                     0x18
// #define ADC1_AWS1_vector                     0x18
// #define ADC1_AWS2_vector                     0x18
// #define ADC1_AWS3_vector                     0x18
// #define ADC1_AWS4_vector                     0x18
// #define ADC1_AWS5_vector                     0x18
// #define ADC1_AWS6_vector                     0x18
// #define ADC1_EOC_vector                      0x18
// #define ADC1_AWS8_vector                     0x18
// #define ADC1_AWS9_vector                     0x18
// #define ADC1_AWDG_vector                     0x18
// #define ADC1_AWS7_vector                     0x18
// #define TIM4_OVR_UIF_vector                  0x19
// #define FLASH_EOP_vector                     0x1A
// #define FLASH_WR_PG_DIS_vector               0x1A

// /*
// Interrupts:

// 0 TLI
// 1 AWU Auto Wake up from Halt
// 2 CLK Clock controller
// 3 EXTI0 Port A external interrupts
// 4 EXTI1 Port B external interrupts
// 5 EXTI2 Port C external interrupts
// 6 EXTI3 Port D external interrupts
// 7 EXTI4 Port E external interrupts
// 8 CAN CAN RX interrupt
// 9 CAN CAN TX/ER/SC interrupt
// 10 SPI End of Transfer
// 11 TIM1 Update /Overflow/Underflow/Trigger/Break
// 12 TIM1 Capture/Compare
// 13 TIM2 Update /Overflow
// 14 TIM2 Capture/Compare
// 15 TIM3 Update /Overflow
// 16 TIM3 Capture/Compare
// 17 UART1 Tx complete
// 18 UART1 Receive Register DATA FULL
// 19 I2C I2C interrupt
// 20 UART2/3 Tx complete
// 21 UART2/3 Receive Register DATA FULL
// 22 ADC End of Conversion
// 23 TIM4 Update/Overflow
// 24 FLASH EOP/WR_PG_DIS

// TLI 0
// AWU 1
// CLK 2
// EXTI_PORTA 3
// EXTI_PORTB 4
// EXTI_PORTC
// EXTI_PORTD
// EXTI_PORTE
// CAN_RX
// CAN_TX
// SPI
// TIM1_UPD_OVF_TRG_BRK
// TIM1_CAP_COM
// TIM2_UPD_OVF_BRK
// TIM2_CAP_COM
// TIM3_UPD_OVF_BRK
// TIM3_CAP_COM
// UART1_TX
// UART1_RX
// I2C 19
// ADC1 22
// TIM4_UPD_OVF 23
// EEPROM_EEC 24
// */

