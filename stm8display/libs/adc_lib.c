void init_adc() {
    ADC_CSR = 0;
    ADC_CR1 = 0;
    ADC_CR2 = 0;
    ADC_CR3 = 0;

    ADC_CSR = 2; // Select channel 2 (AIN2=PC4)

    ADC_CR1 |= ADC_CR1_ADON; // ADON
    ADC_CR2 &= ~ADC_CR2_ALIGN; // Align left

    delay(1000); // Give little time to be ready for first conversion
}

uint16_t analog_read() {
    ADC_CR1 &= ~ADC_CR1_CONT; // Single conversion mode
    ADC_CR1 |= ADC_CR1_ADON; // Start conversion
    do { nop(); } while ((ADC_CSR >> 7) == 0);
    ADC_CSR &= ~ADC_CSR_EOC; // Clear "End of conversion"-flag
    return (ADC_DRH << 2) | (ADC_DRL >> 6);  // Left aligned
}
