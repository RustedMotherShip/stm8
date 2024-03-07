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
                                     23 	.globl _delay
                                     24 	.globl _strlen
                                     25 	.globl _current_dev
                                     26 	.globl _buffer
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DATA
                                     31 ;--------------------------------------------------------
                                     32 ; ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area INITIALIZED
      000001                         35 _buffer::
      000001                         36 	.ds 256
      000101                         37 _current_dev::
      000101                         38 	.ds 1
                                     39 ;--------------------------------------------------------
                                     40 ; Stack segment in internal ram
                                     41 ;--------------------------------------------------------
                                     42 	.area SSEG
      000102                         43 __start__stack:
      000102                         44 	.ds	1
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; absolute external ram data
                                     48 ;--------------------------------------------------------
                                     49 	.area DABS (ABS)
                                     50 
                                     51 ; default segment ordering for linker
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area CONST
                                     56 	.area INITIALIZER
                                     57 	.area CODE
                                     58 
                                     59 ;--------------------------------------------------------
                                     60 ; interrupt vector
                                     61 ;--------------------------------------------------------
                                     62 	.area HOME
      008000                         63 __interrupt_vect:
      008000 82 00 80 07             64 	int s_GSINIT ; reset
                                     65 ;--------------------------------------------------------
                                     66 ; global & static initialisations
                                     67 ;--------------------------------------------------------
                                     68 	.area HOME
                                     69 	.area GSINIT
                                     70 	.area GSFINAL
                                     71 	.area GSINIT
      008007 CD 86 7C         [ 4]   72 	call	___sdcc_external_startup
      00800A 4D               [ 1]   73 	tnz	a
      00800B 27 03            [ 1]   74 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   75 	jp	__sdcc_program_startup
      008010                         76 __sdcc_init_data:
                                     77 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   78 	ldw x, #l_DATA
      008013 27 07            [ 1]   79 	jreq	00002$
      008015                         80 00001$:
      008015 72 4F 00 00      [ 1]   81 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   82 	decw x
      00801A 26 F9            [ 1]   83 	jrne	00001$
      00801C                         84 00002$:
      00801C AE 01 01         [ 2]   85 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   86 	jreq	00004$
      008021                         87 00003$:
      008021 D6 80 F6         [ 1]   88 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   89 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   90 	decw	x
      008028 26 F7            [ 1]   91 	jrne	00003$
      00802A                         92 00004$:
                                     93 ; stm8_genXINIT() end
                                     94 	.area GSFINAL
      00802A CC 80 04         [ 2]   95 	jp	__sdcc_program_startup
                                     96 ;--------------------------------------------------------
                                     97 ; Home
                                     98 ;--------------------------------------------------------
                                     99 	.area HOME
                                    100 	.area HOME
      008004                        101 __sdcc_program_startup:
      008004 CC 86 3C         [ 2]  102 	jp	_main
                                    103 ;	return from main will return to caller
                                    104 ;--------------------------------------------------------
                                    105 ; code
                                    106 ;--------------------------------------------------------
                                    107 	.area CODE
                                    108 ;	main.c: 8: void delay(unsigned long count) {
                                    109 ;	-----------------------------------------
                                    110 ;	 function delay
                                    111 ;	-----------------------------------------
      0081F8                        112 _delay:
      0081F8 52 08            [ 2]  113 	sub	sp, #8
                                    114 ;	main.c: 9: while (count--)
      0081FA 16 0D            [ 2]  115 	ldw	y, (0x0d, sp)
      0081FC 17 07            [ 2]  116 	ldw	(0x07, sp), y
      0081FE 1E 0B            [ 2]  117 	ldw	x, (0x0b, sp)
      008200                        118 00101$:
      008200 1F 01            [ 2]  119 	ldw	(0x01, sp), x
      008202 7B 07            [ 1]  120 	ld	a, (0x07, sp)
      008204 6B 03            [ 1]  121 	ld	(0x03, sp), a
      008206 7B 08            [ 1]  122 	ld	a, (0x08, sp)
      008208 16 07            [ 2]  123 	ldw	y, (0x07, sp)
      00820A 72 A2 00 01      [ 2]  124 	subw	y, #0x0001
      00820E 17 07            [ 2]  125 	ldw	(0x07, sp), y
      008210 24 01            [ 1]  126 	jrnc	00117$
      008212 5A               [ 2]  127 	decw	x
      008213                        128 00117$:
      008213 4D               [ 1]  129 	tnz	a
      008214 26 08            [ 1]  130 	jrne	00118$
      008216 16 02            [ 2]  131 	ldw	y, (0x02, sp)
      008218 26 04            [ 1]  132 	jrne	00118$
      00821A 0D 01            [ 1]  133 	tnz	(0x01, sp)
      00821C 27 03            [ 1]  134 	jreq	00104$
      00821E                        135 00118$:
                                    136 ;	main.c: 10: nop();
      00821E 9D               [ 1]  137 	nop
      00821F 20 DF            [ 2]  138 	jra	00101$
      008221                        139 00104$:
                                    140 ;	main.c: 11: }
      008221 1E 09            [ 2]  141 	ldw	x, (9, sp)
      008223 5B 0E            [ 2]  142 	addw	sp, #14
      008225 FC               [ 2]  143 	jp	(x)
                                    144 ;	main.c: 13: int uart_write(const char *str) {
                                    145 ;	-----------------------------------------
                                    146 ;	 function uart_write
                                    147 ;	-----------------------------------------
      008226                        148 _uart_write:
      008226 52 05            [ 2]  149 	sub	sp, #5
      008228 1F 03            [ 2]  150 	ldw	(0x03, sp), x
                                    151 ;	main.c: 15: for(i = 0; i < strlen(str); i++) {
      00822A 0F 05            [ 1]  152 	clr	(0x05, sp)
      00822C                        153 00106$:
      00822C 1E 03            [ 2]  154 	ldw	x, (0x03, sp)
      00822E CD 86 7E         [ 4]  155 	call	_strlen
      008231 1F 01            [ 2]  156 	ldw	(0x01, sp), x
      008233 5F               [ 1]  157 	clrw	x
      008234 7B 05            [ 1]  158 	ld	a, (0x05, sp)
      008236 97               [ 1]  159 	ld	xl, a
      008237 13 01            [ 2]  160 	cpw	x, (0x01, sp)
      008239 24 14            [ 1]  161 	jrnc	00104$
                                    162 ;	main.c: 16: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      00823B                        163 00101$:
      00823B C6 52 30         [ 1]  164 	ld	a, 0x5230
      00823E 2A FB            [ 1]  165 	jrpl	00101$
                                    166 ;	main.c: 17: UART1_DR = str[i];
      008240 5F               [ 1]  167 	clrw	x
      008241 7B 05            [ 1]  168 	ld	a, (0x05, sp)
      008243 97               [ 1]  169 	ld	xl, a
      008244 72 FB 03         [ 2]  170 	addw	x, (0x03, sp)
      008247 F6               [ 1]  171 	ld	a, (x)
      008248 C7 52 31         [ 1]  172 	ld	0x5231, a
                                    173 ;	main.c: 15: for(i = 0; i < strlen(str); i++) {
      00824B 0C 05            [ 1]  174 	inc	(0x05, sp)
      00824D 20 DD            [ 2]  175 	jra	00106$
      00824F                        176 00104$:
                                    177 ;	main.c: 19: return(i); // Bytes sent
      00824F 7B 05            [ 1]  178 	ld	a, (0x05, sp)
      008251 5F               [ 1]  179 	clrw	x
      008252 97               [ 1]  180 	ld	xl, a
                                    181 ;	main.c: 20: }
      008253 5B 05            [ 2]  182 	addw	sp, #5
      008255 81               [ 4]  183 	ret
                                    184 ;	main.c: 24: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    185 ;	-----------------------------------------
                                    186 ;	 function convert_int_to_chars
                                    187 ;	-----------------------------------------
      008256                        188 _convert_int_to_chars:
      008256 52 0D            [ 2]  189 	sub	sp, #13
      008258 6B 0D            [ 1]  190 	ld	(0x0d, sp), a
      00825A 1F 0B            [ 2]  191 	ldw	(0x0b, sp), x
                                    192 ;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
      00825C 7B 0D            [ 1]  193 	ld	a, (0x0d, sp)
      00825E 6B 02            [ 1]  194 	ld	(0x02, sp), a
      008260 0F 01            [ 1]  195 	clr	(0x01, sp)
                                    196 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      008262 1E 0B            [ 2]  197 	ldw	x, (0x0b, sp)
      008264 5C               [ 1]  198 	incw	x
      008265 1F 03            [ 2]  199 	ldw	(0x03, sp), x
                                    200 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      008267 1E 0B            [ 2]  201 	ldw	x, (0x0b, sp)
      008269 5C               [ 1]  202 	incw	x
      00826A 5C               [ 1]  203 	incw	x
      00826B 1F 05            [ 2]  204 	ldw	(0x05, sp), x
                                    205 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      00826D 4B 0A            [ 1]  206 	push	#0x0a
      00826F 4B 00            [ 1]  207 	push	#0x00
      008271 1E 03            [ 2]  208 	ldw	x, (0x03, sp)
                                    209 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      008273 CD 86 A3         [ 4]  210 	call	__divsint
      008276 1F 07            [ 2]  211 	ldw	(0x07, sp), x
      008278 4B 0A            [ 1]  212 	push	#0x0a
      00827A 4B 00            [ 1]  213 	push	#0x00
      00827C 1E 03            [ 2]  214 	ldw	x, (0x03, sp)
      00827E CD 86 8B         [ 4]  215 	call	__modsint
      008281 9F               [ 1]  216 	ld	a, xl
      008282 AB 30            [ 1]  217 	add	a, #0x30
      008284 6B 09            [ 1]  218 	ld	(0x09, sp), a
                                    219 ;	main.c: 25: if (num > 99) {
      008286 7B 0D            [ 1]  220 	ld	a, (0x0d, sp)
      008288 A1 63            [ 1]  221 	cp	a, #0x63
      00828A 23 29            [ 2]  222 	jrule	00105$
                                    223 ;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
      00828C 4B 64            [ 1]  224 	push	#0x64
      00828E 4B 00            [ 1]  225 	push	#0x00
      008290 1E 03            [ 2]  226 	ldw	x, (0x03, sp)
      008292 CD 86 A3         [ 4]  227 	call	__divsint
      008295 9F               [ 1]  228 	ld	a, xl
      008296 AB 30            [ 1]  229 	add	a, #0x30
      008298 1E 0B            [ 2]  230 	ldw	x, (0x0b, sp)
      00829A F7               [ 1]  231 	ld	(x), a
                                    232 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      00829B 4B 0A            [ 1]  233 	push	#0x0a
      00829D 4B 00            [ 1]  234 	push	#0x00
      00829F 1E 09            [ 2]  235 	ldw	x, (0x09, sp)
      0082A1 CD 86 8B         [ 4]  236 	call	__modsint
      0082A4 9F               [ 1]  237 	ld	a, xl
      0082A5 AB 30            [ 1]  238 	add	a, #0x30
      0082A7 1E 03            [ 2]  239 	ldw	x, (0x03, sp)
      0082A9 F7               [ 1]  240 	ld	(x), a
                                    241 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      0082AA 1E 05            [ 2]  242 	ldw	x, (0x05, sp)
      0082AC 7B 09            [ 1]  243 	ld	a, (0x09, sp)
      0082AE F7               [ 1]  244 	ld	(x), a
                                    245 ;	main.c: 30: rx_int_chars[3] ='\0';
      0082AF 1E 0B            [ 2]  246 	ldw	x, (0x0b, sp)
      0082B1 6F 03            [ 1]  247 	clr	(0x0003, x)
      0082B3 20 23            [ 2]  248 	jra	00107$
      0082B5                        249 00105$:
                                    250 ;	main.c: 32: } else if (num > 9) {
      0082B5 7B 0D            [ 1]  251 	ld	a, (0x0d, sp)
      0082B7 A1 09            [ 1]  252 	cp	a, #0x09
      0082B9 23 13            [ 2]  253 	jrule	00102$
                                    254 ;	main.c: 34: rx_int_chars[0] = num / 10 + '0';
      0082BB 7B 08            [ 1]  255 	ld	a, (0x08, sp)
      0082BD 6B 0A            [ 1]  256 	ld	(0x0a, sp), a
      0082BF AB 30            [ 1]  257 	add	a, #0x30
      0082C1 1E 0B            [ 2]  258 	ldw	x, (0x0b, sp)
      0082C3 F7               [ 1]  259 	ld	(x), a
                                    260 ;	main.c: 35: rx_int_chars[1] = num % 10 + '0';
      0082C4 1E 03            [ 2]  261 	ldw	x, (0x03, sp)
      0082C6 7B 09            [ 1]  262 	ld	a, (0x09, sp)
      0082C8 F7               [ 1]  263 	ld	(x), a
                                    264 ;	main.c: 36: rx_int_chars[2] ='\0';
      0082C9 1E 05            [ 2]  265 	ldw	x, (0x05, sp)
      0082CB 7F               [ 1]  266 	clr	(x)
      0082CC 20 0A            [ 2]  267 	jra	00107$
      0082CE                        268 00102$:
                                    269 ;	main.c: 41: rx_int_chars[0] = num + '0';
      0082CE 7B 0D            [ 1]  270 	ld	a, (0x0d, sp)
      0082D0 AB 30            [ 1]  271 	add	a, #0x30
      0082D2 1E 0B            [ 2]  272 	ldw	x, (0x0b, sp)
      0082D4 F7               [ 1]  273 	ld	(x), a
                                    274 ;	main.c: 42: rx_int_chars[1] ='\0';
      0082D5 1E 03            [ 2]  275 	ldw	x, (0x03, sp)
      0082D7 7F               [ 1]  276 	clr	(x)
      0082D8                        277 00107$:
                                    278 ;	main.c: 44: }
      0082D8 5B 0D            [ 2]  279 	addw	sp, #13
      0082DA 81               [ 4]  280 	ret
                                    281 ;	main.c: 46: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    282 ;	-----------------------------------------
                                    283 ;	 function convert_int_to_binary
                                    284 ;	-----------------------------------------
      0082DB                        285 _convert_int_to_binary:
      0082DB 52 04            [ 2]  286 	sub	sp, #4
      0082DD 1F 01            [ 2]  287 	ldw	(0x01, sp), x
                                    288 ;	main.c: 48: for(int i = 7; i >= 0; i--) {
      0082DF AE 00 07         [ 2]  289 	ldw	x, #0x0007
      0082E2 1F 03            [ 2]  290 	ldw	(0x03, sp), x
      0082E4                        291 00103$:
      0082E4 0D 03            [ 1]  292 	tnz	(0x03, sp)
      0082E6 2B 22            [ 1]  293 	jrmi	00101$
                                    294 ;	main.c: 50: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      0082E8 AE 00 07         [ 2]  295 	ldw	x, #0x0007
      0082EB 72 F0 03         [ 2]  296 	subw	x, (0x03, sp)
      0082EE 72 FB 07         [ 2]  297 	addw	x, (0x07, sp)
      0082F1 16 01            [ 2]  298 	ldw	y, (0x01, sp)
      0082F3 7B 04            [ 1]  299 	ld	a, (0x04, sp)
      0082F5 27 05            [ 1]  300 	jreq	00120$
      0082F7                        301 00119$:
      0082F7 90 57            [ 2]  302 	sraw	y
      0082F9 4A               [ 1]  303 	dec	a
      0082FA 26 FB            [ 1]  304 	jrne	00119$
      0082FC                        305 00120$:
      0082FC 90 9F            [ 1]  306 	ld	a, yl
      0082FE A4 01            [ 1]  307 	and	a, #0x01
      008300 AB 30            [ 1]  308 	add	a, #0x30
      008302 F7               [ 1]  309 	ld	(x), a
                                    310 ;	main.c: 48: for(int i = 7; i >= 0; i--) {
      008303 1E 03            [ 2]  311 	ldw	x, (0x03, sp)
      008305 5A               [ 2]  312 	decw	x
      008306 1F 03            [ 2]  313 	ldw	(0x03, sp), x
      008308 20 DA            [ 2]  314 	jra	00103$
      00830A                        315 00101$:
                                    316 ;	main.c: 52: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      00830A 1E 07            [ 2]  317 	ldw	x, (0x07, sp)
      00830C 6F 08            [ 1]  318 	clr	(0x0008, x)
                                    319 ;	main.c: 53: }
      00830E 1E 05            [ 2]  320 	ldw	x, (5, sp)
      008310 5B 08            [ 2]  321 	addw	sp, #8
      008312 FC               [ 2]  322 	jp	(x)
                                    323 ;	main.c: 55: void status_check(void){
                                    324 ;	-----------------------------------------
                                    325 ;	 function status_check
                                    326 ;	-----------------------------------------
      008313                        327 _status_check:
      008313 52 09            [ 2]  328 	sub	sp, #9
                                    329 ;	main.c: 56: char rx_binary_chars[9]={0};
      008315 0F 01            [ 1]  330 	clr	(0x01, sp)
      008317 0F 02            [ 1]  331 	clr	(0x02, sp)
      008319 0F 03            [ 1]  332 	clr	(0x03, sp)
      00831B 0F 04            [ 1]  333 	clr	(0x04, sp)
      00831D 0F 05            [ 1]  334 	clr	(0x05, sp)
      00831F 0F 06            [ 1]  335 	clr	(0x06, sp)
      008321 0F 07            [ 1]  336 	clr	(0x07, sp)
      008323 0F 08            [ 1]  337 	clr	(0x08, sp)
      008325 0F 09            [ 1]  338 	clr	(0x09, sp)
                                    339 ;	main.c: 57: uart_write("\nI2C_REGS >.<\n");
      008327 AE 80 2D         [ 2]  340 	ldw	x, #(___str_0+0)
      00832A CD 82 26         [ 4]  341 	call	_uart_write
                                    342 ;	main.c: 58: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      00832D 96               [ 1]  343 	ldw	x, sp
      00832E 5C               [ 1]  344 	incw	x
      00832F 51               [ 1]  345 	exgw	x, y
      008330 C6 52 17         [ 1]  346 	ld	a, 0x5217
      008333 5F               [ 1]  347 	clrw	x
      008334 90 89            [ 2]  348 	pushw	y
      008336 97               [ 1]  349 	ld	xl, a
      008337 CD 82 DB         [ 4]  350 	call	_convert_int_to_binary
                                    351 ;	main.c: 59: uart_write("\nSR1 -> ");
      00833A AE 80 3C         [ 2]  352 	ldw	x, #(___str_1+0)
      00833D CD 82 26         [ 4]  353 	call	_uart_write
                                    354 ;	main.c: 60: uart_write(rx_binary_chars);
      008340 96               [ 1]  355 	ldw	x, sp
      008341 5C               [ 1]  356 	incw	x
      008342 CD 82 26         [ 4]  357 	call	_uart_write
                                    358 ;	main.c: 61: uart_write(" <-\n");
      008345 AE 80 45         [ 2]  359 	ldw	x, #(___str_2+0)
      008348 CD 82 26         [ 4]  360 	call	_uart_write
                                    361 ;	main.c: 62: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      00834B 96               [ 1]  362 	ldw	x, sp
      00834C 5C               [ 1]  363 	incw	x
      00834D 51               [ 1]  364 	exgw	x, y
      00834E C6 52 18         [ 1]  365 	ld	a, 0x5218
      008351 5F               [ 1]  366 	clrw	x
      008352 90 89            [ 2]  367 	pushw	y
      008354 97               [ 1]  368 	ld	xl, a
      008355 CD 82 DB         [ 4]  369 	call	_convert_int_to_binary
                                    370 ;	main.c: 63: uart_write("SR2 -> ");
      008358 AE 80 4A         [ 2]  371 	ldw	x, #(___str_3+0)
      00835B CD 82 26         [ 4]  372 	call	_uart_write
                                    373 ;	main.c: 64: uart_write(rx_binary_chars);
      00835E 96               [ 1]  374 	ldw	x, sp
      00835F 5C               [ 1]  375 	incw	x
      008360 CD 82 26         [ 4]  376 	call	_uart_write
                                    377 ;	main.c: 65: uart_write(" <-\n");
      008363 AE 80 45         [ 2]  378 	ldw	x, #(___str_2+0)
      008366 CD 82 26         [ 4]  379 	call	_uart_write
                                    380 ;	main.c: 66: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008369 96               [ 1]  381 	ldw	x, sp
      00836A 5C               [ 1]  382 	incw	x
      00836B 51               [ 1]  383 	exgw	x, y
      00836C C6 52 19         [ 1]  384 	ld	a, 0x5219
      00836F 5F               [ 1]  385 	clrw	x
      008370 90 89            [ 2]  386 	pushw	y
      008372 97               [ 1]  387 	ld	xl, a
      008373 CD 82 DB         [ 4]  388 	call	_convert_int_to_binary
                                    389 ;	main.c: 67: uart_write("SR3 -> ");
      008376 AE 80 52         [ 2]  390 	ldw	x, #(___str_4+0)
      008379 CD 82 26         [ 4]  391 	call	_uart_write
                                    392 ;	main.c: 68: uart_write(rx_binary_chars);
      00837C 96               [ 1]  393 	ldw	x, sp
      00837D 5C               [ 1]  394 	incw	x
      00837E CD 82 26         [ 4]  395 	call	_uart_write
                                    396 ;	main.c: 69: uart_write(" <-\n");
      008381 AE 80 45         [ 2]  397 	ldw	x, #(___str_2+0)
      008384 CD 82 26         [ 4]  398 	call	_uart_write
                                    399 ;	main.c: 70: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      008387 96               [ 1]  400 	ldw	x, sp
      008388 5C               [ 1]  401 	incw	x
      008389 51               [ 1]  402 	exgw	x, y
      00838A C6 52 10         [ 1]  403 	ld	a, 0x5210
      00838D 5F               [ 1]  404 	clrw	x
      00838E 90 89            [ 2]  405 	pushw	y
      008390 97               [ 1]  406 	ld	xl, a
      008391 CD 82 DB         [ 4]  407 	call	_convert_int_to_binary
                                    408 ;	main.c: 71: uart_write("CR1 -> ");
      008394 AE 80 5A         [ 2]  409 	ldw	x, #(___str_5+0)
      008397 CD 82 26         [ 4]  410 	call	_uart_write
                                    411 ;	main.c: 72: uart_write(rx_binary_chars);
      00839A 96               [ 1]  412 	ldw	x, sp
      00839B 5C               [ 1]  413 	incw	x
      00839C CD 82 26         [ 4]  414 	call	_uart_write
                                    415 ;	main.c: 73: uart_write(" <-\n");
      00839F AE 80 45         [ 2]  416 	ldw	x, #(___str_2+0)
      0083A2 CD 82 26         [ 4]  417 	call	_uart_write
                                    418 ;	main.c: 74: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      0083A5 96               [ 1]  419 	ldw	x, sp
      0083A6 5C               [ 1]  420 	incw	x
      0083A7 51               [ 1]  421 	exgw	x, y
      0083A8 C6 52 11         [ 1]  422 	ld	a, 0x5211
      0083AB 5F               [ 1]  423 	clrw	x
      0083AC 90 89            [ 2]  424 	pushw	y
      0083AE 97               [ 1]  425 	ld	xl, a
      0083AF CD 82 DB         [ 4]  426 	call	_convert_int_to_binary
                                    427 ;	main.c: 75: uart_write("CR2 -> ");
      0083B2 AE 80 62         [ 2]  428 	ldw	x, #(___str_6+0)
      0083B5 CD 82 26         [ 4]  429 	call	_uart_write
                                    430 ;	main.c: 76: uart_write(rx_binary_chars);
      0083B8 96               [ 1]  431 	ldw	x, sp
      0083B9 5C               [ 1]  432 	incw	x
      0083BA CD 82 26         [ 4]  433 	call	_uart_write
                                    434 ;	main.c: 77: uart_write(" <-\n");
      0083BD AE 80 45         [ 2]  435 	ldw	x, #(___str_2+0)
      0083C0 CD 82 26         [ 4]  436 	call	_uart_write
                                    437 ;	main.c: 78: convert_int_to_binary(I2C_DR, rx_binary_chars);
      0083C3 96               [ 1]  438 	ldw	x, sp
      0083C4 5C               [ 1]  439 	incw	x
      0083C5 51               [ 1]  440 	exgw	x, y
      0083C6 C6 52 16         [ 1]  441 	ld	a, 0x5216
      0083C9 5F               [ 1]  442 	clrw	x
      0083CA 90 89            [ 2]  443 	pushw	y
      0083CC 97               [ 1]  444 	ld	xl, a
      0083CD CD 82 DB         [ 4]  445 	call	_convert_int_to_binary
                                    446 ;	main.c: 79: uart_write("DR -> ");
      0083D0 AE 80 6A         [ 2]  447 	ldw	x, #(___str_7+0)
      0083D3 CD 82 26         [ 4]  448 	call	_uart_write
                                    449 ;	main.c: 80: uart_write(rx_binary_chars);
      0083D6 96               [ 1]  450 	ldw	x, sp
      0083D7 5C               [ 1]  451 	incw	x
      0083D8 CD 82 26         [ 4]  452 	call	_uart_write
                                    453 ;	main.c: 81: uart_write(" <-\n");
      0083DB AE 80 45         [ 2]  454 	ldw	x, #(___str_2+0)
      0083DE CD 82 26         [ 4]  455 	call	_uart_write
                                    456 ;	main.c: 82: uart_write("UART_REGS >.<\n");
      0083E1 AE 80 71         [ 2]  457 	ldw	x, #(___str_8+0)
      0083E4 CD 82 26         [ 4]  458 	call	_uart_write
                                    459 ;	main.c: 83: convert_int_to_binary(UART1_SR, rx_binary_chars);
      0083E7 96               [ 1]  460 	ldw	x, sp
      0083E8 5C               [ 1]  461 	incw	x
      0083E9 51               [ 1]  462 	exgw	x, y
      0083EA C6 52 30         [ 1]  463 	ld	a, 0x5230
      0083ED 5F               [ 1]  464 	clrw	x
      0083EE 90 89            [ 2]  465 	pushw	y
      0083F0 97               [ 1]  466 	ld	xl, a
      0083F1 CD 82 DB         [ 4]  467 	call	_convert_int_to_binary
                                    468 ;	main.c: 84: uart_write("\nSR -> ");
      0083F4 AE 80 80         [ 2]  469 	ldw	x, #(___str_9+0)
      0083F7 CD 82 26         [ 4]  470 	call	_uart_write
                                    471 ;	main.c: 85: uart_write(rx_binary_chars);
      0083FA 96               [ 1]  472 	ldw	x, sp
      0083FB 5C               [ 1]  473 	incw	x
      0083FC CD 82 26         [ 4]  474 	call	_uart_write
                                    475 ;	main.c: 86: uart_write(" <-\n");
      0083FF AE 80 45         [ 2]  476 	ldw	x, #(___str_2+0)
      008402 CD 82 26         [ 4]  477 	call	_uart_write
                                    478 ;	main.c: 87: convert_int_to_binary(UART1_DR, rx_binary_chars);
      008405 96               [ 1]  479 	ldw	x, sp
      008406 5C               [ 1]  480 	incw	x
      008407 51               [ 1]  481 	exgw	x, y
      008408 C6 52 31         [ 1]  482 	ld	a, 0x5231
      00840B 5F               [ 1]  483 	clrw	x
      00840C 90 89            [ 2]  484 	pushw	y
      00840E 97               [ 1]  485 	ld	xl, a
      00840F CD 82 DB         [ 4]  486 	call	_convert_int_to_binary
                                    487 ;	main.c: 88: uart_write("DR -> ");
      008412 AE 80 6A         [ 2]  488 	ldw	x, #(___str_7+0)
      008415 CD 82 26         [ 4]  489 	call	_uart_write
                                    490 ;	main.c: 89: uart_write(rx_binary_chars);
      008418 96               [ 1]  491 	ldw	x, sp
      008419 5C               [ 1]  492 	incw	x
      00841A CD 82 26         [ 4]  493 	call	_uart_write
                                    494 ;	main.c: 90: uart_write(" <-\n");
      00841D AE 80 45         [ 2]  495 	ldw	x, #(___str_2+0)
      008420 CD 82 26         [ 4]  496 	call	_uart_write
                                    497 ;	main.c: 91: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
      008423 96               [ 1]  498 	ldw	x, sp
      008424 5C               [ 1]  499 	incw	x
      008425 51               [ 1]  500 	exgw	x, y
      008426 C6 52 32         [ 1]  501 	ld	a, 0x5232
      008429 5F               [ 1]  502 	clrw	x
      00842A 90 89            [ 2]  503 	pushw	y
      00842C 97               [ 1]  504 	ld	xl, a
      00842D CD 82 DB         [ 4]  505 	call	_convert_int_to_binary
                                    506 ;	main.c: 92: uart_write("BRR1 -> ");
      008430 AE 80 88         [ 2]  507 	ldw	x, #(___str_10+0)
      008433 CD 82 26         [ 4]  508 	call	_uart_write
                                    509 ;	main.c: 93: uart_write(rx_binary_chars);
      008436 96               [ 1]  510 	ldw	x, sp
      008437 5C               [ 1]  511 	incw	x
      008438 CD 82 26         [ 4]  512 	call	_uart_write
                                    513 ;	main.c: 94: uart_write(" <-\n");
      00843B AE 80 45         [ 2]  514 	ldw	x, #(___str_2+0)
      00843E CD 82 26         [ 4]  515 	call	_uart_write
                                    516 ;	main.c: 95: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
      008441 96               [ 1]  517 	ldw	x, sp
      008442 5C               [ 1]  518 	incw	x
      008443 51               [ 1]  519 	exgw	x, y
      008444 C6 52 33         [ 1]  520 	ld	a, 0x5233
      008447 5F               [ 1]  521 	clrw	x
      008448 90 89            [ 2]  522 	pushw	y
      00844A 97               [ 1]  523 	ld	xl, a
      00844B CD 82 DB         [ 4]  524 	call	_convert_int_to_binary
                                    525 ;	main.c: 96: uart_write("BRR2 -> ");
      00844E AE 80 91         [ 2]  526 	ldw	x, #(___str_11+0)
      008451 CD 82 26         [ 4]  527 	call	_uart_write
                                    528 ;	main.c: 97: uart_write(rx_binary_chars);
      008454 96               [ 1]  529 	ldw	x, sp
      008455 5C               [ 1]  530 	incw	x
      008456 CD 82 26         [ 4]  531 	call	_uart_write
                                    532 ;	main.c: 98: uart_write(" <-\n");
      008459 AE 80 45         [ 2]  533 	ldw	x, #(___str_2+0)
      00845C CD 82 26         [ 4]  534 	call	_uart_write
                                    535 ;	main.c: 99: convert_int_to_binary(UART1_CR1, rx_binary_chars);
      00845F 96               [ 1]  536 	ldw	x, sp
      008460 5C               [ 1]  537 	incw	x
      008461 51               [ 1]  538 	exgw	x, y
      008462 C6 52 34         [ 1]  539 	ld	a, 0x5234
      008465 5F               [ 1]  540 	clrw	x
      008466 90 89            [ 2]  541 	pushw	y
      008468 97               [ 1]  542 	ld	xl, a
      008469 CD 82 DB         [ 4]  543 	call	_convert_int_to_binary
                                    544 ;	main.c: 100: uart_write("CR1 -> ");
      00846C AE 80 5A         [ 2]  545 	ldw	x, #(___str_5+0)
      00846F CD 82 26         [ 4]  546 	call	_uart_write
                                    547 ;	main.c: 101: uart_write(rx_binary_chars);
      008472 96               [ 1]  548 	ldw	x, sp
      008473 5C               [ 1]  549 	incw	x
      008474 CD 82 26         [ 4]  550 	call	_uart_write
                                    551 ;	main.c: 102: uart_write(" <-\n");
      008477 AE 80 45         [ 2]  552 	ldw	x, #(___str_2+0)
      00847A CD 82 26         [ 4]  553 	call	_uart_write
                                    554 ;	main.c: 103: convert_int_to_binary(UART1_CR2, rx_binary_chars);
      00847D 96               [ 1]  555 	ldw	x, sp
      00847E 5C               [ 1]  556 	incw	x
      00847F 51               [ 1]  557 	exgw	x, y
      008480 C6 52 35         [ 1]  558 	ld	a, 0x5235
      008483 5F               [ 1]  559 	clrw	x
      008484 90 89            [ 2]  560 	pushw	y
      008486 97               [ 1]  561 	ld	xl, a
      008487 CD 82 DB         [ 4]  562 	call	_convert_int_to_binary
                                    563 ;	main.c: 104: uart_write("CR2 -> ");
      00848A AE 80 62         [ 2]  564 	ldw	x, #(___str_6+0)
      00848D CD 82 26         [ 4]  565 	call	_uart_write
                                    566 ;	main.c: 105: uart_write(rx_binary_chars);
      008490 96               [ 1]  567 	ldw	x, sp
      008491 5C               [ 1]  568 	incw	x
      008492 CD 82 26         [ 4]  569 	call	_uart_write
                                    570 ;	main.c: 106: uart_write(" <-\n");
      008495 AE 80 45         [ 2]  571 	ldw	x, #(___str_2+0)
      008498 CD 82 26         [ 4]  572 	call	_uart_write
                                    573 ;	main.c: 107: convert_int_to_binary(UART1_CR3, rx_binary_chars);
      00849B 96               [ 1]  574 	ldw	x, sp
      00849C 5C               [ 1]  575 	incw	x
      00849D 51               [ 1]  576 	exgw	x, y
      00849E C6 52 36         [ 1]  577 	ld	a, 0x5236
      0084A1 5F               [ 1]  578 	clrw	x
      0084A2 90 89            [ 2]  579 	pushw	y
      0084A4 97               [ 1]  580 	ld	xl, a
      0084A5 CD 82 DB         [ 4]  581 	call	_convert_int_to_binary
                                    582 ;	main.c: 108: uart_write("CR3 -> ");
      0084A8 AE 80 9A         [ 2]  583 	ldw	x, #(___str_12+0)
      0084AB CD 82 26         [ 4]  584 	call	_uart_write
                                    585 ;	main.c: 109: uart_write(rx_binary_chars);
      0084AE 96               [ 1]  586 	ldw	x, sp
      0084AF 5C               [ 1]  587 	incw	x
      0084B0 CD 82 26         [ 4]  588 	call	_uart_write
                                    589 ;	main.c: 110: uart_write(" <-\n");
      0084B3 AE 80 45         [ 2]  590 	ldw	x, #(___str_2+0)
      0084B6 CD 82 26         [ 4]  591 	call	_uart_write
                                    592 ;	main.c: 111: convert_int_to_binary(UART1_CR4, rx_binary_chars);
      0084B9 96               [ 1]  593 	ldw	x, sp
      0084BA 5C               [ 1]  594 	incw	x
      0084BB 51               [ 1]  595 	exgw	x, y
      0084BC C6 52 37         [ 1]  596 	ld	a, 0x5237
      0084BF 5F               [ 1]  597 	clrw	x
      0084C0 90 89            [ 2]  598 	pushw	y
      0084C2 97               [ 1]  599 	ld	xl, a
      0084C3 CD 82 DB         [ 4]  600 	call	_convert_int_to_binary
                                    601 ;	main.c: 112: uart_write("CR4 -> ");
      0084C6 AE 80 A2         [ 2]  602 	ldw	x, #(___str_13+0)
      0084C9 CD 82 26         [ 4]  603 	call	_uart_write
                                    604 ;	main.c: 113: uart_write(rx_binary_chars);
      0084CC 96               [ 1]  605 	ldw	x, sp
      0084CD 5C               [ 1]  606 	incw	x
      0084CE CD 82 26         [ 4]  607 	call	_uart_write
                                    608 ;	main.c: 114: uart_write(" <-\n");
      0084D1 AE 80 45         [ 2]  609 	ldw	x, #(___str_2+0)
      0084D4 CD 82 26         [ 4]  610 	call	_uart_write
                                    611 ;	main.c: 115: convert_int_to_binary(UART1_CR5, rx_binary_chars);
      0084D7 96               [ 1]  612 	ldw	x, sp
      0084D8 5C               [ 1]  613 	incw	x
      0084D9 51               [ 1]  614 	exgw	x, y
      0084DA C6 52 38         [ 1]  615 	ld	a, 0x5238
      0084DD 5F               [ 1]  616 	clrw	x
      0084DE 90 89            [ 2]  617 	pushw	y
      0084E0 97               [ 1]  618 	ld	xl, a
      0084E1 CD 82 DB         [ 4]  619 	call	_convert_int_to_binary
                                    620 ;	main.c: 116: uart_write("CR5 -> ");
      0084E4 AE 80 AA         [ 2]  621 	ldw	x, #(___str_14+0)
      0084E7 CD 82 26         [ 4]  622 	call	_uart_write
                                    623 ;	main.c: 117: uart_write(rx_binary_chars);
      0084EA 96               [ 1]  624 	ldw	x, sp
      0084EB 5C               [ 1]  625 	incw	x
      0084EC CD 82 26         [ 4]  626 	call	_uart_write
                                    627 ;	main.c: 118: uart_write(" <-\n");
      0084EF AE 80 45         [ 2]  628 	ldw	x, #(___str_2+0)
      0084F2 CD 82 26         [ 4]  629 	call	_uart_write
                                    630 ;	main.c: 119: convert_int_to_binary(UART1_GTR, rx_binary_chars);
      0084F5 96               [ 1]  631 	ldw	x, sp
      0084F6 5C               [ 1]  632 	incw	x
      0084F7 51               [ 1]  633 	exgw	x, y
      0084F8 C6 52 39         [ 1]  634 	ld	a, 0x5239
      0084FB 5F               [ 1]  635 	clrw	x
      0084FC 90 89            [ 2]  636 	pushw	y
      0084FE 97               [ 1]  637 	ld	xl, a
      0084FF CD 82 DB         [ 4]  638 	call	_convert_int_to_binary
                                    639 ;	main.c: 120: uart_write("GTR -> ");
      008502 AE 80 B2         [ 2]  640 	ldw	x, #(___str_15+0)
      008505 CD 82 26         [ 4]  641 	call	_uart_write
                                    642 ;	main.c: 121: uart_write(rx_binary_chars);
      008508 96               [ 1]  643 	ldw	x, sp
      008509 5C               [ 1]  644 	incw	x
      00850A CD 82 26         [ 4]  645 	call	_uart_write
                                    646 ;	main.c: 122: uart_write(" <-\n");
      00850D AE 80 45         [ 2]  647 	ldw	x, #(___str_2+0)
      008510 CD 82 26         [ 4]  648 	call	_uart_write
                                    649 ;	main.c: 123: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
      008513 96               [ 1]  650 	ldw	x, sp
      008514 5C               [ 1]  651 	incw	x
      008515 51               [ 1]  652 	exgw	x, y
      008516 C6 52 3A         [ 1]  653 	ld	a, 0x523a
      008519 5F               [ 1]  654 	clrw	x
      00851A 90 89            [ 2]  655 	pushw	y
      00851C 97               [ 1]  656 	ld	xl, a
      00851D CD 82 DB         [ 4]  657 	call	_convert_int_to_binary
                                    658 ;	main.c: 124: uart_write("PSCR -> ");
      008520 AE 80 BA         [ 2]  659 	ldw	x, #(___str_16+0)
      008523 CD 82 26         [ 4]  660 	call	_uart_write
                                    661 ;	main.c: 125: uart_write(rx_binary_chars);
      008526 96               [ 1]  662 	ldw	x, sp
      008527 5C               [ 1]  663 	incw	x
      008528 CD 82 26         [ 4]  664 	call	_uart_write
                                    665 ;	main.c: 126: uart_write(" <-\n");
      00852B AE 80 45         [ 2]  666 	ldw	x, #(___str_2+0)
      00852E CD 82 26         [ 4]  667 	call	_uart_write
                                    668 ;	main.c: 127: }
      008531 5B 09            [ 2]  669 	addw	sp, #9
      008533 81               [ 4]  670 	ret
                                    671 ;	main.c: 129: void uart_init(void){
                                    672 ;	-----------------------------------------
                                    673 ;	 function uart_init
                                    674 ;	-----------------------------------------
      008534                        675 _uart_init:
                                    676 ;	main.c: 130: CLK_CKDIVR = 0;
      008534 35 00 50 C6      [ 1]  677 	mov	0x50c6+0, #0x00
                                    678 ;	main.c: 133: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008538 72 16 52 35      [ 1]  679 	bset	0x5235, #3
                                    680 ;	main.c: 134: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      00853C 72 14 52 35      [ 1]  681 	bset	0x5235, #2
                                    682 ;	main.c: 135: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008540 C6 52 36         [ 1]  683 	ld	a, 0x5236
      008543 A4 CF            [ 1]  684 	and	a, #0xcf
      008545 C7 52 36         [ 1]  685 	ld	0x5236, a
                                    686 ;	main.c: 137: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      008548 35 03 52 33      [ 1]  687 	mov	0x5233+0, #0x03
      00854C 35 68 52 32      [ 1]  688 	mov	0x5232+0, #0x68
                                    689 ;	main.c: 138: }
      008550 81               [ 4]  690 	ret
                                    691 ;	main.c: 142: void i2c_init(void) {
                                    692 ;	-----------------------------------------
                                    693 ;	 function i2c_init
                                    694 ;	-----------------------------------------
      008551                        695 _i2c_init:
                                    696 ;	main.c: 148: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008551 72 11 52 10      [ 1]  697 	bres	0x5210, #0
                                    698 ;	main.c: 149: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008555 35 10 52 12      [ 1]  699 	mov	0x5212+0, #0x10
                                    700 ;	main.c: 150: I2C_CCRH = 0;                   // =0
      008559 35 00 52 1C      [ 1]  701 	mov	0x521c+0, #0x00
                                    702 ;	main.c: 151: I2C_CCRL = 80;                  // 100kHz for I2C
      00855D 35 50 52 1B      [ 1]  703 	mov	0x521b+0, #0x50
                                    704 ;	main.c: 152: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      008561 72 1F 52 1C      [ 1]  705 	bres	0x521c, #7
                                    706 ;	main.c: 153: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      008565 72 1F 52 14      [ 1]  707 	bres	0x5214, #7
                                    708 ;	main.c: 154: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      008569 72 1C 52 14      [ 1]  709 	bset	0x5214, #6
                                    710 ;	main.c: 155: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      00856D 72 10 52 10      [ 1]  711 	bset	0x5210, #0
                                    712 ;	main.c: 156: }
      008571 81               [ 4]  713 	ret
                                    714 ;	main.c: 160: void i2c_start(void) {
                                    715 ;	-----------------------------------------
                                    716 ;	 function i2c_start
                                    717 ;	-----------------------------------------
      008572                        718 _i2c_start:
                                    719 ;	main.c: 161: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      008572 72 10 52 11      [ 1]  720 	bset	0x5211, #0
                                    721 ;	main.c: 162: while(!(I2C_SR1 & (1 << 0)));
      008576                        722 00101$:
      008576 72 01 52 17 FB   [ 2]  723 	btjf	0x5217, #0, 00101$
                                    724 ;	main.c: 164: }
      00857B 81               [ 4]  725 	ret
                                    726 ;	main.c: 166: void i2c_send_address(uint8_t address) {
                                    727 ;	-----------------------------------------
                                    728 ;	 function i2c_send_address
                                    729 ;	-----------------------------------------
      00857C                        730 _i2c_send_address:
                                    731 ;	main.c: 167: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      00857C 48               [ 1]  732 	sll	a
      00857D C7 52 16         [ 1]  733 	ld	0x5216, a
                                    734 ;	main.c: 168: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      008580                        735 00102$:
      008580 72 03 52 17 01   [ 2]  736 	btjf	0x5217, #1, 00117$
      008585 81               [ 4]  737 	ret
      008586                        738 00117$:
      008586 72 05 52 18 F5   [ 2]  739 	btjf	0x5218, #2, 00102$
                                    740 ;	main.c: 169: }
      00858B 81               [ 4]  741 	ret
                                    742 ;	main.c: 171: void i2c_stop(void) {
                                    743 ;	-----------------------------------------
                                    744 ;	 function i2c_stop
                                    745 ;	-----------------------------------------
      00858C                        746 _i2c_stop:
                                    747 ;	main.c: 172: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      00858C 72 12 52 11      [ 1]  748 	bset	0x5211, #1
                                    749 ;	main.c: 174: }
      008590 81               [ 4]  750 	ret
                                    751 ;	main.c: 178: void i2c_scan(void) {
                                    752 ;	-----------------------------------------
                                    753 ;	 function i2c_scan
                                    754 ;	-----------------------------------------
      008591                        755 _i2c_scan:
      008591 52 05            [ 2]  756 	sub	sp, #5
                                    757 ;	main.c: 179: for (uint8_t addr = 1; addr < 127; addr++) {
      008593 A6 01            [ 1]  758 	ld	a, #0x01
      008595 6B 05            [ 1]  759 	ld	(0x05, sp), a
      008597                        760 00105$:
      008597 7B 05            [ 1]  761 	ld	a, (0x05, sp)
      008599 A1 7F            [ 1]  762 	cp	a, #0x7f
      00859B 24 40            [ 1]  763 	jrnc	00107$
                                    764 ;	main.c: 180: i2c_start();
      00859D CD 85 72         [ 4]  765 	call	_i2c_start
                                    766 ;	main.c: 181: i2c_send_address(addr);
      0085A0 7B 05            [ 1]  767 	ld	a, (0x05, sp)
      0085A2 CD 85 7C         [ 4]  768 	call	_i2c_send_address
                                    769 ;	main.c: 182: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0085A5 72 04 52 18 28   [ 2]  770 	btjt	0x5218, #2, 00102$
                                    771 ;	main.c: 184: uart_write("SM ");
      0085AA AE 80 C3         [ 2]  772 	ldw	x, #(___str_17+0)
      0085AD CD 82 26         [ 4]  773 	call	_uart_write
                                    774 ;	main.c: 185: char rx_int_chars[4]={0};
      0085B0 0F 01            [ 1]  775 	clr	(0x01, sp)
      0085B2 0F 02            [ 1]  776 	clr	(0x02, sp)
      0085B4 0F 03            [ 1]  777 	clr	(0x03, sp)
      0085B6 0F 04            [ 1]  778 	clr	(0x04, sp)
                                    779 ;	main.c: 186: convert_int_to_chars(addr, rx_int_chars);
      0085B8 96               [ 1]  780 	ldw	x, sp
      0085B9 5C               [ 1]  781 	incw	x
      0085BA 7B 05            [ 1]  782 	ld	a, (0x05, sp)
      0085BC CD 82 56         [ 4]  783 	call	_convert_int_to_chars
                                    784 ;	main.c: 187: uart_write(rx_int_chars); 
      0085BF 96               [ 1]  785 	ldw	x, sp
      0085C0 5C               [ 1]  786 	incw	x
      0085C1 CD 82 26         [ 4]  787 	call	_uart_write
                                    788 ;	main.c: 188: uart_write("\r\n");
      0085C4 AE 80 C7         [ 2]  789 	ldw	x, #(___str_18+0)
      0085C7 CD 82 26         [ 4]  790 	call	_uart_write
                                    791 ;	main.c: 189: current_dev = addr;
      0085CA 7B 05            [ 1]  792 	ld	a, (0x05, sp)
      0085CC C7 01 01         [ 1]  793 	ld	_current_dev+0, a
                                    794 ;	main.c: 190: status_check();
      0085CF CD 83 13         [ 4]  795 	call	_status_check
      0085D2                        796 00102$:
                                    797 ;	main.c: 192: i2c_stop();
      0085D2 CD 85 8C         [ 4]  798 	call	_i2c_stop
                                    799 ;	main.c: 193: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      0085D5 72 15 52 18      [ 1]  800 	bres	0x5218, #2
                                    801 ;	main.c: 179: for (uint8_t addr = 1; addr < 127; addr++) {
      0085D9 0C 05            [ 1]  802 	inc	(0x05, sp)
      0085DB 20 BA            [ 2]  803 	jra	00105$
      0085DD                        804 00107$:
                                    805 ;	main.c: 197: }
      0085DD 5B 05            [ 2]  806 	addw	sp, #5
      0085DF 81               [ 4]  807 	ret
                                    808 ;	main.c: 200: int uart_read(void)
                                    809 ;	-----------------------------------------
                                    810 ;	 function uart_read
                                    811 ;	-----------------------------------------
      0085E0                        812 _uart_read:
      0085E0 52 0B            [ 2]  813 	sub	sp, #11
                                    814 ;	main.c: 202: char rx_binary_chars[9]={0};
      0085E2 0F 01            [ 1]  815 	clr	(0x01, sp)
      0085E4 0F 02            [ 1]  816 	clr	(0x02, sp)
      0085E6 0F 03            [ 1]  817 	clr	(0x03, sp)
      0085E8 0F 04            [ 1]  818 	clr	(0x04, sp)
      0085EA 0F 05            [ 1]  819 	clr	(0x05, sp)
      0085EC 0F 06            [ 1]  820 	clr	(0x06, sp)
      0085EE 0F 07            [ 1]  821 	clr	(0x07, sp)
      0085F0 0F 08            [ 1]  822 	clr	(0x08, sp)
      0085F2 0F 09            [ 1]  823 	clr	(0x09, sp)
                                    824 ;	main.c: 203: for(int i = 0; i < 256; i++)
      0085F4 5F               [ 1]  825 	clrw	x
      0085F5                        826 00112$:
      0085F5 A3 01 00         [ 2]  827 	cpw	x, #0x0100
      0085F8 2E 09            [ 1]  828 	jrsge	00101$
                                    829 ;	main.c: 205: buffer[i] = 0;
      0085FA 90 93            [ 1]  830 	ldw	y, x
      0085FC 90 4F 00 01      [ 1]  831 	clr	((_buffer+0), y)
                                    832 ;	main.c: 203: for(int i = 0; i < 256; i++)
      008600 5C               [ 1]  833 	incw	x
      008601 20 F2            [ 2]  834 	jra	00112$
      008603                        835 00101$:
                                    836 ;	main.c: 207: int i = 0;
      008603 5F               [ 1]  837 	clrw	x
      008604 1F 0A            [ 2]  838 	ldw	(0x0a, sp), x
                                    839 ;	main.c: 208: while(i < 256)
      008606 90 5F            [ 1]  840 	clrw	y
      008608                        841 00108$:
      008608 90 A3 01 00      [ 2]  842 	cpw	y, #0x0100
      00860C 2E 2A            [ 1]  843 	jrsge	00110$
                                    844 ;	main.c: 210: while(!(UART1_SR & UART_SR_RXNE));
      00860E                        845 00102$:
      00860E 72 0B 52 30 FB   [ 2]  846 	btjf	0x5230, #5, 00102$
                                    847 ;	main.c: 211: buffer[i] = UART1_DR;
      008613 93               [ 1]  848 	ldw	x, y
      008614 1C 00 01         [ 2]  849 	addw	x, #(_buffer+0)
      008617 C6 52 31         [ 1]  850 	ld	a, 0x5231
      00861A F7               [ 1]  851 	ld	(x), a
                                    852 ;	main.c: 212: if(buffer[i] == '\n' || buffer[i] == '\0')
      00861B A1 0A            [ 1]  853 	cp	a, #0x0a
      00861D 27 03            [ 1]  854 	jreq	00105$
      00861F F6               [ 1]  855 	ld	a, (x)
      008620 26 10            [ 1]  856 	jrne	00106$
      008622                        857 00105$:
                                    858 ;	main.c: 214: buffer[i] = '\0';
      008622 1E 0A            [ 2]  859 	ldw	x, (0x0a, sp)
      008624 72 4F 00 01      [ 1]  860 	clr	((_buffer+0), x)
                                    861 ;	main.c: 215: uart_write("flag_S");
      008628 AE 80 CA         [ 2]  862 	ldw	x, #(___str_19+0)
      00862B CD 82 26         [ 4]  863 	call	_uart_write
                                    864 ;	main.c: 216: return 1;
      00862E 5F               [ 1]  865 	clrw	x
      00862F 5C               [ 1]  866 	incw	x
      008630 20 07            [ 2]  867 	jra	00114$
      008632                        868 00106$:
                                    869 ;	main.c: 218: i++;
      008632 90 5C            [ 1]  870 	incw	y
      008634 17 0A            [ 2]  871 	ldw	(0x0a, sp), y
      008636 20 D0            [ 2]  872 	jra	00108$
      008638                        873 00110$:
                                    874 ;	main.c: 220: return 0;
      008638 5F               [ 1]  875 	clrw	x
      008639                        876 00114$:
                                    877 ;	main.c: 246: }
      008639 5B 0B            [ 2]  878 	addw	sp, #11
      00863B 81               [ 4]  879 	ret
                                    880 ;	main.c: 249: int main(void)
                                    881 ;	-----------------------------------------
                                    882 ;	 function main
                                    883 ;	-----------------------------------------
      00863C                        884 _main:
                                    885 ;	main.c: 251: uart_init();
      00863C CD 85 34         [ 4]  886 	call	_uart_init
                                    887 ;	main.c: 252: uart_write("SS\n");
      00863F AE 80 D1         [ 2]  888 	ldw	x, #(___str_20+0)
      008642 CD 82 26         [ 4]  889 	call	_uart_write
                                    890 ;	main.c: 254: while(uart_read())
      008645                        891 00102$:
      008645 CD 85 E0         [ 4]  892 	call	_uart_read
      008648 5D               [ 2]  893 	tnzw	x
      008649 27 29            [ 1]  894 	jreq	00104$
                                    895 ;	main.c: 256: uart_write("\n>buffer start<\n");
      00864B AE 80 D5         [ 2]  896 	ldw	x, #(___str_21+0)
      00864E CD 82 26         [ 4]  897 	call	_uart_write
                                    898 ;	main.c: 257: for(int i = 0; i < 256; i++)
      008651 5F               [ 1]  899 	clrw	x
      008652                        900 00106$:
      008652 A3 01 00         [ 2]  901 	cpw	x, #0x0100
      008655 2E 15            [ 1]  902 	jrsge	00101$
                                    903 ;	main.c: 259: uart_write(&buffer[i] + '\0');
      008657 90 93            [ 1]  904 	ldw	y, x
      008659 72 A9 00 01      [ 2]  905 	addw	y, #(_buffer+0)
      00865D 89               [ 2]  906 	pushw	x
      00865E 93               [ 1]  907 	ldw	x, y
      00865F CD 82 26         [ 4]  908 	call	_uart_write
      008662 AE 80 E6         [ 2]  909 	ldw	x, #(___str_22+0)
      008665 CD 82 26         [ 4]  910 	call	_uart_write
      008668 85               [ 2]  911 	popw	x
                                    912 ;	main.c: 257: for(int i = 0; i < 256; i++)
      008669 5C               [ 1]  913 	incw	x
      00866A 20 E6            [ 2]  914 	jra	00106$
      00866C                        915 00101$:
                                    916 ;	main.c: 262: uart_write("> buffer end <");
      00866C AE 80 E8         [ 2]  917 	ldw	x, #(___str_23+0)
      00866F CD 82 26         [ 4]  918 	call	_uart_write
      008672 20 D1            [ 2]  919 	jra	00102$
      008674                        920 00104$:
                                    921 ;	main.c: 264: i2c_init();
      008674 CD 85 51         [ 4]  922 	call	_i2c_init
                                    923 ;	main.c: 268: i2c_scan(); 
      008677 CD 85 91         [ 4]  924 	call	_i2c_scan
                                    925 ;	main.c: 270: return 0;
      00867A 5F               [ 1]  926 	clrw	x
                                    927 ;	main.c: 271: }
      00867B 81               [ 4]  928 	ret
                                    929 	.area CODE
                                    930 	.area CONST
                                    931 	.area CONST
      00802D                        932 ___str_0:
      00802D 0A                     933 	.db 0x0a
      00802E 49 32 43 5F 52 45 47   934 	.ascii "I2C_REGS >.<"
             53 20 3E 2E 3C
      00803A 0A                     935 	.db 0x0a
      00803B 00                     936 	.db 0x00
                                    937 	.area CODE
                                    938 	.area CONST
      00803C                        939 ___str_1:
      00803C 0A                     940 	.db 0x0a
      00803D 53 52 31 20 2D 3E 20   941 	.ascii "SR1 -> "
      008044 00                     942 	.db 0x00
                                    943 	.area CODE
                                    944 	.area CONST
      008045                        945 ___str_2:
      008045 20 3C 2D               946 	.ascii " <-"
      008048 0A                     947 	.db 0x0a
      008049 00                     948 	.db 0x00
                                    949 	.area CODE
                                    950 	.area CONST
      00804A                        951 ___str_3:
      00804A 53 52 32 20 2D 3E 20   952 	.ascii "SR2 -> "
      008051 00                     953 	.db 0x00
                                    954 	.area CODE
                                    955 	.area CONST
      008052                        956 ___str_4:
      008052 53 52 33 20 2D 3E 20   957 	.ascii "SR3 -> "
      008059 00                     958 	.db 0x00
                                    959 	.area CODE
                                    960 	.area CONST
      00805A                        961 ___str_5:
      00805A 43 52 31 20 2D 3E 20   962 	.ascii "CR1 -> "
      008061 00                     963 	.db 0x00
                                    964 	.area CODE
                                    965 	.area CONST
      008062                        966 ___str_6:
      008062 43 52 32 20 2D 3E 20   967 	.ascii "CR2 -> "
      008069 00                     968 	.db 0x00
                                    969 	.area CODE
                                    970 	.area CONST
      00806A                        971 ___str_7:
      00806A 44 52 20 2D 3E 20      972 	.ascii "DR -> "
      008070 00                     973 	.db 0x00
                                    974 	.area CODE
                                    975 	.area CONST
      008071                        976 ___str_8:
      008071 55 41 52 54 5F 52 45   977 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      00807E 0A                     978 	.db 0x0a
      00807F 00                     979 	.db 0x00
                                    980 	.area CODE
                                    981 	.area CONST
      008080                        982 ___str_9:
      008080 0A                     983 	.db 0x0a
      008081 53 52 20 2D 3E 20      984 	.ascii "SR -> "
      008087 00                     985 	.db 0x00
                                    986 	.area CODE
                                    987 	.area CONST
      008088                        988 ___str_10:
      008088 42 52 52 31 20 2D 3E   989 	.ascii "BRR1 -> "
             20
      008090 00                     990 	.db 0x00
                                    991 	.area CODE
                                    992 	.area CONST
      008091                        993 ___str_11:
      008091 42 52 52 32 20 2D 3E   994 	.ascii "BRR2 -> "
             20
      008099 00                     995 	.db 0x00
                                    996 	.area CODE
                                    997 	.area CONST
      00809A                        998 ___str_12:
      00809A 43 52 33 20 2D 3E 20   999 	.ascii "CR3 -> "
      0080A1 00                    1000 	.db 0x00
                                   1001 	.area CODE
                                   1002 	.area CONST
      0080A2                       1003 ___str_13:
      0080A2 43 52 34 20 2D 3E 20  1004 	.ascii "CR4 -> "
      0080A9 00                    1005 	.db 0x00
                                   1006 	.area CODE
                                   1007 	.area CONST
      0080AA                       1008 ___str_14:
      0080AA 43 52 35 20 2D 3E 20  1009 	.ascii "CR5 -> "
      0080B1 00                    1010 	.db 0x00
                                   1011 	.area CODE
                                   1012 	.area CONST
      0080B2                       1013 ___str_15:
      0080B2 47 54 52 20 2D 3E 20  1014 	.ascii "GTR -> "
      0080B9 00                    1015 	.db 0x00
                                   1016 	.area CODE
                                   1017 	.area CONST
      0080BA                       1018 ___str_16:
      0080BA 50 53 43 52 20 2D 3E  1019 	.ascii "PSCR -> "
             20
      0080C2 00                    1020 	.db 0x00
                                   1021 	.area CODE
                                   1022 	.area CONST
      0080C3                       1023 ___str_17:
      0080C3 53 4D 20              1024 	.ascii "SM "
      0080C6 00                    1025 	.db 0x00
                                   1026 	.area CODE
                                   1027 	.area CONST
      0080C7                       1028 ___str_18:
      0080C7 0D                    1029 	.db 0x0d
      0080C8 0A                    1030 	.db 0x0a
      0080C9 00                    1031 	.db 0x00
                                   1032 	.area CODE
                                   1033 	.area CONST
      0080CA                       1034 ___str_19:
      0080CA 66 6C 61 67 5F 53     1035 	.ascii "flag_S"
      0080D0 00                    1036 	.db 0x00
                                   1037 	.area CODE
                                   1038 	.area CONST
      0080D1                       1039 ___str_20:
      0080D1 53 53                 1040 	.ascii "SS"
      0080D3 0A                    1041 	.db 0x0a
      0080D4 00                    1042 	.db 0x00
                                   1043 	.area CODE
                                   1044 	.area CONST
      0080D5                       1045 ___str_21:
      0080D5 0A                    1046 	.db 0x0a
      0080D6 3E 62 75 66 66 65 72  1047 	.ascii ">buffer start<"
             20 73 74 61 72 74 3C
      0080E4 0A                    1048 	.db 0x0a
      0080E5 00                    1049 	.db 0x00
                                   1050 	.area CODE
                                   1051 	.area CONST
      0080E6                       1052 ___str_22:
      0080E6 20                    1053 	.ascii " "
      0080E7 00                    1054 	.db 0x00
                                   1055 	.area CODE
                                   1056 	.area CONST
      0080E8                       1057 ___str_23:
      0080E8 3E 20 62 75 66 66 65  1058 	.ascii "> buffer end <"
             72 20 65 6E 64 20 3C
      0080F6 00                    1059 	.db 0x00
                                   1060 	.area CODE
                                   1061 	.area INITIALIZER
      0080F7                       1062 __xinit__buffer:
      0080F7 00                    1063 	.db #0x00	; 0
      0080F8 00                    1064 	.db 0x00
      0080F9 00                    1065 	.db 0x00
      0080FA 00                    1066 	.db 0x00
      0080FB 00                    1067 	.db 0x00
      0080FC 00                    1068 	.db 0x00
      0080FD 00                    1069 	.db 0x00
      0080FE 00                    1070 	.db 0x00
      0080FF 00                    1071 	.db 0x00
      008100 00                    1072 	.db 0x00
      008101 00                    1073 	.db 0x00
      008102 00                    1074 	.db 0x00
      008103 00                    1075 	.db 0x00
      008104 00                    1076 	.db 0x00
      008105 00                    1077 	.db 0x00
      008106 00                    1078 	.db 0x00
      008107 00                    1079 	.db 0x00
      008108 00                    1080 	.db 0x00
      008109 00                    1081 	.db 0x00
      00810A 00                    1082 	.db 0x00
      00810B 00                    1083 	.db 0x00
      00810C 00                    1084 	.db 0x00
      00810D 00                    1085 	.db 0x00
      00810E 00                    1086 	.db 0x00
      00810F 00                    1087 	.db 0x00
      008110 00                    1088 	.db 0x00
      008111 00                    1089 	.db 0x00
      008112 00                    1090 	.db 0x00
      008113 00                    1091 	.db 0x00
      008114 00                    1092 	.db 0x00
      008115 00                    1093 	.db 0x00
      008116 00                    1094 	.db 0x00
      008117 00                    1095 	.db 0x00
      008118 00                    1096 	.db 0x00
      008119 00                    1097 	.db 0x00
      00811A 00                    1098 	.db 0x00
      00811B 00                    1099 	.db 0x00
      00811C 00                    1100 	.db 0x00
      00811D 00                    1101 	.db 0x00
      00811E 00                    1102 	.db 0x00
      00811F 00                    1103 	.db 0x00
      008120 00                    1104 	.db 0x00
      008121 00                    1105 	.db 0x00
      008122 00                    1106 	.db 0x00
      008123 00                    1107 	.db 0x00
      008124 00                    1108 	.db 0x00
      008125 00                    1109 	.db 0x00
      008126 00                    1110 	.db 0x00
      008127 00                    1111 	.db 0x00
      008128 00                    1112 	.db 0x00
      008129 00                    1113 	.db 0x00
      00812A 00                    1114 	.db 0x00
      00812B 00                    1115 	.db 0x00
      00812C 00                    1116 	.db 0x00
      00812D 00                    1117 	.db 0x00
      00812E 00                    1118 	.db 0x00
      00812F 00                    1119 	.db 0x00
      008130 00                    1120 	.db 0x00
      008131 00                    1121 	.db 0x00
      008132 00                    1122 	.db 0x00
      008133 00                    1123 	.db 0x00
      008134 00                    1124 	.db 0x00
      008135 00                    1125 	.db 0x00
      008136 00                    1126 	.db 0x00
      008137 00                    1127 	.db 0x00
      008138 00                    1128 	.db 0x00
      008139 00                    1129 	.db 0x00
      00813A 00                    1130 	.db 0x00
      00813B 00                    1131 	.db 0x00
      00813C 00                    1132 	.db 0x00
      00813D 00                    1133 	.db 0x00
      00813E 00                    1134 	.db 0x00
      00813F 00                    1135 	.db 0x00
      008140 00                    1136 	.db 0x00
      008141 00                    1137 	.db 0x00
      008142 00                    1138 	.db 0x00
      008143 00                    1139 	.db 0x00
      008144 00                    1140 	.db 0x00
      008145 00                    1141 	.db 0x00
      008146 00                    1142 	.db 0x00
      008147 00                    1143 	.db 0x00
      008148 00                    1144 	.db 0x00
      008149 00                    1145 	.db 0x00
      00814A 00                    1146 	.db 0x00
      00814B 00                    1147 	.db 0x00
      00814C 00                    1148 	.db 0x00
      00814D 00                    1149 	.db 0x00
      00814E 00                    1150 	.db 0x00
      00814F 00                    1151 	.db 0x00
      008150 00                    1152 	.db 0x00
      008151 00                    1153 	.db 0x00
      008152 00                    1154 	.db 0x00
      008153 00                    1155 	.db 0x00
      008154 00                    1156 	.db 0x00
      008155 00                    1157 	.db 0x00
      008156 00                    1158 	.db 0x00
      008157 00                    1159 	.db 0x00
      008158 00                    1160 	.db 0x00
      008159 00                    1161 	.db 0x00
      00815A 00                    1162 	.db 0x00
      00815B 00                    1163 	.db 0x00
      00815C 00                    1164 	.db 0x00
      00815D 00                    1165 	.db 0x00
      00815E 00                    1166 	.db 0x00
      00815F 00                    1167 	.db 0x00
      008160 00                    1168 	.db 0x00
      008161 00                    1169 	.db 0x00
      008162 00                    1170 	.db 0x00
      008163 00                    1171 	.db 0x00
      008164 00                    1172 	.db 0x00
      008165 00                    1173 	.db 0x00
      008166 00                    1174 	.db 0x00
      008167 00                    1175 	.db 0x00
      008168 00                    1176 	.db 0x00
      008169 00                    1177 	.db 0x00
      00816A 00                    1178 	.db 0x00
      00816B 00                    1179 	.db 0x00
      00816C 00                    1180 	.db 0x00
      00816D 00                    1181 	.db 0x00
      00816E 00                    1182 	.db 0x00
      00816F 00                    1183 	.db 0x00
      008170 00                    1184 	.db 0x00
      008171 00                    1185 	.db 0x00
      008172 00                    1186 	.db 0x00
      008173 00                    1187 	.db 0x00
      008174 00                    1188 	.db 0x00
      008175 00                    1189 	.db 0x00
      008176 00                    1190 	.db 0x00
      008177 00                    1191 	.db 0x00
      008178 00                    1192 	.db 0x00
      008179 00                    1193 	.db 0x00
      00817A 00                    1194 	.db 0x00
      00817B 00                    1195 	.db 0x00
      00817C 00                    1196 	.db 0x00
      00817D 00                    1197 	.db 0x00
      00817E 00                    1198 	.db 0x00
      00817F 00                    1199 	.db 0x00
      008180 00                    1200 	.db 0x00
      008181 00                    1201 	.db 0x00
      008182 00                    1202 	.db 0x00
      008183 00                    1203 	.db 0x00
      008184 00                    1204 	.db 0x00
      008185 00                    1205 	.db 0x00
      008186 00                    1206 	.db 0x00
      008187 00                    1207 	.db 0x00
      008188 00                    1208 	.db 0x00
      008189 00                    1209 	.db 0x00
      00818A 00                    1210 	.db 0x00
      00818B 00                    1211 	.db 0x00
      00818C 00                    1212 	.db 0x00
      00818D 00                    1213 	.db 0x00
      00818E 00                    1214 	.db 0x00
      00818F 00                    1215 	.db 0x00
      008190 00                    1216 	.db 0x00
      008191 00                    1217 	.db 0x00
      008192 00                    1218 	.db 0x00
      008193 00                    1219 	.db 0x00
      008194 00                    1220 	.db 0x00
      008195 00                    1221 	.db 0x00
      008196 00                    1222 	.db 0x00
      008197 00                    1223 	.db 0x00
      008198 00                    1224 	.db 0x00
      008199 00                    1225 	.db 0x00
      00819A 00                    1226 	.db 0x00
      00819B 00                    1227 	.db 0x00
      00819C 00                    1228 	.db 0x00
      00819D 00                    1229 	.db 0x00
      00819E 00                    1230 	.db 0x00
      00819F 00                    1231 	.db 0x00
      0081A0 00                    1232 	.db 0x00
      0081A1 00                    1233 	.db 0x00
      0081A2 00                    1234 	.db 0x00
      0081A3 00                    1235 	.db 0x00
      0081A4 00                    1236 	.db 0x00
      0081A5 00                    1237 	.db 0x00
      0081A6 00                    1238 	.db 0x00
      0081A7 00                    1239 	.db 0x00
      0081A8 00                    1240 	.db 0x00
      0081A9 00                    1241 	.db 0x00
      0081AA 00                    1242 	.db 0x00
      0081AB 00                    1243 	.db 0x00
      0081AC 00                    1244 	.db 0x00
      0081AD 00                    1245 	.db 0x00
      0081AE 00                    1246 	.db 0x00
      0081AF 00                    1247 	.db 0x00
      0081B0 00                    1248 	.db 0x00
      0081B1 00                    1249 	.db 0x00
      0081B2 00                    1250 	.db 0x00
      0081B3 00                    1251 	.db 0x00
      0081B4 00                    1252 	.db 0x00
      0081B5 00                    1253 	.db 0x00
      0081B6 00                    1254 	.db 0x00
      0081B7 00                    1255 	.db 0x00
      0081B8 00                    1256 	.db 0x00
      0081B9 00                    1257 	.db 0x00
      0081BA 00                    1258 	.db 0x00
      0081BB 00                    1259 	.db 0x00
      0081BC 00                    1260 	.db 0x00
      0081BD 00                    1261 	.db 0x00
      0081BE 00                    1262 	.db 0x00
      0081BF 00                    1263 	.db 0x00
      0081C0 00                    1264 	.db 0x00
      0081C1 00                    1265 	.db 0x00
      0081C2 00                    1266 	.db 0x00
      0081C3 00                    1267 	.db 0x00
      0081C4 00                    1268 	.db 0x00
      0081C5 00                    1269 	.db 0x00
      0081C6 00                    1270 	.db 0x00
      0081C7 00                    1271 	.db 0x00
      0081C8 00                    1272 	.db 0x00
      0081C9 00                    1273 	.db 0x00
      0081CA 00                    1274 	.db 0x00
      0081CB 00                    1275 	.db 0x00
      0081CC 00                    1276 	.db 0x00
      0081CD 00                    1277 	.db 0x00
      0081CE 00                    1278 	.db 0x00
      0081CF 00                    1279 	.db 0x00
      0081D0 00                    1280 	.db 0x00
      0081D1 00                    1281 	.db 0x00
      0081D2 00                    1282 	.db 0x00
      0081D3 00                    1283 	.db 0x00
      0081D4 00                    1284 	.db 0x00
      0081D5 00                    1285 	.db 0x00
      0081D6 00                    1286 	.db 0x00
      0081D7 00                    1287 	.db 0x00
      0081D8 00                    1288 	.db 0x00
      0081D9 00                    1289 	.db 0x00
      0081DA 00                    1290 	.db 0x00
      0081DB 00                    1291 	.db 0x00
      0081DC 00                    1292 	.db 0x00
      0081DD 00                    1293 	.db 0x00
      0081DE 00                    1294 	.db 0x00
      0081DF 00                    1295 	.db 0x00
      0081E0 00                    1296 	.db 0x00
      0081E1 00                    1297 	.db 0x00
      0081E2 00                    1298 	.db 0x00
      0081E3 00                    1299 	.db 0x00
      0081E4 00                    1300 	.db 0x00
      0081E5 00                    1301 	.db 0x00
      0081E6 00                    1302 	.db 0x00
      0081E7 00                    1303 	.db 0x00
      0081E8 00                    1304 	.db 0x00
      0081E9 00                    1305 	.db 0x00
      0081EA 00                    1306 	.db 0x00
      0081EB 00                    1307 	.db 0x00
      0081EC 00                    1308 	.db 0x00
      0081ED 00                    1309 	.db 0x00
      0081EE 00                    1310 	.db 0x00
      0081EF 00                    1311 	.db 0x00
      0081F0 00                    1312 	.db 0x00
      0081F1 00                    1313 	.db 0x00
      0081F2 00                    1314 	.db 0x00
      0081F3 00                    1315 	.db 0x00
      0081F4 00                    1316 	.db 0x00
      0081F5 00                    1317 	.db 0x00
      0081F6 00                    1318 	.db 0x00
      0081F7                       1319 __xinit__current_dev:
      0081F7 00                    1320 	.db #0x00	; 0
                                   1321 	.area CABS (ABS)
