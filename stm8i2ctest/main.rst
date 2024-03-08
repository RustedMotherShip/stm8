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
                                     12 	.globl _uart_read
                                     13 	.globl _i2c_scan
                                     14 	.globl _i2c_stop
                                     15 	.globl _i2c_send_address
                                     16 	.globl _i2c_start
                                     17 	.globl _i2c_init
                                     18 	.globl _uart_init
                                     19 	.globl _status_check
                                     20 	.globl _convert_int_to_binary
                                     21 	.globl _convert_int_to_chars
                                     22 	.globl _uart_write
                                     23 	.globl _UART_RX
                                     24 	.globl _UART_TX
                                     25 	.globl _delay
                                     26 	.globl _strlen
                                     27 	.globl _memset
                                     28 	.globl _current_dev
                                     29 	.globl _buffer
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area DATA
                                     34 ;--------------------------------------------------------
                                     35 ; ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area INITIALIZED
      000001                         38 _buffer::
      000001                         39 	.ds 256
      000101                         40 _current_dev::
      000101                         41 	.ds 1
                                     42 ;--------------------------------------------------------
                                     43 ; Stack segment in internal ram
                                     44 ;--------------------------------------------------------
                                     45 	.area SSEG
      000102                         46 __start__stack:
      000102                         47 	.ds	1
                                     48 
                                     49 ;--------------------------------------------------------
                                     50 ; absolute external ram data
                                     51 ;--------------------------------------------------------
                                     52 	.area DABS (ABS)
                                     53 
                                     54 ; default segment ordering for linker
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area CONST
                                     59 	.area INITIALIZER
                                     60 	.area CODE
                                     61 
                                     62 ;--------------------------------------------------------
                                     63 ; interrupt vector
                                     64 ;--------------------------------------------------------
                                     65 	.area HOME
      008000                         66 __interrupt_vect:
      008000 82 00 80 07             67 	int s_GSINIT ; reset
                                     68 ;--------------------------------------------------------
                                     69 ; global & static initialisations
                                     70 ;--------------------------------------------------------
                                     71 	.area HOME
                                     72 	.area GSINIT
                                     73 	.area GSFINAL
                                     74 	.area GSINIT
      008007 CD 86 D2         [ 4]   75 	call	___sdcc_external_startup
      00800A 4D               [ 1]   76 	tnz	a
      00800B 27 03            [ 1]   77 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   78 	jp	__sdcc_program_startup
      008010                         79 __sdcc_init_data:
                                     80 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   81 	ldw x, #l_DATA
      008013 27 07            [ 1]   82 	jreq	00002$
      008015                         83 00001$:
      008015 72 4F 00 00      [ 1]   84 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   85 	decw x
      00801A 26 F9            [ 1]   86 	jrne	00001$
      00801C                         87 00002$:
      00801C AE 01 01         [ 2]   88 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   89 	jreq	00004$
      008021                         90 00003$:
      008021 D6 81 10         [ 1]   91 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   92 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   93 	decw	x
      008028 26 F7            [ 1]   94 	jrne	00003$
      00802A                         95 00004$:
                                     96 ; stm8_genXINIT() end
                                     97 	.area GSFINAL
      00802A CC 80 04         [ 2]   98 	jp	__sdcc_program_startup
                                     99 ;--------------------------------------------------------
                                    100 ; Home
                                    101 ;--------------------------------------------------------
                                    102 	.area HOME
                                    103 	.area HOME
      008004                        104 __sdcc_program_startup:
      008004 CC 86 70         [ 2]  105 	jp	_main
                                    106 ;	return from main will return to caller
                                    107 ;--------------------------------------------------------
                                    108 ; code
                                    109 ;--------------------------------------------------------
                                    110 	.area CODE
                                    111 ;	main.c: 8: void delay(unsigned long count) {
                                    112 ;	-----------------------------------------
                                    113 ;	 function delay
                                    114 ;	-----------------------------------------
      008212                        115 _delay:
      008212 52 08            [ 2]  116 	sub	sp, #8
                                    117 ;	main.c: 9: while (count--)
      008214 16 0D            [ 2]  118 	ldw	y, (0x0d, sp)
      008216 17 07            [ 2]  119 	ldw	(0x07, sp), y
      008218 1E 0B            [ 2]  120 	ldw	x, (0x0b, sp)
      00821A                        121 00101$:
      00821A 1F 01            [ 2]  122 	ldw	(0x01, sp), x
      00821C 7B 07            [ 1]  123 	ld	a, (0x07, sp)
      00821E 6B 03            [ 1]  124 	ld	(0x03, sp), a
      008220 7B 08            [ 1]  125 	ld	a, (0x08, sp)
      008222 16 07            [ 2]  126 	ldw	y, (0x07, sp)
      008224 72 A2 00 01      [ 2]  127 	subw	y, #0x0001
      008228 17 07            [ 2]  128 	ldw	(0x07, sp), y
      00822A 24 01            [ 1]  129 	jrnc	00117$
      00822C 5A               [ 2]  130 	decw	x
      00822D                        131 00117$:
      00822D 4D               [ 1]  132 	tnz	a
      00822E 26 08            [ 1]  133 	jrne	00118$
      008230 16 02            [ 2]  134 	ldw	y, (0x02, sp)
      008232 26 04            [ 1]  135 	jrne	00118$
      008234 0D 01            [ 1]  136 	tnz	(0x01, sp)
      008236 27 03            [ 1]  137 	jreq	00104$
      008238                        138 00118$:
                                    139 ;	main.c: 10: nop();
      008238 9D               [ 1]  140 	nop
      008239 20 DF            [ 2]  141 	jra	00101$
      00823B                        142 00104$:
                                    143 ;	main.c: 11: }
      00823B 1E 09            [ 2]  144 	ldw	x, (9, sp)
      00823D 5B 0E            [ 2]  145 	addw	sp, #14
      00823F FC               [ 2]  146 	jp	(x)
                                    147 ;	main.c: 12: void UART_TX(unsigned char value)
                                    148 ;	-----------------------------------------
                                    149 ;	 function UART_TX
                                    150 ;	-----------------------------------------
      008240                        151 _UART_TX:
                                    152 ;	main.c: 14: UART1_DR = value;
      008240 C7 52 31         [ 1]  153 	ld	0x5231, a
                                    154 ;	main.c: 15: while(!(UART1_SR & UART_SR_TXE));
      008243                        155 00101$:
      008243 C6 52 30         [ 1]  156 	ld	a, 0x5230
      008246 2A FB            [ 1]  157 	jrpl	00101$
                                    158 ;	main.c: 16: }
      008248 81               [ 4]  159 	ret
                                    160 ;	main.c: 17: unsigned char UART_RX(void)
                                    161 ;	-----------------------------------------
                                    162 ;	 function UART_RX
                                    163 ;	-----------------------------------------
      008249                        164 _UART_RX:
                                    165 ;	main.c: 19: while(!(UART1_SR & UART_SR_TXE));
      008249                        166 00101$:
      008249 C6 52 30         [ 1]  167 	ld	a, 0x5230
      00824C 2A FB            [ 1]  168 	jrpl	00101$
                                    169 ;	main.c: 20: return UART1_DR;
      00824E C6 52 31         [ 1]  170 	ld	a, 0x5231
                                    171 ;	main.c: 21: }
      008251 81               [ 4]  172 	ret
                                    173 ;	main.c: 22: int uart_write(const char *str) {
                                    174 ;	-----------------------------------------
                                    175 ;	 function uart_write
                                    176 ;	-----------------------------------------
      008252                        177 _uart_write:
      008252 52 05            [ 2]  178 	sub	sp, #5
      008254 1F 03            [ 2]  179 	ldw	(0x03, sp), x
                                    180 ;	main.c: 24: for(i = 0; i < strlen(str); i++) {
      008256 0F 05            [ 1]  181 	clr	(0x05, sp)
      008258                        182 00103$:
      008258 1E 03            [ 2]  183 	ldw	x, (0x03, sp)
      00825A CD 86 D4         [ 4]  184 	call	_strlen
      00825D 1F 01            [ 2]  185 	ldw	(0x01, sp), x
      00825F 7B 05            [ 1]  186 	ld	a, (0x05, sp)
      008261 5F               [ 1]  187 	clrw	x
      008262 97               [ 1]  188 	ld	xl, a
      008263 13 01            [ 2]  189 	cpw	x, (0x01, sp)
      008265 24 0F            [ 1]  190 	jrnc	00101$
                                    191 ;	main.c: 26: UART_TX(str[i]);
      008267 5F               [ 1]  192 	clrw	x
      008268 7B 05            [ 1]  193 	ld	a, (0x05, sp)
      00826A 97               [ 1]  194 	ld	xl, a
      00826B 72 FB 03         [ 2]  195 	addw	x, (0x03, sp)
      00826E F6               [ 1]  196 	ld	a, (x)
      00826F CD 82 40         [ 4]  197 	call	_UART_TX
                                    198 ;	main.c: 24: for(i = 0; i < strlen(str); i++) {
      008272 0C 05            [ 1]  199 	inc	(0x05, sp)
      008274 20 E2            [ 2]  200 	jra	00103$
      008276                        201 00101$:
                                    202 ;	main.c: 28: return(i); // Bytes sent
      008276 7B 05            [ 1]  203 	ld	a, (0x05, sp)
      008278 5F               [ 1]  204 	clrw	x
      008279 97               [ 1]  205 	ld	xl, a
                                    206 ;	main.c: 29: }
      00827A 5B 05            [ 2]  207 	addw	sp, #5
      00827C 81               [ 4]  208 	ret
                                    209 ;	main.c: 33: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    210 ;	-----------------------------------------
                                    211 ;	 function convert_int_to_chars
                                    212 ;	-----------------------------------------
      00827D                        213 _convert_int_to_chars:
      00827D 52 0D            [ 2]  214 	sub	sp, #13
      00827F 6B 0D            [ 1]  215 	ld	(0x0d, sp), a
      008281 1F 0B            [ 2]  216 	ldw	(0x0b, sp), x
                                    217 ;	main.c: 36: rx_int_chars[0] = num / 100 + '0';
      008283 7B 0D            [ 1]  218 	ld	a, (0x0d, sp)
      008285 6B 02            [ 1]  219 	ld	(0x02, sp), a
      008287 0F 01            [ 1]  220 	clr	(0x01, sp)
                                    221 ;	main.c: 37: rx_int_chars[1] = num / 10 % 10 + '0';
      008289 1E 0B            [ 2]  222 	ldw	x, (0x0b, sp)
      00828B 5C               [ 1]  223 	incw	x
      00828C 1F 03            [ 2]  224 	ldw	(0x03, sp), x
                                    225 ;	main.c: 38: rx_int_chars[2] = num % 10 + '0';
      00828E 1E 0B            [ 2]  226 	ldw	x, (0x0b, sp)
      008290 5C               [ 1]  227 	incw	x
      008291 5C               [ 1]  228 	incw	x
      008292 1F 05            [ 2]  229 	ldw	(0x05, sp), x
                                    230 ;	main.c: 37: rx_int_chars[1] = num / 10 % 10 + '0';
      008294 4B 0A            [ 1]  231 	push	#0x0a
      008296 4B 00            [ 1]  232 	push	#0x00
      008298 1E 03            [ 2]  233 	ldw	x, (0x03, sp)
                                    234 ;	main.c: 38: rx_int_chars[2] = num % 10 + '0';
      00829A CD 86 F9         [ 4]  235 	call	__divsint
      00829D 1F 07            [ 2]  236 	ldw	(0x07, sp), x
      00829F 4B 0A            [ 1]  237 	push	#0x0a
      0082A1 4B 00            [ 1]  238 	push	#0x00
      0082A3 1E 03            [ 2]  239 	ldw	x, (0x03, sp)
      0082A5 CD 86 E1         [ 4]  240 	call	__modsint
      0082A8 9F               [ 1]  241 	ld	a, xl
      0082A9 AB 30            [ 1]  242 	add	a, #0x30
      0082AB 6B 09            [ 1]  243 	ld	(0x09, sp), a
                                    244 ;	main.c: 34: if (num > 99) {
      0082AD 7B 0D            [ 1]  245 	ld	a, (0x0d, sp)
      0082AF A1 63            [ 1]  246 	cp	a, #0x63
      0082B1 23 29            [ 2]  247 	jrule	00105$
                                    248 ;	main.c: 36: rx_int_chars[0] = num / 100 + '0';
      0082B3 4B 64            [ 1]  249 	push	#0x64
      0082B5 4B 00            [ 1]  250 	push	#0x00
      0082B7 1E 03            [ 2]  251 	ldw	x, (0x03, sp)
      0082B9 CD 86 F9         [ 4]  252 	call	__divsint
      0082BC 9F               [ 1]  253 	ld	a, xl
      0082BD AB 30            [ 1]  254 	add	a, #0x30
      0082BF 1E 0B            [ 2]  255 	ldw	x, (0x0b, sp)
      0082C1 F7               [ 1]  256 	ld	(x), a
                                    257 ;	main.c: 37: rx_int_chars[1] = num / 10 % 10 + '0';
      0082C2 4B 0A            [ 1]  258 	push	#0x0a
      0082C4 4B 00            [ 1]  259 	push	#0x00
      0082C6 1E 09            [ 2]  260 	ldw	x, (0x09, sp)
      0082C8 CD 86 E1         [ 4]  261 	call	__modsint
      0082CB 9F               [ 1]  262 	ld	a, xl
      0082CC AB 30            [ 1]  263 	add	a, #0x30
      0082CE 1E 03            [ 2]  264 	ldw	x, (0x03, sp)
      0082D0 F7               [ 1]  265 	ld	(x), a
                                    266 ;	main.c: 38: rx_int_chars[2] = num % 10 + '0';
      0082D1 1E 05            [ 2]  267 	ldw	x, (0x05, sp)
      0082D3 7B 09            [ 1]  268 	ld	a, (0x09, sp)
      0082D5 F7               [ 1]  269 	ld	(x), a
                                    270 ;	main.c: 39: rx_int_chars[3] ='\0';
      0082D6 1E 0B            [ 2]  271 	ldw	x, (0x0b, sp)
      0082D8 6F 03            [ 1]  272 	clr	(0x0003, x)
      0082DA 20 23            [ 2]  273 	jra	00107$
      0082DC                        274 00105$:
                                    275 ;	main.c: 41: } else if (num > 9) {
      0082DC 7B 0D            [ 1]  276 	ld	a, (0x0d, sp)
      0082DE A1 09            [ 1]  277 	cp	a, #0x09
      0082E0 23 13            [ 2]  278 	jrule	00102$
                                    279 ;	main.c: 43: rx_int_chars[0] = num / 10 + '0';
      0082E2 7B 08            [ 1]  280 	ld	a, (0x08, sp)
      0082E4 6B 0A            [ 1]  281 	ld	(0x0a, sp), a
      0082E6 AB 30            [ 1]  282 	add	a, #0x30
      0082E8 1E 0B            [ 2]  283 	ldw	x, (0x0b, sp)
      0082EA F7               [ 1]  284 	ld	(x), a
                                    285 ;	main.c: 44: rx_int_chars[1] = num % 10 + '0';
      0082EB 1E 03            [ 2]  286 	ldw	x, (0x03, sp)
      0082ED 7B 09            [ 1]  287 	ld	a, (0x09, sp)
      0082EF F7               [ 1]  288 	ld	(x), a
                                    289 ;	main.c: 45: rx_int_chars[2] ='\0';
      0082F0 1E 05            [ 2]  290 	ldw	x, (0x05, sp)
      0082F2 7F               [ 1]  291 	clr	(x)
      0082F3 20 0A            [ 2]  292 	jra	00107$
      0082F5                        293 00102$:
                                    294 ;	main.c: 50: rx_int_chars[0] = num + '0';
      0082F5 7B 0D            [ 1]  295 	ld	a, (0x0d, sp)
      0082F7 AB 30            [ 1]  296 	add	a, #0x30
      0082F9 1E 0B            [ 2]  297 	ldw	x, (0x0b, sp)
      0082FB F7               [ 1]  298 	ld	(x), a
                                    299 ;	main.c: 51: rx_int_chars[1] ='\0';
      0082FC 1E 03            [ 2]  300 	ldw	x, (0x03, sp)
      0082FE 7F               [ 1]  301 	clr	(x)
      0082FF                        302 00107$:
                                    303 ;	main.c: 53: }
      0082FF 5B 0D            [ 2]  304 	addw	sp, #13
      008301 81               [ 4]  305 	ret
                                    306 ;	main.c: 55: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    307 ;	-----------------------------------------
                                    308 ;	 function convert_int_to_binary
                                    309 ;	-----------------------------------------
      008302                        310 _convert_int_to_binary:
      008302 52 04            [ 2]  311 	sub	sp, #4
      008304 1F 01            [ 2]  312 	ldw	(0x01, sp), x
                                    313 ;	main.c: 57: for(int i = 7; i >= 0; i--) {
      008306 AE 00 07         [ 2]  314 	ldw	x, #0x0007
      008309 1F 03            [ 2]  315 	ldw	(0x03, sp), x
      00830B                        316 00103$:
      00830B 0D 03            [ 1]  317 	tnz	(0x03, sp)
      00830D 2B 22            [ 1]  318 	jrmi	00101$
                                    319 ;	main.c: 59: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      00830F AE 00 07         [ 2]  320 	ldw	x, #0x0007
      008312 72 F0 03         [ 2]  321 	subw	x, (0x03, sp)
      008315 72 FB 07         [ 2]  322 	addw	x, (0x07, sp)
      008318 16 01            [ 2]  323 	ldw	y, (0x01, sp)
      00831A 7B 04            [ 1]  324 	ld	a, (0x04, sp)
      00831C 27 05            [ 1]  325 	jreq	00120$
      00831E                        326 00119$:
      00831E 90 57            [ 2]  327 	sraw	y
      008320 4A               [ 1]  328 	dec	a
      008321 26 FB            [ 1]  329 	jrne	00119$
      008323                        330 00120$:
      008323 90 9F            [ 1]  331 	ld	a, yl
      008325 A4 01            [ 1]  332 	and	a, #0x01
      008327 AB 30            [ 1]  333 	add	a, #0x30
      008329 F7               [ 1]  334 	ld	(x), a
                                    335 ;	main.c: 57: for(int i = 7; i >= 0; i--) {
      00832A 1E 03            [ 2]  336 	ldw	x, (0x03, sp)
      00832C 5A               [ 2]  337 	decw	x
      00832D 1F 03            [ 2]  338 	ldw	(0x03, sp), x
      00832F 20 DA            [ 2]  339 	jra	00103$
      008331                        340 00101$:
                                    341 ;	main.c: 61: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008331 1E 07            [ 2]  342 	ldw	x, (0x07, sp)
      008333 6F 08            [ 1]  343 	clr	(0x0008, x)
                                    344 ;	main.c: 62: }
      008335 1E 05            [ 2]  345 	ldw	x, (5, sp)
      008337 5B 08            [ 2]  346 	addw	sp, #8
      008339 FC               [ 2]  347 	jp	(x)
                                    348 ;	main.c: 64: void status_check(void){
                                    349 ;	-----------------------------------------
                                    350 ;	 function status_check
                                    351 ;	-----------------------------------------
      00833A                        352 _status_check:
      00833A 52 09            [ 2]  353 	sub	sp, #9
                                    354 ;	main.c: 65: char rx_binary_chars[9]={0};
      00833C 0F 01            [ 1]  355 	clr	(0x01, sp)
      00833E 0F 02            [ 1]  356 	clr	(0x02, sp)
      008340 0F 03            [ 1]  357 	clr	(0x03, sp)
      008342 0F 04            [ 1]  358 	clr	(0x04, sp)
      008344 0F 05            [ 1]  359 	clr	(0x05, sp)
      008346 0F 06            [ 1]  360 	clr	(0x06, sp)
      008348 0F 07            [ 1]  361 	clr	(0x07, sp)
      00834A 0F 08            [ 1]  362 	clr	(0x08, sp)
      00834C 0F 09            [ 1]  363 	clr	(0x09, sp)
                                    364 ;	main.c: 66: uart_write("\nI2C_REGS >.<\n");
      00834E AE 80 2D         [ 2]  365 	ldw	x, #(___str_0+0)
      008351 CD 82 52         [ 4]  366 	call	_uart_write
                                    367 ;	main.c: 67: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      008354 96               [ 1]  368 	ldw	x, sp
      008355 5C               [ 1]  369 	incw	x
      008356 51               [ 1]  370 	exgw	x, y
      008357 C6 52 17         [ 1]  371 	ld	a, 0x5217
      00835A 5F               [ 1]  372 	clrw	x
      00835B 90 89            [ 2]  373 	pushw	y
      00835D 97               [ 1]  374 	ld	xl, a
      00835E CD 83 02         [ 4]  375 	call	_convert_int_to_binary
                                    376 ;	main.c: 68: uart_write("\nSR1 -> ");
      008361 AE 80 3C         [ 2]  377 	ldw	x, #(___str_1+0)
      008364 CD 82 52         [ 4]  378 	call	_uart_write
                                    379 ;	main.c: 69: uart_write(rx_binary_chars);
      008367 96               [ 1]  380 	ldw	x, sp
      008368 5C               [ 1]  381 	incw	x
      008369 CD 82 52         [ 4]  382 	call	_uart_write
                                    383 ;	main.c: 70: uart_write(" <-\n");
      00836C AE 80 45         [ 2]  384 	ldw	x, #(___str_2+0)
      00836F CD 82 52         [ 4]  385 	call	_uart_write
                                    386 ;	main.c: 71: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      008372 96               [ 1]  387 	ldw	x, sp
      008373 5C               [ 1]  388 	incw	x
      008374 51               [ 1]  389 	exgw	x, y
      008375 C6 52 18         [ 1]  390 	ld	a, 0x5218
      008378 5F               [ 1]  391 	clrw	x
      008379 90 89            [ 2]  392 	pushw	y
      00837B 97               [ 1]  393 	ld	xl, a
      00837C CD 83 02         [ 4]  394 	call	_convert_int_to_binary
                                    395 ;	main.c: 72: uart_write("SR2 -> ");
      00837F AE 80 4A         [ 2]  396 	ldw	x, #(___str_3+0)
      008382 CD 82 52         [ 4]  397 	call	_uart_write
                                    398 ;	main.c: 73: uart_write(rx_binary_chars);
      008385 96               [ 1]  399 	ldw	x, sp
      008386 5C               [ 1]  400 	incw	x
      008387 CD 82 52         [ 4]  401 	call	_uart_write
                                    402 ;	main.c: 74: uart_write(" <-\n");
      00838A AE 80 45         [ 2]  403 	ldw	x, #(___str_2+0)
      00838D CD 82 52         [ 4]  404 	call	_uart_write
                                    405 ;	main.c: 75: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008390 96               [ 1]  406 	ldw	x, sp
      008391 5C               [ 1]  407 	incw	x
      008392 51               [ 1]  408 	exgw	x, y
      008393 C6 52 19         [ 1]  409 	ld	a, 0x5219
      008396 5F               [ 1]  410 	clrw	x
      008397 90 89            [ 2]  411 	pushw	y
      008399 97               [ 1]  412 	ld	xl, a
      00839A CD 83 02         [ 4]  413 	call	_convert_int_to_binary
                                    414 ;	main.c: 76: uart_write("SR3 -> ");
      00839D AE 80 52         [ 2]  415 	ldw	x, #(___str_4+0)
      0083A0 CD 82 52         [ 4]  416 	call	_uart_write
                                    417 ;	main.c: 77: uart_write(rx_binary_chars);
      0083A3 96               [ 1]  418 	ldw	x, sp
      0083A4 5C               [ 1]  419 	incw	x
      0083A5 CD 82 52         [ 4]  420 	call	_uart_write
                                    421 ;	main.c: 78: uart_write(" <-\n");
      0083A8 AE 80 45         [ 2]  422 	ldw	x, #(___str_2+0)
      0083AB CD 82 52         [ 4]  423 	call	_uart_write
                                    424 ;	main.c: 79: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      0083AE 96               [ 1]  425 	ldw	x, sp
      0083AF 5C               [ 1]  426 	incw	x
      0083B0 51               [ 1]  427 	exgw	x, y
      0083B1 C6 52 10         [ 1]  428 	ld	a, 0x5210
      0083B4 5F               [ 1]  429 	clrw	x
      0083B5 90 89            [ 2]  430 	pushw	y
      0083B7 97               [ 1]  431 	ld	xl, a
      0083B8 CD 83 02         [ 4]  432 	call	_convert_int_to_binary
                                    433 ;	main.c: 80: uart_write("CR1 -> ");
      0083BB AE 80 5A         [ 2]  434 	ldw	x, #(___str_5+0)
      0083BE CD 82 52         [ 4]  435 	call	_uart_write
                                    436 ;	main.c: 81: uart_write(rx_binary_chars);
      0083C1 96               [ 1]  437 	ldw	x, sp
      0083C2 5C               [ 1]  438 	incw	x
      0083C3 CD 82 52         [ 4]  439 	call	_uart_write
                                    440 ;	main.c: 82: uart_write(" <-\n");
      0083C6 AE 80 45         [ 2]  441 	ldw	x, #(___str_2+0)
      0083C9 CD 82 52         [ 4]  442 	call	_uart_write
                                    443 ;	main.c: 83: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      0083CC 96               [ 1]  444 	ldw	x, sp
      0083CD 5C               [ 1]  445 	incw	x
      0083CE 51               [ 1]  446 	exgw	x, y
      0083CF C6 52 11         [ 1]  447 	ld	a, 0x5211
      0083D2 5F               [ 1]  448 	clrw	x
      0083D3 90 89            [ 2]  449 	pushw	y
      0083D5 97               [ 1]  450 	ld	xl, a
      0083D6 CD 83 02         [ 4]  451 	call	_convert_int_to_binary
                                    452 ;	main.c: 84: uart_write("CR2 -> ");
      0083D9 AE 80 62         [ 2]  453 	ldw	x, #(___str_6+0)
      0083DC CD 82 52         [ 4]  454 	call	_uart_write
                                    455 ;	main.c: 85: uart_write(rx_binary_chars);
      0083DF 96               [ 1]  456 	ldw	x, sp
      0083E0 5C               [ 1]  457 	incw	x
      0083E1 CD 82 52         [ 4]  458 	call	_uart_write
                                    459 ;	main.c: 86: uart_write(" <-\n");
      0083E4 AE 80 45         [ 2]  460 	ldw	x, #(___str_2+0)
      0083E7 CD 82 52         [ 4]  461 	call	_uart_write
                                    462 ;	main.c: 87: convert_int_to_binary(I2C_DR, rx_binary_chars);
      0083EA 96               [ 1]  463 	ldw	x, sp
      0083EB 5C               [ 1]  464 	incw	x
      0083EC 51               [ 1]  465 	exgw	x, y
      0083ED C6 52 16         [ 1]  466 	ld	a, 0x5216
      0083F0 5F               [ 1]  467 	clrw	x
      0083F1 90 89            [ 2]  468 	pushw	y
      0083F3 97               [ 1]  469 	ld	xl, a
      0083F4 CD 83 02         [ 4]  470 	call	_convert_int_to_binary
                                    471 ;	main.c: 88: uart_write("DR -> ");
      0083F7 AE 80 6A         [ 2]  472 	ldw	x, #(___str_7+0)
      0083FA CD 82 52         [ 4]  473 	call	_uart_write
                                    474 ;	main.c: 89: uart_write(rx_binary_chars);
      0083FD 96               [ 1]  475 	ldw	x, sp
      0083FE 5C               [ 1]  476 	incw	x
      0083FF CD 82 52         [ 4]  477 	call	_uart_write
                                    478 ;	main.c: 90: uart_write(" <-\n");
      008402 AE 80 45         [ 2]  479 	ldw	x, #(___str_2+0)
      008405 CD 82 52         [ 4]  480 	call	_uart_write
                                    481 ;	main.c: 91: uart_write("UART_REGS >.<\n");
      008408 AE 80 71         [ 2]  482 	ldw	x, #(___str_8+0)
      00840B CD 82 52         [ 4]  483 	call	_uart_write
                                    484 ;	main.c: 92: convert_int_to_binary(UART1_SR, rx_binary_chars);
      00840E 96               [ 1]  485 	ldw	x, sp
      00840F 5C               [ 1]  486 	incw	x
      008410 51               [ 1]  487 	exgw	x, y
      008411 C6 52 30         [ 1]  488 	ld	a, 0x5230
      008414 5F               [ 1]  489 	clrw	x
      008415 90 89            [ 2]  490 	pushw	y
      008417 97               [ 1]  491 	ld	xl, a
      008418 CD 83 02         [ 4]  492 	call	_convert_int_to_binary
                                    493 ;	main.c: 93: uart_write("\nSR -> ");
      00841B AE 80 80         [ 2]  494 	ldw	x, #(___str_9+0)
      00841E CD 82 52         [ 4]  495 	call	_uart_write
                                    496 ;	main.c: 94: uart_write(rx_binary_chars);
      008421 96               [ 1]  497 	ldw	x, sp
      008422 5C               [ 1]  498 	incw	x
      008423 CD 82 52         [ 4]  499 	call	_uart_write
                                    500 ;	main.c: 95: uart_write(" <-\n");
      008426 AE 80 45         [ 2]  501 	ldw	x, #(___str_2+0)
      008429 CD 82 52         [ 4]  502 	call	_uart_write
                                    503 ;	main.c: 96: convert_int_to_binary(UART1_DR, rx_binary_chars);
      00842C 96               [ 1]  504 	ldw	x, sp
      00842D 5C               [ 1]  505 	incw	x
      00842E 51               [ 1]  506 	exgw	x, y
      00842F C6 52 31         [ 1]  507 	ld	a, 0x5231
      008432 5F               [ 1]  508 	clrw	x
      008433 90 89            [ 2]  509 	pushw	y
      008435 97               [ 1]  510 	ld	xl, a
      008436 CD 83 02         [ 4]  511 	call	_convert_int_to_binary
                                    512 ;	main.c: 97: uart_write("DR -> ");
      008439 AE 80 6A         [ 2]  513 	ldw	x, #(___str_7+0)
      00843C CD 82 52         [ 4]  514 	call	_uart_write
                                    515 ;	main.c: 98: uart_write(rx_binary_chars);
      00843F 96               [ 1]  516 	ldw	x, sp
      008440 5C               [ 1]  517 	incw	x
      008441 CD 82 52         [ 4]  518 	call	_uart_write
                                    519 ;	main.c: 99: uart_write(" <-\n");
      008444 AE 80 45         [ 2]  520 	ldw	x, #(___str_2+0)
      008447 CD 82 52         [ 4]  521 	call	_uart_write
                                    522 ;	main.c: 100: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
      00844A 96               [ 1]  523 	ldw	x, sp
      00844B 5C               [ 1]  524 	incw	x
      00844C 51               [ 1]  525 	exgw	x, y
      00844D C6 52 32         [ 1]  526 	ld	a, 0x5232
      008450 5F               [ 1]  527 	clrw	x
      008451 90 89            [ 2]  528 	pushw	y
      008453 97               [ 1]  529 	ld	xl, a
      008454 CD 83 02         [ 4]  530 	call	_convert_int_to_binary
                                    531 ;	main.c: 101: uart_write("BRR1 -> ");
      008457 AE 80 88         [ 2]  532 	ldw	x, #(___str_10+0)
      00845A CD 82 52         [ 4]  533 	call	_uart_write
                                    534 ;	main.c: 102: uart_write(rx_binary_chars);
      00845D 96               [ 1]  535 	ldw	x, sp
      00845E 5C               [ 1]  536 	incw	x
      00845F CD 82 52         [ 4]  537 	call	_uart_write
                                    538 ;	main.c: 103: uart_write(" <-\n");
      008462 AE 80 45         [ 2]  539 	ldw	x, #(___str_2+0)
      008465 CD 82 52         [ 4]  540 	call	_uart_write
                                    541 ;	main.c: 104: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
      008468 96               [ 1]  542 	ldw	x, sp
      008469 5C               [ 1]  543 	incw	x
      00846A 51               [ 1]  544 	exgw	x, y
      00846B C6 52 33         [ 1]  545 	ld	a, 0x5233
      00846E 5F               [ 1]  546 	clrw	x
      00846F 90 89            [ 2]  547 	pushw	y
      008471 97               [ 1]  548 	ld	xl, a
      008472 CD 83 02         [ 4]  549 	call	_convert_int_to_binary
                                    550 ;	main.c: 105: uart_write("BRR2 -> ");
      008475 AE 80 91         [ 2]  551 	ldw	x, #(___str_11+0)
      008478 CD 82 52         [ 4]  552 	call	_uart_write
                                    553 ;	main.c: 106: uart_write(rx_binary_chars);
      00847B 96               [ 1]  554 	ldw	x, sp
      00847C 5C               [ 1]  555 	incw	x
      00847D CD 82 52         [ 4]  556 	call	_uart_write
                                    557 ;	main.c: 107: uart_write(" <-\n");
      008480 AE 80 45         [ 2]  558 	ldw	x, #(___str_2+0)
      008483 CD 82 52         [ 4]  559 	call	_uart_write
                                    560 ;	main.c: 108: convert_int_to_binary(UART1_CR1, rx_binary_chars);
      008486 96               [ 1]  561 	ldw	x, sp
      008487 5C               [ 1]  562 	incw	x
      008488 51               [ 1]  563 	exgw	x, y
      008489 C6 52 34         [ 1]  564 	ld	a, 0x5234
      00848C 5F               [ 1]  565 	clrw	x
      00848D 90 89            [ 2]  566 	pushw	y
      00848F 97               [ 1]  567 	ld	xl, a
      008490 CD 83 02         [ 4]  568 	call	_convert_int_to_binary
                                    569 ;	main.c: 109: uart_write("CR1 -> ");
      008493 AE 80 5A         [ 2]  570 	ldw	x, #(___str_5+0)
      008496 CD 82 52         [ 4]  571 	call	_uart_write
                                    572 ;	main.c: 110: uart_write(rx_binary_chars);
      008499 96               [ 1]  573 	ldw	x, sp
      00849A 5C               [ 1]  574 	incw	x
      00849B CD 82 52         [ 4]  575 	call	_uart_write
                                    576 ;	main.c: 111: uart_write(" <-\n");
      00849E AE 80 45         [ 2]  577 	ldw	x, #(___str_2+0)
      0084A1 CD 82 52         [ 4]  578 	call	_uart_write
                                    579 ;	main.c: 112: convert_int_to_binary(UART1_CR2, rx_binary_chars);
      0084A4 96               [ 1]  580 	ldw	x, sp
      0084A5 5C               [ 1]  581 	incw	x
      0084A6 51               [ 1]  582 	exgw	x, y
      0084A7 C6 52 35         [ 1]  583 	ld	a, 0x5235
      0084AA 5F               [ 1]  584 	clrw	x
      0084AB 90 89            [ 2]  585 	pushw	y
      0084AD 97               [ 1]  586 	ld	xl, a
      0084AE CD 83 02         [ 4]  587 	call	_convert_int_to_binary
                                    588 ;	main.c: 113: uart_write("CR2 -> ");
      0084B1 AE 80 62         [ 2]  589 	ldw	x, #(___str_6+0)
      0084B4 CD 82 52         [ 4]  590 	call	_uart_write
                                    591 ;	main.c: 114: uart_write(rx_binary_chars);
      0084B7 96               [ 1]  592 	ldw	x, sp
      0084B8 5C               [ 1]  593 	incw	x
      0084B9 CD 82 52         [ 4]  594 	call	_uart_write
                                    595 ;	main.c: 115: uart_write(" <-\n");
      0084BC AE 80 45         [ 2]  596 	ldw	x, #(___str_2+0)
      0084BF CD 82 52         [ 4]  597 	call	_uart_write
                                    598 ;	main.c: 116: convert_int_to_binary(UART1_CR3, rx_binary_chars);
      0084C2 96               [ 1]  599 	ldw	x, sp
      0084C3 5C               [ 1]  600 	incw	x
      0084C4 51               [ 1]  601 	exgw	x, y
      0084C5 C6 52 36         [ 1]  602 	ld	a, 0x5236
      0084C8 5F               [ 1]  603 	clrw	x
      0084C9 90 89            [ 2]  604 	pushw	y
      0084CB 97               [ 1]  605 	ld	xl, a
      0084CC CD 83 02         [ 4]  606 	call	_convert_int_to_binary
                                    607 ;	main.c: 117: uart_write("CR3 -> ");
      0084CF AE 80 9A         [ 2]  608 	ldw	x, #(___str_12+0)
      0084D2 CD 82 52         [ 4]  609 	call	_uart_write
                                    610 ;	main.c: 118: uart_write(rx_binary_chars);
      0084D5 96               [ 1]  611 	ldw	x, sp
      0084D6 5C               [ 1]  612 	incw	x
      0084D7 CD 82 52         [ 4]  613 	call	_uart_write
                                    614 ;	main.c: 119: uart_write(" <-\n");
      0084DA AE 80 45         [ 2]  615 	ldw	x, #(___str_2+0)
      0084DD CD 82 52         [ 4]  616 	call	_uart_write
                                    617 ;	main.c: 120: convert_int_to_binary(UART1_CR4, rx_binary_chars);
      0084E0 96               [ 1]  618 	ldw	x, sp
      0084E1 5C               [ 1]  619 	incw	x
      0084E2 51               [ 1]  620 	exgw	x, y
      0084E3 C6 52 37         [ 1]  621 	ld	a, 0x5237
      0084E6 5F               [ 1]  622 	clrw	x
      0084E7 90 89            [ 2]  623 	pushw	y
      0084E9 97               [ 1]  624 	ld	xl, a
      0084EA CD 83 02         [ 4]  625 	call	_convert_int_to_binary
                                    626 ;	main.c: 121: uart_write("CR4 -> ");
      0084ED AE 80 A2         [ 2]  627 	ldw	x, #(___str_13+0)
      0084F0 CD 82 52         [ 4]  628 	call	_uart_write
                                    629 ;	main.c: 122: uart_write(rx_binary_chars);
      0084F3 96               [ 1]  630 	ldw	x, sp
      0084F4 5C               [ 1]  631 	incw	x
      0084F5 CD 82 52         [ 4]  632 	call	_uart_write
                                    633 ;	main.c: 123: uart_write(" <-\n");
      0084F8 AE 80 45         [ 2]  634 	ldw	x, #(___str_2+0)
      0084FB CD 82 52         [ 4]  635 	call	_uart_write
                                    636 ;	main.c: 124: convert_int_to_binary(UART1_CR5, rx_binary_chars);
      0084FE 96               [ 1]  637 	ldw	x, sp
      0084FF 5C               [ 1]  638 	incw	x
      008500 51               [ 1]  639 	exgw	x, y
      008501 C6 52 38         [ 1]  640 	ld	a, 0x5238
      008504 5F               [ 1]  641 	clrw	x
      008505 90 89            [ 2]  642 	pushw	y
      008507 97               [ 1]  643 	ld	xl, a
      008508 CD 83 02         [ 4]  644 	call	_convert_int_to_binary
                                    645 ;	main.c: 125: uart_write("CR5 -> ");
      00850B AE 80 AA         [ 2]  646 	ldw	x, #(___str_14+0)
      00850E CD 82 52         [ 4]  647 	call	_uart_write
                                    648 ;	main.c: 126: uart_write(rx_binary_chars);
      008511 96               [ 1]  649 	ldw	x, sp
      008512 5C               [ 1]  650 	incw	x
      008513 CD 82 52         [ 4]  651 	call	_uart_write
                                    652 ;	main.c: 127: uart_write(" <-\n");
      008516 AE 80 45         [ 2]  653 	ldw	x, #(___str_2+0)
      008519 CD 82 52         [ 4]  654 	call	_uart_write
                                    655 ;	main.c: 128: convert_int_to_binary(UART1_GTR, rx_binary_chars);
      00851C 96               [ 1]  656 	ldw	x, sp
      00851D 5C               [ 1]  657 	incw	x
      00851E 51               [ 1]  658 	exgw	x, y
      00851F C6 52 39         [ 1]  659 	ld	a, 0x5239
      008522 5F               [ 1]  660 	clrw	x
      008523 90 89            [ 2]  661 	pushw	y
      008525 97               [ 1]  662 	ld	xl, a
      008526 CD 83 02         [ 4]  663 	call	_convert_int_to_binary
                                    664 ;	main.c: 129: uart_write("GTR -> ");
      008529 AE 80 B2         [ 2]  665 	ldw	x, #(___str_15+0)
      00852C CD 82 52         [ 4]  666 	call	_uart_write
                                    667 ;	main.c: 130: uart_write(rx_binary_chars);
      00852F 96               [ 1]  668 	ldw	x, sp
      008530 5C               [ 1]  669 	incw	x
      008531 CD 82 52         [ 4]  670 	call	_uart_write
                                    671 ;	main.c: 131: uart_write(" <-\n");
      008534 AE 80 45         [ 2]  672 	ldw	x, #(___str_2+0)
      008537 CD 82 52         [ 4]  673 	call	_uart_write
                                    674 ;	main.c: 132: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
      00853A 96               [ 1]  675 	ldw	x, sp
      00853B 5C               [ 1]  676 	incw	x
      00853C 51               [ 1]  677 	exgw	x, y
      00853D C6 52 3A         [ 1]  678 	ld	a, 0x523a
      008540 5F               [ 1]  679 	clrw	x
      008541 90 89            [ 2]  680 	pushw	y
      008543 97               [ 1]  681 	ld	xl, a
      008544 CD 83 02         [ 4]  682 	call	_convert_int_to_binary
                                    683 ;	main.c: 133: uart_write("PSCR -> ");
      008547 AE 80 BA         [ 2]  684 	ldw	x, #(___str_16+0)
      00854A CD 82 52         [ 4]  685 	call	_uart_write
                                    686 ;	main.c: 134: uart_write(rx_binary_chars);
      00854D 96               [ 1]  687 	ldw	x, sp
      00854E 5C               [ 1]  688 	incw	x
      00854F CD 82 52         [ 4]  689 	call	_uart_write
                                    690 ;	main.c: 135: uart_write(" <-\n");
      008552 AE 80 45         [ 2]  691 	ldw	x, #(___str_2+0)
      008555 CD 82 52         [ 4]  692 	call	_uart_write
                                    693 ;	main.c: 136: }
      008558 5B 09            [ 2]  694 	addw	sp, #9
      00855A 81               [ 4]  695 	ret
                                    696 ;	main.c: 138: void uart_init(void){
                                    697 ;	-----------------------------------------
                                    698 ;	 function uart_init
                                    699 ;	-----------------------------------------
      00855B                        700 _uart_init:
                                    701 ;	main.c: 139: CLK_CKDIVR = 0;
      00855B 35 00 50 C6      [ 1]  702 	mov	0x50c6+0, #0x00
                                    703 ;	main.c: 142: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00855F 72 16 52 35      [ 1]  704 	bset	0x5235, #3
                                    705 ;	main.c: 143: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      008563 72 14 52 35      [ 1]  706 	bset	0x5235, #2
                                    707 ;	main.c: 144: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008567 C6 52 36         [ 1]  708 	ld	a, 0x5236
      00856A A4 CF            [ 1]  709 	and	a, #0xcf
      00856C C7 52 36         [ 1]  710 	ld	0x5236, a
                                    711 ;	main.c: 146: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      00856F 35 03 52 33      [ 1]  712 	mov	0x5233+0, #0x03
      008573 35 68 52 32      [ 1]  713 	mov	0x5232+0, #0x68
                                    714 ;	main.c: 147: }
      008577 81               [ 4]  715 	ret
                                    716 ;	main.c: 151: void i2c_init(void) {
                                    717 ;	-----------------------------------------
                                    718 ;	 function i2c_init
                                    719 ;	-----------------------------------------
      008578                        720 _i2c_init:
                                    721 ;	main.c: 157: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008578 72 11 52 10      [ 1]  722 	bres	0x5210, #0
                                    723 ;	main.c: 158: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      00857C 35 10 52 12      [ 1]  724 	mov	0x5212+0, #0x10
                                    725 ;	main.c: 159: I2C_CCRH = 0;                   // =0
      008580 35 00 52 1C      [ 1]  726 	mov	0x521c+0, #0x00
                                    727 ;	main.c: 160: I2C_CCRL = 80;                  // 100kHz for I2C
      008584 35 50 52 1B      [ 1]  728 	mov	0x521b+0, #0x50
                                    729 ;	main.c: 161: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      008588 72 1F 52 1C      [ 1]  730 	bres	0x521c, #7
                                    731 ;	main.c: 162: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      00858C 72 1F 52 14      [ 1]  732 	bres	0x5214, #7
                                    733 ;	main.c: 163: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      008590 72 1C 52 14      [ 1]  734 	bset	0x5214, #6
                                    735 ;	main.c: 164: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      008594 72 10 52 10      [ 1]  736 	bset	0x5210, #0
                                    737 ;	main.c: 165: }
      008598 81               [ 4]  738 	ret
                                    739 ;	main.c: 169: void i2c_start(void) {
                                    740 ;	-----------------------------------------
                                    741 ;	 function i2c_start
                                    742 ;	-----------------------------------------
      008599                        743 _i2c_start:
                                    744 ;	main.c: 170: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      008599 72 10 52 11      [ 1]  745 	bset	0x5211, #0
                                    746 ;	main.c: 171: while(!(I2C_SR1 & (1 << 0)));
      00859D                        747 00101$:
      00859D 72 01 52 17 FB   [ 2]  748 	btjf	0x5217, #0, 00101$
                                    749 ;	main.c: 173: }
      0085A2 81               [ 4]  750 	ret
                                    751 ;	main.c: 175: void i2c_send_address(uint8_t address) {
                                    752 ;	-----------------------------------------
                                    753 ;	 function i2c_send_address
                                    754 ;	-----------------------------------------
      0085A3                        755 _i2c_send_address:
                                    756 ;	main.c: 176: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0085A3 48               [ 1]  757 	sll	a
      0085A4 C7 52 16         [ 1]  758 	ld	0x5216, a
                                    759 ;	main.c: 177: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0085A7                        760 00102$:
      0085A7 72 03 52 17 01   [ 2]  761 	btjf	0x5217, #1, 00117$
      0085AC 81               [ 4]  762 	ret
      0085AD                        763 00117$:
      0085AD 72 05 52 18 F5   [ 2]  764 	btjf	0x5218, #2, 00102$
                                    765 ;	main.c: 178: }
      0085B2 81               [ 4]  766 	ret
                                    767 ;	main.c: 180: void i2c_stop(void) {
                                    768 ;	-----------------------------------------
                                    769 ;	 function i2c_stop
                                    770 ;	-----------------------------------------
      0085B3                        771 _i2c_stop:
                                    772 ;	main.c: 181: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      0085B3 72 12 52 11      [ 1]  773 	bset	0x5211, #1
                                    774 ;	main.c: 183: }
      0085B7 81               [ 4]  775 	ret
                                    776 ;	main.c: 187: void i2c_scan(void) {
                                    777 ;	-----------------------------------------
                                    778 ;	 function i2c_scan
                                    779 ;	-----------------------------------------
      0085B8                        780 _i2c_scan:
      0085B8 52 05            [ 2]  781 	sub	sp, #5
                                    782 ;	main.c: 188: for (uint8_t addr = 1; addr < 127; addr++) {
      0085BA A6 01            [ 1]  783 	ld	a, #0x01
      0085BC 6B 05            [ 1]  784 	ld	(0x05, sp), a
      0085BE                        785 00105$:
      0085BE 7B 05            [ 1]  786 	ld	a, (0x05, sp)
      0085C0 A1 7F            [ 1]  787 	cp	a, #0x7f
      0085C2 24 40            [ 1]  788 	jrnc	00107$
                                    789 ;	main.c: 189: i2c_start();
      0085C4 CD 85 99         [ 4]  790 	call	_i2c_start
                                    791 ;	main.c: 190: i2c_send_address(addr);
      0085C7 7B 05            [ 1]  792 	ld	a, (0x05, sp)
      0085C9 CD 85 A3         [ 4]  793 	call	_i2c_send_address
                                    794 ;	main.c: 191: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0085CC 72 04 52 18 28   [ 2]  795 	btjt	0x5218, #2, 00102$
                                    796 ;	main.c: 193: uart_write("SM ");
      0085D1 AE 80 C3         [ 2]  797 	ldw	x, #(___str_17+0)
      0085D4 CD 82 52         [ 4]  798 	call	_uart_write
                                    799 ;	main.c: 194: char rx_int_chars[4]={0};
      0085D7 0F 01            [ 1]  800 	clr	(0x01, sp)
      0085D9 0F 02            [ 1]  801 	clr	(0x02, sp)
      0085DB 0F 03            [ 1]  802 	clr	(0x03, sp)
      0085DD 0F 04            [ 1]  803 	clr	(0x04, sp)
                                    804 ;	main.c: 195: convert_int_to_chars(addr, rx_int_chars);
      0085DF 96               [ 1]  805 	ldw	x, sp
      0085E0 5C               [ 1]  806 	incw	x
      0085E1 7B 05            [ 1]  807 	ld	a, (0x05, sp)
      0085E3 CD 82 7D         [ 4]  808 	call	_convert_int_to_chars
                                    809 ;	main.c: 196: uart_write(rx_int_chars); 
      0085E6 96               [ 1]  810 	ldw	x, sp
      0085E7 5C               [ 1]  811 	incw	x
      0085E8 CD 82 52         [ 4]  812 	call	_uart_write
                                    813 ;	main.c: 197: uart_write("\r\n");
      0085EB AE 80 C7         [ 2]  814 	ldw	x, #(___str_18+0)
      0085EE CD 82 52         [ 4]  815 	call	_uart_write
                                    816 ;	main.c: 198: current_dev = addr;
      0085F1 7B 05            [ 1]  817 	ld	a, (0x05, sp)
      0085F3 C7 01 01         [ 1]  818 	ld	_current_dev+0, a
                                    819 ;	main.c: 199: status_check();
      0085F6 CD 83 3A         [ 4]  820 	call	_status_check
      0085F9                        821 00102$:
                                    822 ;	main.c: 201: i2c_stop();
      0085F9 CD 85 B3         [ 4]  823 	call	_i2c_stop
                                    824 ;	main.c: 202: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      0085FC 72 15 52 18      [ 1]  825 	bres	0x5218, #2
                                    826 ;	main.c: 188: for (uint8_t addr = 1; addr < 127; addr++) {
      008600 0C 05            [ 1]  827 	inc	(0x05, sp)
      008602 20 BA            [ 2]  828 	jra	00105$
      008604                        829 00107$:
                                    830 ;	main.c: 206: }
      008604 5B 05            [ 2]  831 	addw	sp, #5
      008606 81               [ 4]  832 	ret
                                    833 ;	main.c: 209: int uart_read(void)
                                    834 ;	-----------------------------------------
                                    835 ;	 function uart_read
                                    836 ;	-----------------------------------------
      008607                        837 _uart_read:
      008607 52 04            [ 2]  838 	sub	sp, #4
                                    839 ;	main.c: 211: uart_write("Start");
      008609 AE 80 CA         [ 2]  840 	ldw	x, #(___str_19+0)
      00860C CD 82 52         [ 4]  841 	call	_uart_write
                                    842 ;	main.c: 212: memset(buffer, 0, sizeof(buffer));
      00860F 4B 00            [ 1]  843 	push	#0x00
      008611 4B 01            [ 1]  844 	push	#0x01
      008613 5F               [ 1]  845 	clrw	x
      008614 89               [ 2]  846 	pushw	x
      008615 AE 00 01         [ 2]  847 	ldw	x, #(_buffer+0)
      008618 CD 86 B0         [ 4]  848 	call	_memset
                                    849 ;	main.c: 213: uart_write("Clean");
      00861B AE 80 D0         [ 2]  850 	ldw	x, #(___str_20+0)
      00861E CD 82 52         [ 4]  851 	call	_uart_write
                                    852 ;	main.c: 214: int i = 0;
      008621 5F               [ 1]  853 	clrw	x
      008622 1F 01            [ 2]  854 	ldw	(0x01, sp), x
                                    855 ;	main.c: 215: while(i<2)
      008624 5F               [ 1]  856 	clrw	x
      008625 1F 03            [ 2]  857 	ldw	(0x03, sp), x
      008627                        858 00106$:
      008627 1E 03            [ 2]  859 	ldw	x, (0x03, sp)
      008629 A3 00 02         [ 2]  860 	cpw	x, #0x0002
      00862C 2E 38            [ 1]  861 	jrsge	00108$
                                    862 ;	main.c: 218: if(UART1_SR & UART_SR_RXNE)
      00862E C6 52 30         [ 1]  863 	ld	a, 0x5230
      008631 A5 20            [ 1]  864 	bcp	a, #0x20
      008633 27 F2            [ 1]  865 	jreq	00106$
                                    866 ;	main.c: 220: uart_write("IF PASSED");
      008635 AE 80 D6         [ 2]  867 	ldw	x, #(___str_21+0)
      008638 CD 82 52         [ 4]  868 	call	_uart_write
                                    869 ;	main.c: 221: buffer[i] = UART_RX();
      00863B 1E 03            [ 2]  870 	ldw	x, (0x03, sp)
      00863D 1C 00 01         [ 2]  871 	addw	x, #(_buffer+0)
      008640 89               [ 2]  872 	pushw	x
      008641 CD 82 49         [ 4]  873 	call	_UART_RX
      008644 85               [ 2]  874 	popw	x
      008645 F7               [ 1]  875 	ld	(x), a
                                    876 ;	main.c: 222: if(buffer[i] == '\n' || buffer[i] == '\0')
      008646 A1 0A            [ 1]  877 	cp	a, #0x0a
      008648 27 03            [ 1]  878 	jreq	00101$
      00864A F6               [ 1]  879 	ld	a, (x)
      00864B 26 10            [ 1]  880 	jrne	00102$
      00864D                        881 00101$:
                                    882 ;	main.c: 224: buffer[i] = '\0';
      00864D 1E 01            [ 2]  883 	ldw	x, (0x01, sp)
      00864F 72 4F 00 01      [ 1]  884 	clr	((_buffer+0), x)
                                    885 ;	main.c: 225: uart_write("flag_S");
      008653 AE 80 E0         [ 2]  886 	ldw	x, #(___str_22+0)
      008656 CD 82 52         [ 4]  887 	call	_uart_write
                                    888 ;	main.c: 226: return 1;
      008659 5F               [ 1]  889 	clrw	x
      00865A 5C               [ 1]  890 	incw	x
      00865B 20 10            [ 2]  891 	jra	00109$
                                    892 ;	main.c: 227: break;
      00865D                        893 00102$:
                                    894 ;	main.c: 229: i++;
      00865D 1E 03            [ 2]  895 	ldw	x, (0x03, sp)
      00865F 5C               [ 1]  896 	incw	x
      008660 1F 03            [ 2]  897 	ldw	(0x03, sp), x
      008662 1F 01            [ 2]  898 	ldw	(0x01, sp), x
      008664 20 C1            [ 2]  899 	jra	00106$
      008666                        900 00108$:
                                    901 ;	main.c: 232: uart_write("End");
      008666 AE 80 E7         [ 2]  902 	ldw	x, #(___str_23+0)
      008669 CD 82 52         [ 4]  903 	call	_uart_write
                                    904 ;	main.c: 233: return 0;
      00866C 5F               [ 1]  905 	clrw	x
      00866D                        906 00109$:
                                    907 ;	main.c: 259: }
      00866D 5B 04            [ 2]  908 	addw	sp, #4
      00866F 81               [ 4]  909 	ret
                                    910 ;	main.c: 262: int main(void)
                                    911 ;	-----------------------------------------
                                    912 ;	 function main
                                    913 ;	-----------------------------------------
      008670                        914 _main:
                                    915 ;	main.c: 264: uart_init();
      008670 CD 85 5B         [ 4]  916 	call	_uart_init
                                    917 ;	main.c: 265: uart_write("SS\n");
      008673 AE 80 EB         [ 2]  918 	ldw	x, #(___str_24+0)
      008676 CD 82 52         [ 4]  919 	call	_uart_write
                                    920 ;	main.c: 267: while(uart_read())
      008679                        921 00102$:
      008679 CD 86 07         [ 4]  922 	call	_uart_read
      00867C 5D               [ 2]  923 	tnzw	x
      00867D 27 29            [ 1]  924 	jreq	00104$
                                    925 ;	main.c: 269: uart_write("\n>buffer start<\n");
      00867F AE 80 EF         [ 2]  926 	ldw	x, #(___str_25+0)
      008682 CD 82 52         [ 4]  927 	call	_uart_write
                                    928 ;	main.c: 270: for(int i = 0; i < 256; i++)
      008685 5F               [ 1]  929 	clrw	x
      008686                        930 00106$:
      008686 A3 01 00         [ 2]  931 	cpw	x, #0x0100
      008689 2E 15            [ 1]  932 	jrsge	00101$
                                    933 ;	main.c: 272: uart_write(&buffer[i] + '\0');
      00868B 90 93            [ 1]  934 	ldw	y, x
      00868D 72 A9 00 01      [ 2]  935 	addw	y, #(_buffer+0)
      008691 89               [ 2]  936 	pushw	x
      008692 93               [ 1]  937 	ldw	x, y
      008693 CD 82 52         [ 4]  938 	call	_uart_write
      008696 AE 81 00         [ 2]  939 	ldw	x, #(___str_26+0)
      008699 CD 82 52         [ 4]  940 	call	_uart_write
      00869C 85               [ 2]  941 	popw	x
                                    942 ;	main.c: 270: for(int i = 0; i < 256; i++)
      00869D 5C               [ 1]  943 	incw	x
      00869E 20 E6            [ 2]  944 	jra	00106$
      0086A0                        945 00101$:
                                    946 ;	main.c: 275: uart_write("> buffer end <");
      0086A0 AE 81 02         [ 2]  947 	ldw	x, #(___str_27+0)
      0086A3 CD 82 52         [ 4]  948 	call	_uart_write
      0086A6 20 D1            [ 2]  949 	jra	00102$
      0086A8                        950 00104$:
                                    951 ;	main.c: 277: i2c_init();
      0086A8 CD 85 78         [ 4]  952 	call	_i2c_init
                                    953 ;	main.c: 281: i2c_scan(); 
      0086AB CD 85 B8         [ 4]  954 	call	_i2c_scan
                                    955 ;	main.c: 283: return 0;
      0086AE 5F               [ 1]  956 	clrw	x
                                    957 ;	main.c: 284: }
      0086AF 81               [ 4]  958 	ret
                                    959 	.area CODE
                                    960 	.area CONST
                                    961 	.area CONST
      00802D                        962 ___str_0:
      00802D 0A                     963 	.db 0x0a
      00802E 49 32 43 5F 52 45 47   964 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                     965 	.db 0x0a
      00803B 00                     966 	.db 0x00
                                    967 	.area CODE
                                    968 	.area CONST
      00803C                        969 ___str_1:
      00803C 0A                     970 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20   971 	.ascii "SR1 -> "
      008044 00                     972 	.db 0x00
                                    973 	.area CODE
                                    974 	.area CONST
      008045                        975 ___str_2:
      008045 20 3C 2D               976 	.ascii " <-"
      008048 0A                     977 	.db 0x0a
      008049 00                     978 	.db 0x00
                                    979 	.area CODE
                                    980 	.area CONST
      00804A                        981 ___str_3:
      00804A 53 52 32 20 2D 3E 20   982 	.ascii "SR2 -> "
      008051 00                     983 	.db 0x00
                                    984 	.area CODE
                                    985 	.area CONST
      008052                        986 ___str_4:
      008052 53 52 33 20 2D 3E 20   987 	.ascii "SR3 -> "
      008059 00                     988 	.db 0x00
                                    989 	.area CODE
                                    990 	.area CONST
      00805A                        991 ___str_5:
      00805A 43 52 31 20 2D 3E 20   992 	.ascii "CR1 -> "
      008061 00                     993 	.db 0x00
                                    994 	.area CODE
                                    995 	.area CONST
      008062                        996 ___str_6:
      008062 43 52 32 20 2D 3E 20   997 	.ascii "CR2 -> "
      008069 00                     998 	.db 0x00
                                    999 	.area CODE
                                   1000 	.area CONST
      00806A                       1001 ___str_7:
      00806A 44 52 20 2D 3E 20     1002 	.ascii "DR -> "
      008070 00                    1003 	.db 0x00
                                   1004 	.area CODE
                                   1005 	.area CONST
      008071                       1006 ___str_8:
      008071 55 41 52 54 5F 52 45  1007 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      00807E 0A                    1008 	.db 0x0a
      00807F 00                    1009 	.db 0x00
                                   1010 	.area CODE
                                   1011 	.area CONST
      008080                       1012 ___str_9:
      008080 0A                    1013 	.db 0x0a
      008081 53 52 20 2D 3E 20     1014 	.ascii "SR -> "
      008087 00                    1015 	.db 0x00
                                   1016 	.area CODE
                                   1017 	.area CONST
      008088                       1018 ___str_10:
      008088 42 52 52 31 20 2D 3E  1019 	.ascii "BRR1 -> "
             20
      008090 00                    1020 	.db 0x00
                                   1021 	.area CODE
                                   1022 	.area CONST
      008091                       1023 ___str_11:
      008091 42 52 52 32 20 2D 3E  1024 	.ascii "BRR2 -> "
             20
      008099 00                    1025 	.db 0x00
                                   1026 	.area CODE
                                   1027 	.area CONST
      00809A                       1028 ___str_12:
      00809A 43 52 33 20 2D 3E 20  1029 	.ascii "CR3 -> "
      0080A1 00                    1030 	.db 0x00
                                   1031 	.area CODE
                                   1032 	.area CONST
      0080A2                       1033 ___str_13:
      0080A2 43 52 34 20 2D 3E 20  1034 	.ascii "CR4 -> "
      0080A9 00                    1035 	.db 0x00
                                   1036 	.area CODE
                                   1037 	.area CONST
      0080AA                       1038 ___str_14:
      0080AA 43 52 35 20 2D 3E 20  1039 	.ascii "CR5 -> "
      0080B1 00                    1040 	.db 0x00
                                   1041 	.area CODE
                                   1042 	.area CONST
      0080B2                       1043 ___str_15:
      0080B2 47 54 52 20 2D 3E 20  1044 	.ascii "GTR -> "
      0080B9 00                    1045 	.db 0x00
                                   1046 	.area CODE
                                   1047 	.area CONST
      0080BA                       1048 ___str_16:
      0080BA 50 53 43 52 20 2D 3E  1049 	.ascii "PSCR -> "
             20
      0080C2 00                    1050 	.db 0x00
                                   1051 	.area CODE
                                   1052 	.area CONST
      0080C3                       1053 ___str_17:
      0080C3 53 4D 20              1054 	.ascii "SM "
      0080C6 00                    1055 	.db 0x00
                                   1056 	.area CODE
                                   1057 	.area CONST
      0080C7                       1058 ___str_18:
      0080C7 0D                    1059 	.db 0x0d
      0080C8 0A                    1060 	.db 0x0a
      0080C9 00                    1061 	.db 0x00
                                   1062 	.area CODE
                                   1063 	.area CONST
      0080CA                       1064 ___str_19:
      0080CA 53 74 61 72 74        1065 	.ascii "Start"
      0080CF 00                    1066 	.db 0x00
                                   1067 	.area CODE
                                   1068 	.area CONST
      0080D0                       1069 ___str_20:
      0080D0 43 6C 65 61 6E        1070 	.ascii "Clean"
      0080D5 00                    1071 	.db 0x00
                                   1072 	.area CODE
                                   1073 	.area CONST
      0080D6                       1074 ___str_21:
      0080D6 49 46 20 50 41 53 53  1075 	.ascii "IF PASSED"
             45 44
      0080DF 00                    1076 	.db 0x00
                                   1077 	.area CODE
                                   1078 	.area CONST
      0080E0                       1079 ___str_22:
      0080E0 66 6C 61 67 5F 53     1080 	.ascii "flag_S"
      0080E6 00                    1081 	.db 0x00
                                   1082 	.area CODE
                                   1083 	.area CONST
      0080E7                       1084 ___str_23:
      0080E7 45 6E 64              1085 	.ascii "End"
      0080EA 00                    1086 	.db 0x00
                                   1087 	.area CODE
                                   1088 	.area CONST
      0080EB                       1089 ___str_24:
      0080EB 53 53                 1090 	.ascii "SS"
      0080ED 0A                    1091 	.db 0x0a
      0080EE 00                    1092 	.db 0x00
                                   1093 	.area CODE
                                   1094 	.area CONST
      0080EF                       1095 ___str_25:
      0080EF 0A                    1096 	.db 0x0a
      0080F0 3E 62 75 66 66 65 72  1097 	.ascii ">buffer start<"
             20 73 74 61 72 74 3C
      0080FE 0A                    1098 	.db 0x0a
      0080FF 00                    1099 	.db 0x00
                                   1100 	.area CODE
                                   1101 	.area CONST
      008100                       1102 ___str_26:
      008100 20                    1103 	.ascii " "
      008101 00                    1104 	.db 0x00
                                   1105 	.area CODE
                                   1106 	.area CONST
      008102                       1107 ___str_27:
      008102 3E 20 62 75 66 66 65  1108 	.ascii "> buffer end <"
             72 20 65 6E 64 20 3C
      008110 00                    1109 	.db 0x00
                                   1110 	.area CODE
                                   1111 	.area INITIALIZER
      008111                       1112 __xinit__buffer:
      008111 00                    1113 	.db #0x00	; 0
      008112 00                    1114 	.db 0x00
      008113 00                    1115 	.db 0x00
      008114 00                    1116 	.db 0x00
      008115 00                    1117 	.db 0x00
      008116 00                    1118 	.db 0x00
      008117 00                    1119 	.db 0x00
      008118 00                    1120 	.db 0x00
      008119 00                    1121 	.db 0x00
      00811A 00                    1122 	.db 0x00
      00811B 00                    1123 	.db 0x00
      00811C 00                    1124 	.db 0x00
      00811D 00                    1125 	.db 0x00
      00811E 00                    1126 	.db 0x00
      00811F 00                    1127 	.db 0x00
      008120 00                    1128 	.db 0x00
      008121 00                    1129 	.db 0x00
      008122 00                    1130 	.db 0x00
      008123 00                    1131 	.db 0x00
      008124 00                    1132 	.db 0x00
      008125 00                    1133 	.db 0x00
      008126 00                    1134 	.db 0x00
      008127 00                    1135 	.db 0x00
      008128 00                    1136 	.db 0x00
      008129 00                    1137 	.db 0x00
      00812A 00                    1138 	.db 0x00
      00812B 00                    1139 	.db 0x00
      00812C 00                    1140 	.db 0x00
      00812D 00                    1141 	.db 0x00
      00812E 00                    1142 	.db 0x00
      00812F 00                    1143 	.db 0x00
      008130 00                    1144 	.db 0x00
      008131 00                    1145 	.db 0x00
      008132 00                    1146 	.db 0x00
      008133 00                    1147 	.db 0x00
      008134 00                    1148 	.db 0x00
      008135 00                    1149 	.db 0x00
      008136 00                    1150 	.db 0x00
      008137 00                    1151 	.db 0x00
      008138 00                    1152 	.db 0x00
      008139 00                    1153 	.db 0x00
      00813A 00                    1154 	.db 0x00
      00813B 00                    1155 	.db 0x00
      00813C 00                    1156 	.db 0x00
      00813D 00                    1157 	.db 0x00
      00813E 00                    1158 	.db 0x00
      00813F 00                    1159 	.db 0x00
      008140 00                    1160 	.db 0x00
      008141 00                    1161 	.db 0x00
      008142 00                    1162 	.db 0x00
      008143 00                    1163 	.db 0x00
      008144 00                    1164 	.db 0x00
      008145 00                    1165 	.db 0x00
      008146 00                    1166 	.db 0x00
      008147 00                    1167 	.db 0x00
      008148 00                    1168 	.db 0x00
      008149 00                    1169 	.db 0x00
      00814A 00                    1170 	.db 0x00
      00814B 00                    1171 	.db 0x00
      00814C 00                    1172 	.db 0x00
      00814D 00                    1173 	.db 0x00
      00814E 00                    1174 	.db 0x00
      00814F 00                    1175 	.db 0x00
      008150 00                    1176 	.db 0x00
      008151 00                    1177 	.db 0x00
      008152 00                    1178 	.db 0x00
      008153 00                    1179 	.db 0x00
      008154 00                    1180 	.db 0x00
      008155 00                    1181 	.db 0x00
      008156 00                    1182 	.db 0x00
      008157 00                    1183 	.db 0x00
      008158 00                    1184 	.db 0x00
      008159 00                    1185 	.db 0x00
      00815A 00                    1186 	.db 0x00
      00815B 00                    1187 	.db 0x00
      00815C 00                    1188 	.db 0x00
      00815D 00                    1189 	.db 0x00
      00815E 00                    1190 	.db 0x00
      00815F 00                    1191 	.db 0x00
      008160 00                    1192 	.db 0x00
      008161 00                    1193 	.db 0x00
      008162 00                    1194 	.db 0x00
      008163 00                    1195 	.db 0x00
      008164 00                    1196 	.db 0x00
      008165 00                    1197 	.db 0x00
      008166 00                    1198 	.db 0x00
      008167 00                    1199 	.db 0x00
      008168 00                    1200 	.db 0x00
      008169 00                    1201 	.db 0x00
      00816A 00                    1202 	.db 0x00
      00816B 00                    1203 	.db 0x00
      00816C 00                    1204 	.db 0x00
      00816D 00                    1205 	.db 0x00
      00816E 00                    1206 	.db 0x00
      00816F 00                    1207 	.db 0x00
      008170 00                    1208 	.db 0x00
      008171 00                    1209 	.db 0x00
      008172 00                    1210 	.db 0x00
      008173 00                    1211 	.db 0x00
      008174 00                    1212 	.db 0x00
      008175 00                    1213 	.db 0x00
      008176 00                    1214 	.db 0x00
      008177 00                    1215 	.db 0x00
      008178 00                    1216 	.db 0x00
      008179 00                    1217 	.db 0x00
      00817A 00                    1218 	.db 0x00
      00817B 00                    1219 	.db 0x00
      00817C 00                    1220 	.db 0x00
      00817D 00                    1221 	.db 0x00
      00817E 00                    1222 	.db 0x00
      00817F 00                    1223 	.db 0x00
      008180 00                    1224 	.db 0x00
      008181 00                    1225 	.db 0x00
      008182 00                    1226 	.db 0x00
      008183 00                    1227 	.db 0x00
      008184 00                    1228 	.db 0x00
      008185 00                    1229 	.db 0x00
      008186 00                    1230 	.db 0x00
      008187 00                    1231 	.db 0x00
      008188 00                    1232 	.db 0x00
      008189 00                    1233 	.db 0x00
      00818A 00                    1234 	.db 0x00
      00818B 00                    1235 	.db 0x00
      00818C 00                    1236 	.db 0x00
      00818D 00                    1237 	.db 0x00
      00818E 00                    1238 	.db 0x00
      00818F 00                    1239 	.db 0x00
      008190 00                    1240 	.db 0x00
      008191 00                    1241 	.db 0x00
      008192 00                    1242 	.db 0x00
      008193 00                    1243 	.db 0x00
      008194 00                    1244 	.db 0x00
      008195 00                    1245 	.db 0x00
      008196 00                    1246 	.db 0x00
      008197 00                    1247 	.db 0x00
      008198 00                    1248 	.db 0x00
      008199 00                    1249 	.db 0x00
      00819A 00                    1250 	.db 0x00
      00819B 00                    1251 	.db 0x00
      00819C 00                    1252 	.db 0x00
      00819D 00                    1253 	.db 0x00
      00819E 00                    1254 	.db 0x00
      00819F 00                    1255 	.db 0x00
      0081A0 00                    1256 	.db 0x00
      0081A1 00                    1257 	.db 0x00
      0081A2 00                    1258 	.db 0x00
      0081A3 00                    1259 	.db 0x00
      0081A4 00                    1260 	.db 0x00
      0081A5 00                    1261 	.db 0x00
      0081A6 00                    1262 	.db 0x00
      0081A7 00                    1263 	.db 0x00
      0081A8 00                    1264 	.db 0x00
      0081A9 00                    1265 	.db 0x00
      0081AA 00                    1266 	.db 0x00
      0081AB 00                    1267 	.db 0x00
      0081AC 00                    1268 	.db 0x00
      0081AD 00                    1269 	.db 0x00
      0081AE 00                    1270 	.db 0x00
      0081AF 00                    1271 	.db 0x00
      0081B0 00                    1272 	.db 0x00
      0081B1 00                    1273 	.db 0x00
      0081B2 00                    1274 	.db 0x00
      0081B3 00                    1275 	.db 0x00
      0081B4 00                    1276 	.db 0x00
      0081B5 00                    1277 	.db 0x00
      0081B6 00                    1278 	.db 0x00
      0081B7 00                    1279 	.db 0x00
      0081B8 00                    1280 	.db 0x00
      0081B9 00                    1281 	.db 0x00
      0081BA 00                    1282 	.db 0x00
      0081BB 00                    1283 	.db 0x00
      0081BC 00                    1284 	.db 0x00
      0081BD 00                    1285 	.db 0x00
      0081BE 00                    1286 	.db 0x00
      0081BF 00                    1287 	.db 0x00
      0081C0 00                    1288 	.db 0x00
      0081C1 00                    1289 	.db 0x00
      0081C2 00                    1290 	.db 0x00
      0081C3 00                    1291 	.db 0x00
      0081C4 00                    1292 	.db 0x00
      0081C5 00                    1293 	.db 0x00
      0081C6 00                    1294 	.db 0x00
      0081C7 00                    1295 	.db 0x00
      0081C8 00                    1296 	.db 0x00
      0081C9 00                    1297 	.db 0x00
      0081CA 00                    1298 	.db 0x00
      0081CB 00                    1299 	.db 0x00
      0081CC 00                    1300 	.db 0x00
      0081CD 00                    1301 	.db 0x00
      0081CE 00                    1302 	.db 0x00
      0081CF 00                    1303 	.db 0x00
      0081D0 00                    1304 	.db 0x00
      0081D1 00                    1305 	.db 0x00
      0081D2 00                    1306 	.db 0x00
      0081D3 00                    1307 	.db 0x00
      0081D4 00                    1308 	.db 0x00
      0081D5 00                    1309 	.db 0x00
      0081D6 00                    1310 	.db 0x00
      0081D7 00                    1311 	.db 0x00
      0081D8 00                    1312 	.db 0x00
      0081D9 00                    1313 	.db 0x00
      0081DA 00                    1314 	.db 0x00
      0081DB 00                    1315 	.db 0x00
      0081DC 00                    1316 	.db 0x00
      0081DD 00                    1317 	.db 0x00
      0081DE 00                    1318 	.db 0x00
      0081DF 00                    1319 	.db 0x00
      0081E0 00                    1320 	.db 0x00
      0081E1 00                    1321 	.db 0x00
      0081E2 00                    1322 	.db 0x00
      0081E3 00                    1323 	.db 0x00
      0081E4 00                    1324 	.db 0x00
      0081E5 00                    1325 	.db 0x00
      0081E6 00                    1326 	.db 0x00
      0081E7 00                    1327 	.db 0x00
      0081E8 00                    1328 	.db 0x00
      0081E9 00                    1329 	.db 0x00
      0081EA 00                    1330 	.db 0x00
      0081EB 00                    1331 	.db 0x00
      0081EC 00                    1332 	.db 0x00
      0081ED 00                    1333 	.db 0x00
      0081EE 00                    1334 	.db 0x00
      0081EF 00                    1335 	.db 0x00
      0081F0 00                    1336 	.db 0x00
      0081F1 00                    1337 	.db 0x00
      0081F2 00                    1338 	.db 0x00
      0081F3 00                    1339 	.db 0x00
      0081F4 00                    1340 	.db 0x00
      0081F5 00                    1341 	.db 0x00
      0081F6 00                    1342 	.db 0x00
      0081F7 00                    1343 	.db 0x00
      0081F8 00                    1344 	.db 0x00
      0081F9 00                    1345 	.db 0x00
      0081FA 00                    1346 	.db 0x00
      0081FB 00                    1347 	.db 0x00
      0081FC 00                    1348 	.db 0x00
      0081FD 00                    1349 	.db 0x00
      0081FE 00                    1350 	.db 0x00
      0081FF 00                    1351 	.db 0x00
      008200 00                    1352 	.db 0x00
      008201 00                    1353 	.db 0x00
      008202 00                    1354 	.db 0x00
      008203 00                    1355 	.db 0x00
      008204 00                    1356 	.db 0x00
      008205 00                    1357 	.db 0x00
      008206 00                    1358 	.db 0x00
      008207 00                    1359 	.db 0x00
      008208 00                    1360 	.db 0x00
      008209 00                    1361 	.db 0x00
      00820A 00                    1362 	.db 0x00
      00820B 00                    1363 	.db 0x00
      00820C 00                    1364 	.db 0x00
      00820D 00                    1365 	.db 0x00
      00820E 00                    1366 	.db 0x00
      00820F 00                    1367 	.db 0x00
      008210 00                    1368 	.db 0x00
      008211                       1369 __xinit__current_dev:
      008211 00                    1370 	.db #0x00	; 0
                                   1371 	.area CABS (ABS)
