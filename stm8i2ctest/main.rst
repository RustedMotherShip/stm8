                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.3.0 #14184 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _uart_write_line
                                     13 	.globl _convert_int_to_binary
                                     14 	.globl _convert_int_to_chars
                                     15 	.globl _delay
                                     16 	.globl _strlen
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area DATA
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area INITIALIZED
                                     25 ;--------------------------------------------------------
                                     26 ; Stack segment in internal ram
                                     27 ;--------------------------------------------------------
                                     28 	.area SSEG
      000001                         29 __start__stack:
      000001                         30 	.ds	1
                                     31 
                                     32 ;--------------------------------------------------------
                                     33 ; absolute external ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DABS (ABS)
                                     36 
                                     37 ; default segment ordering for linker
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area CONST
                                     42 	.area INITIALIZER
                                     43 	.area CODE
                                     44 
                                     45 ;--------------------------------------------------------
                                     46 ; interrupt vector
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
      008000                         49 __interrupt_vect:
      008000 82 00 80 07             50 	int s_GSINIT ; reset
                                     51 ;--------------------------------------------------------
                                     52 ; global & static initialisations
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area GSINIT
      008007 CD 82 CC         [ 4]   58 	call	___sdcc_external_startup
      00800A 4D               [ 1]   59 	tnz	a
      00800B 27 03            [ 1]   60 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   61 	jp	__sdcc_program_startup
      008010                         62 __sdcc_init_data:
                                     63 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   64 	ldw x, #l_DATA
      008013 27 07            [ 1]   65 	jreq	00002$
      008015                         66 00001$:
      008015 72 4F 00 00      [ 1]   67 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   68 	decw x
      00801A 26 F9            [ 1]   69 	jrne	00001$
      00801C                         70 00002$:
      00801C AE 00 00         [ 2]   71 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   72 	jreq	00004$
      008021                         73 00003$:
      008021 D6 80 94         [ 1]   74 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   75 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   76 	decw	x
      008028 26 F7            [ 1]   77 	jrne	00003$
      00802A                         78 00004$:
                                     79 ; stm8_genXINIT() end
                                     80 	.area GSFINAL
      00802A CC 80 04         [ 2]   81 	jp	__sdcc_program_startup
                                     82 ;--------------------------------------------------------
                                     83 ; Home
                                     84 ;--------------------------------------------------------
                                     85 	.area HOME
                                     86 	.area HOME
      008004                         87 __sdcc_program_startup:
      008004 CC 81 B0         [ 2]   88 	jp	_main
                                     89 ;	return from main will return to caller
                                     90 ;--------------------------------------------------------
                                     91 ; code
                                     92 ;--------------------------------------------------------
                                     93 	.area CODE
                                     94 ;	main.c: 7: void delay(unsigned long count) {
                                     95 ;	-----------------------------------------
                                     96 ;	 function delay
                                     97 ;	-----------------------------------------
      008095                         98 _delay:
      008095 52 08            [ 2]   99 	sub	sp, #8
                                    100 ;	main.c: 8: while (count--)
      008097 16 0D            [ 2]  101 	ldw	y, (0x0d, sp)
      008099 17 07            [ 2]  102 	ldw	(0x07, sp), y
      00809B 1E 0B            [ 2]  103 	ldw	x, (0x0b, sp)
      00809D                        104 00101$:
      00809D 1F 01            [ 2]  105 	ldw	(0x01, sp), x
      00809F 7B 07            [ 1]  106 	ld	a, (0x07, sp)
      0080A1 6B 03            [ 1]  107 	ld	(0x03, sp), a
      0080A3 7B 08            [ 1]  108 	ld	a, (0x08, sp)
      0080A5 16 07            [ 2]  109 	ldw	y, (0x07, sp)
      0080A7 72 A2 00 01      [ 2]  110 	subw	y, #0x0001
      0080AB 17 07            [ 2]  111 	ldw	(0x07, sp), y
      0080AD 24 01            [ 1]  112 	jrnc	00117$
      0080AF 5A               [ 2]  113 	decw	x
      0080B0                        114 00117$:
      0080B0 4D               [ 1]  115 	tnz	a
      0080B1 26 08            [ 1]  116 	jrne	00118$
      0080B3 16 02            [ 2]  117 	ldw	y, (0x02, sp)
      0080B5 26 04            [ 1]  118 	jrne	00118$
      0080B7 0D 01            [ 1]  119 	tnz	(0x01, sp)
      0080B9 27 03            [ 1]  120 	jreq	00104$
      0080BB                        121 00118$:
                                    122 ;	main.c: 9: nop();
      0080BB 9D               [ 1]  123 	nop
      0080BC 20 DF            [ 2]  124 	jra	00101$
      0080BE                        125 00104$:
                                    126 ;	main.c: 10: }
      0080BE 1E 09            [ 2]  127 	ldw	x, (9, sp)
      0080C0 5B 0E            [ 2]  128 	addw	sp, #14
      0080C2 FC               [ 2]  129 	jp	(x)
                                    130 ;	main.c: 12: void convert_int_to_chars(int num, char* rx_int_chars) {
                                    131 ;	-----------------------------------------
                                    132 ;	 function convert_int_to_chars
                                    133 ;	-----------------------------------------
      0080C3                        134 _convert_int_to_chars:
      0080C3 52 0B            [ 2]  135 	sub	sp, #11
      0080C5 1F 0A            [ 2]  136 	ldw	(0x0a, sp), x
                                    137 ;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
      0080C7 16 0E            [ 2]  138 	ldw	y, (0x0e, sp)
      0080C9 17 01            [ 2]  139 	ldw	(0x01, sp), y
                                    140 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      0080CB 4B 0A            [ 1]  141 	push	#0x0a
      0080CD 4B 00            [ 1]  142 	push	#0x00
      0080CF 1E 0C            [ 2]  143 	ldw	x, (0x0c, sp)
                                    144 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      0080D1 CD 82 F3         [ 4]  145 	call	__divsint
      0080D4 1F 03            [ 2]  146 	ldw	(0x03, sp), x
      0080D6 4B 0A            [ 1]  147 	push	#0x0a
      0080D8 4B 00            [ 1]  148 	push	#0x00
      0080DA 1E 0C            [ 2]  149 	ldw	x, (0x0c, sp)
                                    150 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      0080DC CD 82 DB         [ 4]  151 	call	__modsint
      0080DF 90 93            [ 1]  152 	ldw	y, x
      0080E1 9F               [ 1]  153 	ld	a, xl
      0080E2 1E 01            [ 2]  154 	ldw	x, (0x01, sp)
      0080E4 5C               [ 1]  155 	incw	x
      0080E5 1F 05            [ 2]  156 	ldw	(0x05, sp), x
                                    157 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      0080E7 1E 01            [ 2]  158 	ldw	x, (0x01, sp)
      0080E9 5C               [ 1]  159 	incw	x
      0080EA 5C               [ 1]  160 	incw	x
      0080EB 1F 07            [ 2]  161 	ldw	(0x07, sp), x
      0080ED AB 30            [ 1]  162 	add	a, #0x30
      0080EF 6B 09            [ 1]  163 	ld	(0x09, sp), a
                                    164 ;	main.c: 13: if (num > 99) {
      0080F1 1E 0A            [ 2]  165 	ldw	x, (0x0a, sp)
      0080F3 A3 00 63         [ 2]  166 	cpw	x, #0x0063
      0080F6 2D 29            [ 1]  167 	jrsle	00105$
                                    168 ;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
      0080F8 4B 64            [ 1]  169 	push	#0x64
      0080FA 4B 00            [ 1]  170 	push	#0x00
      0080FC 1E 0C            [ 2]  171 	ldw	x, (0x0c, sp)
      0080FE CD 82 F3         [ 4]  172 	call	__divsint
      008101 9F               [ 1]  173 	ld	a, xl
      008102 AB 30            [ 1]  174 	add	a, #0x30
      008104 1E 01            [ 2]  175 	ldw	x, (0x01, sp)
      008106 F7               [ 1]  176 	ld	(x), a
                                    177 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      008107 4B 0A            [ 1]  178 	push	#0x0a
      008109 4B 00            [ 1]  179 	push	#0x00
      00810B 1E 05            [ 2]  180 	ldw	x, (0x05, sp)
      00810D CD 82 DB         [ 4]  181 	call	__modsint
      008110 9F               [ 1]  182 	ld	a, xl
      008111 AB 30            [ 1]  183 	add	a, #0x30
      008113 1E 05            [ 2]  184 	ldw	x, (0x05, sp)
      008115 F7               [ 1]  185 	ld	(x), a
                                    186 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      008116 1E 07            [ 2]  187 	ldw	x, (0x07, sp)
      008118 7B 09            [ 1]  188 	ld	a, (0x09, sp)
      00811A F7               [ 1]  189 	ld	(x), a
                                    190 ;	main.c: 18: rx_int_chars[3] ='\0';
      00811B 1E 01            [ 2]  191 	ldw	x, (0x01, sp)
      00811D 6F 03            [ 1]  192 	clr	(0x0003, x)
      00811F 20 22            [ 2]  193 	jra	00107$
      008121                        194 00105$:
                                    195 ;	main.c: 20: } else if (num > 9) {
      008121 1E 0A            [ 2]  196 	ldw	x, (0x0a, sp)
      008123 A3 00 09         [ 2]  197 	cpw	x, #0x0009
      008126 2D 11            [ 1]  198 	jrsle	00102$
                                    199 ;	main.c: 22: rx_int_chars[0] = num / 10 + '0';
      008128 7B 04            [ 1]  200 	ld	a, (0x04, sp)
      00812A AB 30            [ 1]  201 	add	a, #0x30
      00812C 1E 01            [ 2]  202 	ldw	x, (0x01, sp)
      00812E F7               [ 1]  203 	ld	(x), a
                                    204 ;	main.c: 23: rx_int_chars[1] = num % 10 + '0';
      00812F 1E 05            [ 2]  205 	ldw	x, (0x05, sp)
      008131 7B 09            [ 1]  206 	ld	a, (0x09, sp)
      008133 F7               [ 1]  207 	ld	(x), a
                                    208 ;	main.c: 24: rx_int_chars[2] ='\0';
      008134 1E 07            [ 2]  209 	ldw	x, (0x07, sp)
      008136 7F               [ 1]  210 	clr	(x)
      008137 20 0A            [ 2]  211 	jra	00107$
      008139                        212 00102$:
                                    213 ;	main.c: 29: rx_int_chars[0] = num + '0';
      008139 7B 0B            [ 1]  214 	ld	a, (0x0b, sp)
      00813B AB 30            [ 1]  215 	add	a, #0x30
      00813D 1E 01            [ 2]  216 	ldw	x, (0x01, sp)
      00813F F7               [ 1]  217 	ld	(x), a
                                    218 ;	main.c: 30: rx_int_chars[1] ='\0';
      008140 1E 05            [ 2]  219 	ldw	x, (0x05, sp)
      008142 7F               [ 1]  220 	clr	(x)
      008143                        221 00107$:
                                    222 ;	main.c: 32: }
      008143 1E 0C            [ 2]  223 	ldw	x, (12, sp)
      008145 5B 0F            [ 2]  224 	addw	sp, #15
      008147 FC               [ 2]  225 	jp	(x)
                                    226 ;	main.c: 34: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    227 ;	-----------------------------------------
                                    228 ;	 function convert_int_to_binary
                                    229 ;	-----------------------------------------
      008148                        230 _convert_int_to_binary:
      008148 52 04            [ 2]  231 	sub	sp, #4
      00814A 1F 01            [ 2]  232 	ldw	(0x01, sp), x
                                    233 ;	main.c: 36: for(int i = 7; i >= 0; i--) {
      00814C AE 00 07         [ 2]  234 	ldw	x, #0x0007
      00814F 1F 03            [ 2]  235 	ldw	(0x03, sp), x
      008151                        236 00103$:
      008151 0D 03            [ 1]  237 	tnz	(0x03, sp)
      008153 2B 22            [ 1]  238 	jrmi	00101$
                                    239 ;	main.c: 38: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008155 AE 00 07         [ 2]  240 	ldw	x, #0x0007
      008158 72 F0 03         [ 2]  241 	subw	x, (0x03, sp)
      00815B 72 FB 07         [ 2]  242 	addw	x, (0x07, sp)
      00815E 16 01            [ 2]  243 	ldw	y, (0x01, sp)
      008160 7B 04            [ 1]  244 	ld	a, (0x04, sp)
      008162 27 05            [ 1]  245 	jreq	00120$
      008164                        246 00119$:
      008164 90 57            [ 2]  247 	sraw	y
      008166 4A               [ 1]  248 	dec	a
      008167 26 FB            [ 1]  249 	jrne	00119$
      008169                        250 00120$:
      008169 90 9F            [ 1]  251 	ld	a, yl
      00816B A4 01            [ 1]  252 	and	a, #0x01
      00816D AB 30            [ 1]  253 	add	a, #0x30
      00816F F7               [ 1]  254 	ld	(x), a
                                    255 ;	main.c: 36: for(int i = 7; i >= 0; i--) {
      008170 1E 03            [ 2]  256 	ldw	x, (0x03, sp)
      008172 5A               [ 2]  257 	decw	x
      008173 1F 03            [ 2]  258 	ldw	(0x03, sp), x
      008175 20 DA            [ 2]  259 	jra	00103$
      008177                        260 00101$:
                                    261 ;	main.c: 40: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008177 1E 07            [ 2]  262 	ldw	x, (0x07, sp)
      008179 6F 08            [ 1]  263 	clr	(0x0008, x)
                                    264 ;	main.c: 41: }
      00817B 1E 05            [ 2]  265 	ldw	x, (5, sp)
      00817D 5B 08            [ 2]  266 	addw	sp, #8
      00817F FC               [ 2]  267 	jp	(x)
                                    268 ;	main.c: 46: int uart_write_line(const char *str) {
                                    269 ;	-----------------------------------------
                                    270 ;	 function uart_write_line
                                    271 ;	-----------------------------------------
      008180                        272 _uart_write_line:
      008180 52 05            [ 2]  273 	sub	sp, #5
      008182 1F 03            [ 2]  274 	ldw	(0x03, sp), x
                                    275 ;	main.c: 48: for(i = 0; i < strlen(str); i++) {
      008184 0F 05            [ 1]  276 	clr	(0x05, sp)
      008186                        277 00106$:
      008186 1E 03            [ 2]  278 	ldw	x, (0x03, sp)
      008188 CD 82 CE         [ 4]  279 	call	_strlen
      00818B 1F 01            [ 2]  280 	ldw	(0x01, sp), x
      00818D 5F               [ 1]  281 	clrw	x
      00818E 7B 05            [ 1]  282 	ld	a, (0x05, sp)
      008190 97               [ 1]  283 	ld	xl, a
      008191 13 01            [ 2]  284 	cpw	x, (0x01, sp)
      008193 24 14            [ 1]  285 	jrnc	00104$
                                    286 ;	main.c: 49: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      008195                        287 00101$:
      008195 C6 52 30         [ 1]  288 	ld	a, 0x5230
      008198 2A FB            [ 1]  289 	jrpl	00101$
                                    290 ;	main.c: 50: UART1_DR = str[i];
      00819A 5F               [ 1]  291 	clrw	x
      00819B 7B 05            [ 1]  292 	ld	a, (0x05, sp)
      00819D 97               [ 1]  293 	ld	xl, a
      00819E 72 FB 03         [ 2]  294 	addw	x, (0x03, sp)
      0081A1 F6               [ 1]  295 	ld	a, (x)
      0081A2 C7 52 31         [ 1]  296 	ld	0x5231, a
                                    297 ;	main.c: 48: for(i = 0; i < strlen(str); i++) {
      0081A5 0C 05            [ 1]  298 	inc	(0x05, sp)
      0081A7 20 DD            [ 2]  299 	jra	00106$
      0081A9                        300 00104$:
                                    301 ;	main.c: 52: return(i); // Bytes sent
      0081A9 7B 05            [ 1]  302 	ld	a, (0x05, sp)
      0081AB 5F               [ 1]  303 	clrw	x
      0081AC 97               [ 1]  304 	ld	xl, a
                                    305 ;	main.c: 53: }
      0081AD 5B 05            [ 2]  306 	addw	sp, #5
      0081AF 81               [ 4]  307 	ret
                                    308 ;	main.c: 57: int main(void)
                                    309 ;	-----------------------------------------
                                    310 ;	 function main
                                    311 ;	-----------------------------------------
      0081B0                        312 _main:
      0081B0 52 0E            [ 2]  313 	sub	sp, #14
                                    314 ;	main.c: 60: CLK_CKDIVR = 0;
      0081B2 35 00 50 C6      [ 1]  315 	mov	0x50c6+0, #0x00
                                    316 ;	main.c: 63: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0081B6 72 16 52 35      [ 1]  317 	bset	0x5235, #3
                                    318 ;	main.c: 65: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0081BA C6 52 36         [ 1]  319 	ld	a, 0x5236
      0081BD A4 CF            [ 1]  320 	and	a, #0xcf
      0081BF C7 52 36         [ 1]  321 	ld	0x5236, a
                                    322 ;	main.c: 67: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0081C2 35 03 52 33      [ 1]  323 	mov	0x5233+0, #0x03
      0081C6 35 68 52 32      [ 1]  324 	mov	0x5232+0, #0x68
                                    325 ;	main.c: 71: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      0081CA 72 11 52 10      [ 1]  326 	bres	0x5210, #0
                                    327 ;	main.c: 72: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      0081CE 35 10 52 12      [ 1]  328 	mov	0x5212+0, #0x10
                                    329 ;	main.c: 73: I2C_CCRH = 0;                   // =0
      0081D2 35 00 52 1C      [ 1]  330 	mov	0x521c+0, #0x00
                                    331 ;	main.c: 74: I2C_CCRL = 80;                  // 100kHz for I2C
      0081D6 35 50 52 1B      [ 1]  332 	mov	0x521b+0, #0x50
                                    333 ;	main.c: 75: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0081DA 72 1F 52 1C      [ 1]  334 	bres	0x521c, #7
                                    335 ;	main.c: 76: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0081DE 72 1F 52 14      [ 1]  336 	bres	0x5214, #7
                                    337 ;	main.c: 77: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0081E2 72 1C 52 14      [ 1]  338 	bset	0x5214, #6
                                    339 ;	main.c: 78: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0081E6 72 10 52 10      [ 1]  340 	bset	0x5210, #0
                                    341 ;	main.c: 84: uart_write_line("Start Scanning\n");
      0081EA AE 80 2D         [ 2]  342 	ldw	x, #(___str_0+0)
      0081ED CD 81 80         [ 4]  343 	call	_uart_write_line
                                    344 ;	main.c: 86: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
      0081F0 0F 0E            [ 1]  345 	clr	(0x0e, sp)
      0081F2                        346 00106$:
      0081F2 7B 0E            [ 1]  347 	ld	a, (0x0e, sp)
      0081F4 A1 FF            [ 1]  348 	cp	a, #0xff
      0081F6 25 03            [ 1]  349 	jrc	00131$
      0081F8 CC 82 C8         [ 2]  350 	jp	00104$
      0081FB                        351 00131$:
                                    352 ;	main.c: 89: uart_write_line("_______Start______\n");
      0081FB AE 80 3D         [ 2]  353 	ldw	x, #(___str_1+0)
      0081FE CD 81 80         [ 4]  354 	call	_uart_write_line
                                    355 ;	main.c: 90: uart_write_line("Dev ->  ");
      008201 AE 80 51         [ 2]  356 	ldw	x, #(___str_2+0)
      008204 CD 81 80         [ 4]  357 	call	_uart_write_line
                                    358 ;	main.c: 91: char rx_int_chars[4]={0};
      008207 0F 01            [ 1]  359 	clr	(0x01, sp)
      008209 0F 02            [ 1]  360 	clr	(0x02, sp)
      00820B 0F 03            [ 1]  361 	clr	(0x03, sp)
      00820D 0F 04            [ 1]  362 	clr	(0x04, sp)
                                    363 ;	main.c: 92: char rx_binary_chars[9]={0};
      00820F 0F 05            [ 1]  364 	clr	(0x05, sp)
      008211 0F 06            [ 1]  365 	clr	(0x06, sp)
      008213 0F 07            [ 1]  366 	clr	(0x07, sp)
      008215 0F 08            [ 1]  367 	clr	(0x08, sp)
      008217 0F 09            [ 1]  368 	clr	(0x09, sp)
      008219 0F 0A            [ 1]  369 	clr	(0x0a, sp)
      00821B 0F 0B            [ 1]  370 	clr	(0x0b, sp)
      00821D 0F 0C            [ 1]  371 	clr	(0x0c, sp)
      00821F 0F 0D            [ 1]  372 	clr	(0x0d, sp)
                                    373 ;	main.c: 93: convert_int_to_chars(addr, rx_int_chars);
      008221 96               [ 1]  374 	ldw	x, sp
      008222 5C               [ 1]  375 	incw	x
      008223 51               [ 1]  376 	exgw	x, y
      008224 5F               [ 1]  377 	clrw	x
      008225 7B 0E            [ 1]  378 	ld	a, (0x0e, sp)
      008227 97               [ 1]  379 	ld	xl, a
      008228 90 89            [ 2]  380 	pushw	y
      00822A CD 80 C3         [ 4]  381 	call	_convert_int_to_chars
                                    382 ;	main.c: 94: uart_write_line(rx_int_chars);
      00822D 96               [ 1]  383 	ldw	x, sp
      00822E 5C               [ 1]  384 	incw	x
      00822F CD 81 80         [ 4]  385 	call	_uart_write_line
                                    386 ;	main.c: 95: uart_write_line("  <- Dev\n");
      008232 AE 80 5A         [ 2]  387 	ldw	x, #(___str_3+0)
      008235 CD 81 80         [ 4]  388 	call	_uart_write_line
                                    389 ;	main.c: 98: I2C_CR2 |= (1 << 2); // Set ACK bit
      008238 72 14 52 11      [ 1]  390 	bset	0x5211, #2
                                    391 ;	main.c: 99: I2C_CR2 |= (1 << 0); // START
      00823C 72 10 52 11      [ 1]  392 	bset	0x5211, #0
                                    393 ;	main.c: 100: while (!(I2C_SR1 & (1 << 0)));
      008240                        394 00101$:
      008240 72 01 52 17 FB   [ 2]  395 	btjf	0x5217, #0, 00101$
                                    396 ;	main.c: 101: I2C_SR1 = 0x00;
      008245 35 00 52 17      [ 1]  397 	mov	0x5217+0, #0x00
                                    398 ;	main.c: 102: I2C_DR = addr;
      008249 AE 52 16         [ 2]  399 	ldw	x, #0x5216
      00824C 7B 0E            [ 1]  400 	ld	a, (0x0e, sp)
      00824E F7               [ 1]  401 	ld	(x), a
                                    402 ;	main.c: 107: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      00824F 96               [ 1]  403 	ldw	x, sp
      008250 1C 00 05         [ 2]  404 	addw	x, #5
      008253 51               [ 1]  405 	exgw	x, y
      008254 C6 52 17         [ 1]  406 	ld	a, 0x5217
      008257 5F               [ 1]  407 	clrw	x
      008258 90 89            [ 2]  408 	pushw	y
      00825A 97               [ 1]  409 	ld	xl, a
      00825B CD 81 48         [ 4]  410 	call	_convert_int_to_binary
                                    411 ;	main.c: 108: uart_write_line("SR1 -> ");
      00825E AE 80 64         [ 2]  412 	ldw	x, #(___str_4+0)
      008261 CD 81 80         [ 4]  413 	call	_uart_write_line
                                    414 ;	main.c: 109: uart_write_line(rx_binary_chars);
      008264 96               [ 1]  415 	ldw	x, sp
      008265 1C 00 05         [ 2]  416 	addw	x, #5
      008268 CD 81 80         [ 4]  417 	call	_uart_write_line
                                    418 ;	main.c: 110: uart_write_line(" <-\n");
      00826B AE 80 6C         [ 2]  419 	ldw	x, #(___str_5+0)
      00826E CD 81 80         [ 4]  420 	call	_uart_write_line
                                    421 ;	main.c: 111: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008271 96               [ 1]  422 	ldw	x, sp
      008272 1C 00 05         [ 2]  423 	addw	x, #5
      008275 51               [ 1]  424 	exgw	x, y
      008276 C6 52 18         [ 1]  425 	ld	a, 0x5218
      008279 5F               [ 1]  426 	clrw	x
      00827A 90 89            [ 2]  427 	pushw	y
      00827C 97               [ 1]  428 	ld	xl, a
      00827D CD 81 48         [ 4]  429 	call	_convert_int_to_binary
                                    430 ;	main.c: 112: uart_write_line("SR2 -> ");
      008280 AE 80 71         [ 2]  431 	ldw	x, #(___str_6+0)
      008283 CD 81 80         [ 4]  432 	call	_uart_write_line
                                    433 ;	main.c: 113: uart_write_line(rx_binary_chars);
      008286 96               [ 1]  434 	ldw	x, sp
      008287 1C 00 05         [ 2]  435 	addw	x, #5
      00828A CD 81 80         [ 4]  436 	call	_uart_write_line
                                    437 ;	main.c: 114: uart_write_line(" <-\n");
      00828D AE 80 6C         [ 2]  438 	ldw	x, #(___str_5+0)
      008290 CD 81 80         [ 4]  439 	call	_uart_write_line
                                    440 ;	main.c: 115: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008293 96               [ 1]  441 	ldw	x, sp
      008294 1C 00 05         [ 2]  442 	addw	x, #5
      008297 51               [ 1]  443 	exgw	x, y
      008298 C6 52 19         [ 1]  444 	ld	a, 0x5219
      00829B 5F               [ 1]  445 	clrw	x
      00829C 90 89            [ 2]  446 	pushw	y
      00829E 97               [ 1]  447 	ld	xl, a
      00829F CD 81 48         [ 4]  448 	call	_convert_int_to_binary
                                    449 ;	main.c: 116: uart_write_line("SR3 -> ");
      0082A2 AE 80 79         [ 2]  450 	ldw	x, #(___str_7+0)
      0082A5 CD 81 80         [ 4]  451 	call	_uart_write_line
                                    452 ;	main.c: 117: uart_write_line(rx_binary_chars);
      0082A8 96               [ 1]  453 	ldw	x, sp
      0082A9 1C 00 05         [ 2]  454 	addw	x, #5
      0082AC CD 81 80         [ 4]  455 	call	_uart_write_line
                                    456 ;	main.c: 118: uart_write_line(" <-\n");
      0082AF AE 80 6C         [ 2]  457 	ldw	x, #(___str_5+0)
      0082B2 CD 81 80         [ 4]  458 	call	_uart_write_line
                                    459 ;	main.c: 120: I2C_SR1 = 0x00;
      0082B5 35 00 52 17      [ 1]  460 	mov	0x5217+0, #0x00
                                    461 ;	main.c: 121: I2C_SR3 = 0x00;
      0082B9 35 00 52 19      [ 1]  462 	mov	0x5219+0, #0x00
                                    463 ;	main.c: 124: uart_write_line("_______Stop_______\n");
      0082BD AE 80 81         [ 2]  464 	ldw	x, #(___str_8+0)
      0082C0 CD 81 80         [ 4]  465 	call	_uart_write_line
                                    466 ;	main.c: 86: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
      0082C3 0C 0E            [ 1]  467 	inc	(0x0e, sp)
      0082C5 CC 81 F2         [ 2]  468 	jp	00106$
      0082C8                        469 00104$:
                                    470 ;	main.c: 130: return 0;
      0082C8 5F               [ 1]  471 	clrw	x
                                    472 ;	main.c: 131: }
      0082C9 5B 0E            [ 2]  473 	addw	sp, #14
      0082CB 81               [ 4]  474 	ret
                                    475 	.area CODE
                                    476 	.area CONST
                                    477 	.area CONST
      00802D                        478 ___str_0:
      00802D 53 74 61 72 74 20 53   479 	.ascii "Start Scanning"
             63 61 6E 6E 69 6E 67
      00803B 0A                     480 	.db 0x0a
      00803C 00                     481 	.db 0x00
                                    482 	.area CODE
                                    483 	.area CONST
      00803D                        484 ___str_1:
      00803D 5F 5F 5F 5F 5F 5F 5F   485 	.ascii "_______Start______"
             53 74 61 72 74 5F 5F
             5F 5F 5F 5F
      00804F 0A                     486 	.db 0x0a
      008050 00                     487 	.db 0x00
                                    488 	.area CODE
                                    489 	.area CONST
      008051                        490 ___str_2:
      008051 44 65 76 20 2D 3E 20   491 	.ascii "Dev ->  "
             20
      008059 00                     492 	.db 0x00
                                    493 	.area CODE
                                    494 	.area CONST
      00805A                        495 ___str_3:
      00805A 20 20 3C 2D 20 44 65   496 	.ascii "  <- Dev"
             76
      008062 0A                     497 	.db 0x0a
      008063 00                     498 	.db 0x00
                                    499 	.area CODE
                                    500 	.area CONST
      008064                        501 ___str_4:
      008064 53 52 31 20 2D 3E 20   502 	.ascii "SR1 -> "
      00806B 00                     503 	.db 0x00
                                    504 	.area CODE
                                    505 	.area CONST
      00806C                        506 ___str_5:
      00806C 20 3C 2D               507 	.ascii " <-"
      00806F 0A                     508 	.db 0x0a
      008070 00                     509 	.db 0x00
                                    510 	.area CODE
                                    511 	.area CONST
      008071                        512 ___str_6:
      008071 53 52 32 20 2D 3E 20   513 	.ascii "SR2 -> "
      008078 00                     514 	.db 0x00
                                    515 	.area CODE
                                    516 	.area CONST
      008079                        517 ___str_7:
      008079 53 52 33 20 2D 3E 20   518 	.ascii "SR3 -> "
      008080 00                     519 	.db 0x00
                                    520 	.area CODE
                                    521 	.area CONST
      008081                        522 ___str_8:
      008081 5F 5F 5F 5F 5F 5F 5F   523 	.ascii "_______Stop_______"
             53 74 6F 70 5F 5F 5F
             5F 5F 5F 5F
      008093 0A                     524 	.db 0x0a
      008094 00                     525 	.db 0x00
                                    526 	.area CODE
                                    527 	.area INITIALIZER
                                    528 	.area CABS (ABS)
