#include "adc_lib.h"
void adc_init(void) {

    ADC_CSR -> CH = 3; // Select channel 2 (AIN2=PC4)

    ADC_CR1 -> ADON = 1; // ADON
    ADC_CR2 -> ALIGN = 0; // Align left

    delay_s(1); // Give little time to be ready for first conversion
}

uint16_t adc_read(void) {
    ADC_CR1 -> CONT = 0; // Single conversion mode
    ADC_CR1 -> ADON = 1; // Start conversion
    while(!(ADC_CSR -> EOC));
    { 
        nop(); 
    } 
    ADC_CSR  -> EOC = 0; // Clear "End of conversion"-flag
    return (ADC_DRL -> DH << 2) | (ADC_DRL -> DH >> 6);  // Left aligned
}
