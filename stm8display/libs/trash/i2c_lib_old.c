void i2c_init(void) {
    // Включение I2C
    //----------- Setup I2C ------------------------
    I2C_CR1 -> PE = 0;// PE=0, disable I2C before setup
    I2C_FREQR -> FREQ = 16;// peripheral frequence =16MHz
    I2C_CCRH -> CCR = 0;// =0
    I2C_CCRL -> CCR = 80;// 100kHz for I2C
    I2C_CCRH -> FS = 0;// set standart mode(100кHz)
    I2C_OARH -> ADDMODE = 0;// 7-bit address mode
    I2C_OARH -> ADDCONF = 1;// see reference manual
    I2C_CR1 -> PE = 1;// PE=1, enable I2C
}
void reg_check(void)
{
    (uint8_t)I2C_SR3;
    (uint8_t)I2C_DR;
}
void i2c_start(void) {
    I2C_CR2 -> START = 1; // Отправляем стартовый сигнал
    while(!(I2C_SR1 -> SB));// Ожидание отправки стартового сигнала
}

void i2c_send_address(uint8_t address) {
    I2C_DR -> DR = address << 1; // Отправка адреса устройства с битом на запись
    reg_check();
    while (!(I2C_SR1 -> ADDR) && !(I2C_SR2 -> AF));
    
}

void i2c_stop(void) {
    I2C_CR2 -> STOP = 1;// Отправка стопового сигнала
    //uart_write("Stop generated\n");
}
void i2c_write(void){
    //I2C_DR = 0;
    reg_check();
    I2C_DR = d_addr;
    reg_check();
    while (!(I2C_SR1 -> TXE) && (I2C_SR2 & (1 << 
    )) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра
    reg_check();
    for(int i = 0;i < d_size;i++)
    {
        I2C_DR = data_buf[i];
        reg_check();
        while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2)));
        reg_check();
    }
}

void i2c_read(void){
    I2C_CR2 = I2C_CR2 | (1 << 2);
    I2C_DR = 0;
    reg_check();
    I2C_DR = d_addr;
    reg_check();
    while (!(I2C_SR1 & (1 << 7)) && (I2C_SR2 & (1 << 2)) && !(I2C_SR1 & (1 << 2))); // Отправка адреса регистра

    //Начало чтения
    i2c_start();
    I2C_DR = (current_dev << 1) | (1 << 0);
    reg_check();
    while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR1 & (1 << 2)) && !(I2C_SR1 & (1 << 6)));
    reg_check();
    for(int i = 0;i < d_size;i++)
    {
        data_buf[i] = I2C_DR;
        while (!(I2C_SR1 & (1 << 6)));
    }
    reg_check();
    I2C_CR2 = I2C_CR2 & ~(1 << 2);
    reg_check();
}
void i2c_scan(void) {
    for (uint8_t addr = current_dev; addr < 127; addr++) {
        i2c_start();
        i2c_send_address(addr);
        if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
            // Адрес подтвержден, устройство найдено
            current_dev = addr;
            i2c_stop();
            break;
        }
        i2c_stop();
        I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
    }
}