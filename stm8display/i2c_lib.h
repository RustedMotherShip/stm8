struct I2C_CR1_
{
	uint8_t NOSTRETCH:1;
	uint8_t ENGC:1;
	uint8_t reserve:5;
	uint8_t PE:1;
	
} typedef I2C_CR1_t;

struct I2C_CR2_
{
	uint8_t SWRST:1;
	uint8_t reserve:3;
	uint8_t POS:1;
	uint8_t ACK:1;
	uint8_t STOP:1;
	uint8_t START:1;

} typedef I2C_CR2_t;

struct I2C_FREQR_
{
	uint8_t reserve:2;
	uint8_t FREQ:6;
	
} typedef I2C_FREQR_t;

struct I2C_OARL_
{
	uint8_t ADD:7;
	uint8_t RW_ADD:1;
	
} typedef I2C_OARL_t;

struct I2C_OARH_
{
	uint8_t ADDMODE:1;
	uint8_t ADDCONF:1;
	uint8_t reserve:3;
	uint8_t ADD:2;
	uint8_t reserve1:1;
	
} typedef I2C_OARH_t;

struct I2C_DR_
{
	uint8_t DR;
	
} typedef I2C_DR_t;

struct I2C_SR1_
{
	uint8_t TXE:1;
	uint8_t RXNE:1;
	uint8_t reserve:1;
	uint8_t STOPF:1;
	uint8_t ADD10:1;
	uint8_t BTF:1;
	uint8_t ADDR:1;
	uint8_t SB:1;
	
} typedef I2C_SR1_t;

struct I2C_SR2_
{
	uint8_t reserve:2;
	uint8_t WUFH:1;
	uint8_t reserve1:1;
	uint8_t OVR:1;
	uint8_t AF:1;
	uint8_t ARLO:1;
	uint8_t BERR:1;
	
} typedef I2C_SR2_t;

struct I2C_SR3_
{
	uint8_t DUALF:1;
	uint8_t reserve:2;
	uint8_t GENCALL:1;
	uint8_t reserve1:1;
	uint8_t TRA:1;
	uint8_t BUSY:1;
	uint8_t MSL:1;
	
} typedef I2C_SR3_t;

struct I2C_ITR_
{
	uint8_t reserve:5;
	uint8_t ITBUFEN:1;
	uint8_t ITEVTEN:1;
	uint8_t ITERREN:1;
	
} typedef I2C_ITR_t;

struct I2C_CCRL_
{
	uint8_t CCR;
	
} typedef I2C_CCRL_t;

struct I2C_CCRH_
{
	uint8_t FS:1;
	uint8_t DUTY:1;
	uint8_t reserve:2;
	uint8_t CCR:4;
	
} typedef I2C_CCRH_t;

struct I2C_TRISER_
{
	uint8_t reserve:2;
	uint8_t TRISE:6;
	
} typedef I2C_TRISER_t;