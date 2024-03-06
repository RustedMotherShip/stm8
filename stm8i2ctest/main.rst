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
                                     12 	.globl _i2c_scan
                                     13 	.globl _i2c_stop
                                     14 	.globl _i2c_send_address
                                     15 	.globl _i2c_start
                                     16 	.globl _i2c_init
                                     17 	.globl _uart_init
                                     18 	.globl _status_check
                                     19 	.globl _convert_int_to_binary
                                     20 	.globl _convert_int_to_chars
                                     21 	.globl _uart_write
                                     22 	.globl _delay
                                     23 	.globl _strlen
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DATA
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area INITIALIZED
                                     32 ;--------------------------------------------------------
                                     33 ; Stack segment in internal ram
                                     34 ;--------------------------------------------------------
                                     35 	.area SSEG
      000001                         36 __start__stack:
      000001                         37 	.ds	1
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; absolute external ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area DABS (ABS)
                                     43 
                                     44 ; default segment ordering for linker
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area CONST
                                     49 	.area INITIALIZER
                                     50 	.area CODE
                                     51 
                                     52 ;--------------------------------------------------------
                                     53 ; interrupt vector
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
      008000                         56 __interrupt_vect:
      008000 82 00 80 07             57 	int s_GSINIT ; reset
                                     58 ;--------------------------------------------------------
                                     59 ; global & static initialisations
                                     60 ;--------------------------------------------------------
                                     61 	.area HOME
                                     62 	.area GSINIT
                                     63 	.area GSFINAL
                                     64 	.area GSINIT
      008007 CD 83 79         [ 4]   65 	call	___sdcc_external_startup
      00800A 4D               [ 1]   66 	tnz	a
      00800B 27 03            [ 1]   67 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   68 	jp	__sdcc_program_startup
      008010                         69 __sdcc_init_data:
                                     70 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   71 	ldw x, #l_DATA
      008013 27 07            [ 1]   72 	jreq	00002$
      008015                         73 00001$:
      008015 72 4F 00 00      [ 1]   74 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   75 	decw x
      00801A 26 F9            [ 1]   76 	jrne	00001$
      00801C                         77 00002$:
      00801C AE 00 00         [ 2]   78 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   79 	jreq	00004$
      008021                         80 00003$:
      008021 D6 80 C1         [ 1]   81 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   82 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   83 	decw	x
      008028 26 F7            [ 1]   84 	jrne	00003$
      00802A                         85 00004$:
                                     86 ; stm8_genXINIT() end
                                     87 	.area GSFINAL
      00802A CC 80 04         [ 2]   88 	jp	__sdcc_program_startup
                                     89 ;--------------------------------------------------------
                                     90 ; Home
                                     91 ;--------------------------------------------------------
                                     92 	.area HOME
                                     93 	.area HOME
      008004                         94 __sdcc_program_startup:
      008004 CC 83 65         [ 2]   95 	jp	_main
                                     96 ;	return from main will return to caller
                                     97 ;--------------------------------------------------------
                                     98 ; code
                                     99 ;--------------------------------------------------------
                                    100 	.area CODE
                                    101 ;	main.c: 7: void delay(unsigned long count) {
                                    102 ;	-----------------------------------------
                                    103 ;	 function delay
                                    104 ;	-----------------------------------------
      0080C2                        105 _delay:
      0080C2 52 08            [ 2]  106 	sub	sp, #8
                                    107 ;	main.c: 8: while (count--)
      0080C4 16 0D            [ 2]  108 	ldw	y, (0x0d, sp)
      0080C6 17 07            [ 2]  109 	ldw	(0x07, sp), y
      0080C8 1E 0B            [ 2]  110 	ldw	x, (0x0b, sp)
      0080CA                        111 00101$:
      0080CA 1F 01            [ 2]  112 	ldw	(0x01, sp), x
      0080CC 7B 07            [ 1]  113 	ld	a, (0x07, sp)
      0080CE 6B 03            [ 1]  114 	ld	(0x03, sp), a
      0080D0 7B 08            [ 1]  115 	ld	a, (0x08, sp)
      0080D2 16 07            [ 2]  116 	ldw	y, (0x07, sp)
      0080D4 72 A2 00 01      [ 2]  117 	subw	y, #0x0001
      0080D8 17 07            [ 2]  118 	ldw	(0x07, sp), y
      0080DA 24 01            [ 1]  119 	jrnc	00117$
      0080DC 5A               [ 2]  120 	decw	x
      0080DD                        121 00117$:
      0080DD 4D               [ 1]  122 	tnz	a
      0080DE 26 08            [ 1]  123 	jrne	00118$
      0080E0 16 02            [ 2]  124 	ldw	y, (0x02, sp)
      0080E2 26 04            [ 1]  125 	jrne	00118$
      0080E4 0D 01            [ 1]  126 	tnz	(0x01, sp)
      0080E6 27 03            [ 1]  127 	jreq	00104$
      0080E8                        128 00118$:
                                    129 ;	main.c: 9: nop();
      0080E8 9D               [ 1]  130 	nop
      0080E9 20 DF            [ 2]  131 	jra	00101$
      0080EB                        132 00104$:
                                    133 ;	main.c: 10: }
      0080EB 1E 09            [ 2]  134 	ldw	x, (9, sp)
      0080ED 5B 0E            [ 2]  135 	addw	sp, #14
      0080EF FC               [ 2]  136 	jp	(x)
                                    137 ;	main.c: 12: int uart_write(const char *str) {
                                    138 ;	-----------------------------------------
                                    139 ;	 function uart_write
                                    140 ;	-----------------------------------------
      0080F0                        141 _uart_write:
      0080F0 52 05            [ 2]  142 	sub	sp, #5
      0080F2 1F 03            [ 2]  143 	ldw	(0x03, sp), x
                                    144 ;	main.c: 14: for(i = 0; i < strlen(str); i++) {
      0080F4 0F 05            [ 1]  145 	clr	(0x05, sp)
      0080F6                        146 00106$:
      0080F6 1E 03            [ 2]  147 	ldw	x, (0x03, sp)
      0080F8 CD 83 7B         [ 4]  148 	call	_strlen
      0080FB 1F 01            [ 2]  149 	ldw	(0x01, sp), x
      0080FD 5F               [ 1]  150 	clrw	x
      0080FE 7B 05            [ 1]  151 	ld	a, (0x05, sp)
      008100 97               [ 1]  152 	ld	xl, a
      008101 13 01            [ 2]  153 	cpw	x, (0x01, sp)
      008103 24 14            [ 1]  154 	jrnc	00104$
                                    155 ;	main.c: 15: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      008105                        156 00101$:
      008105 C6 52 30         [ 1]  157 	ld	a, 0x5230
      008108 2A FB            [ 1]  158 	jrpl	00101$
                                    159 ;	main.c: 16: UART1_DR = str[i];
      00810A 5F               [ 1]  160 	clrw	x
      00810B 7B 05            [ 1]  161 	ld	a, (0x05, sp)
      00810D 97               [ 1]  162 	ld	xl, a
      00810E 72 FB 03         [ 2]  163 	addw	x, (0x03, sp)
      008111 F6               [ 1]  164 	ld	a, (x)
      008112 C7 52 31         [ 1]  165 	ld	0x5231, a
                                    166 ;	main.c: 14: for(i = 0; i < strlen(str); i++) {
      008115 0C 05            [ 1]  167 	inc	(0x05, sp)
      008117 20 DD            [ 2]  168 	jra	00106$
      008119                        169 00104$:
                                    170 ;	main.c: 18: return(i); // Bytes sent
      008119 7B 05            [ 1]  171 	ld	a, (0x05, sp)
      00811B 5F               [ 1]  172 	clrw	x
      00811C 97               [ 1]  173 	ld	xl, a
                                    174 ;	main.c: 19: }
      00811D 5B 05            [ 2]  175 	addw	sp, #5
      00811F 81               [ 4]  176 	ret
                                    177 ;	main.c: 21: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    178 ;	-----------------------------------------
                                    179 ;	 function convert_int_to_chars
                                    180 ;	-----------------------------------------
      008120                        181 _convert_int_to_chars:
      008120 52 0D            [ 2]  182 	sub	sp, #13
      008122 6B 0D            [ 1]  183 	ld	(0x0d, sp), a
      008124 1F 0B            [ 2]  184 	ldw	(0x0b, sp), x
                                    185 ;	main.c: 24: rx_int_chars[0] = num / 100 + '0';
      008126 7B 0D            [ 1]  186 	ld	a, (0x0d, sp)
      008128 6B 02            [ 1]  187 	ld	(0x02, sp), a
      00812A 0F 01            [ 1]  188 	clr	(0x01, sp)
                                    189 ;	main.c: 25: rx_int_chars[1] = num / 10 % 10 + '0';
      00812C 1E 0B            [ 2]  190 	ldw	x, (0x0b, sp)
      00812E 5C               [ 1]  191 	incw	x
      00812F 1F 03            [ 2]  192 	ldw	(0x03, sp), x
                                    193 ;	main.c: 26: rx_int_chars[2] = num % 10 + '0';
      008131 1E 0B            [ 2]  194 	ldw	x, (0x0b, sp)
      008133 5C               [ 1]  195 	incw	x
      008134 5C               [ 1]  196 	incw	x
      008135 1F 05            [ 2]  197 	ldw	(0x05, sp), x
                                    198 ;	main.c: 25: rx_int_chars[1] = num / 10 % 10 + '0';
      008137 4B 0A            [ 1]  199 	push	#0x0a
      008139 4B 00            [ 1]  200 	push	#0x00
      00813B 1E 03            [ 2]  201 	ldw	x, (0x03, sp)
                                    202 ;	main.c: 26: rx_int_chars[2] = num % 10 + '0';
      00813D CD 83 A0         [ 4]  203 	call	__divsint
      008140 1F 07            [ 2]  204 	ldw	(0x07, sp), x
      008142 4B 0A            [ 1]  205 	push	#0x0a
      008144 4B 00            [ 1]  206 	push	#0x00
      008146 1E 03            [ 2]  207 	ldw	x, (0x03, sp)
      008148 CD 83 88         [ 4]  208 	call	__modsint
      00814B 9F               [ 1]  209 	ld	a, xl
      00814C AB 30            [ 1]  210 	add	a, #0x30
      00814E 6B 09            [ 1]  211 	ld	(0x09, sp), a
                                    212 ;	main.c: 22: if (num > 99) {
      008150 7B 0D            [ 1]  213 	ld	a, (0x0d, sp)
      008152 A1 63            [ 1]  214 	cp	a, #0x63
      008154 23 29            [ 2]  215 	jrule	00105$
                                    216 ;	main.c: 24: rx_int_chars[0] = num / 100 + '0';
      008156 4B 64            [ 1]  217 	push	#0x64
      008158 4B 00            [ 1]  218 	push	#0x00
      00815A 1E 03            [ 2]  219 	ldw	x, (0x03, sp)
      00815C CD 83 A0         [ 4]  220 	call	__divsint
      00815F 9F               [ 1]  221 	ld	a, xl
      008160 AB 30            [ 1]  222 	add	a, #0x30
      008162 1E 0B            [ 2]  223 	ldw	x, (0x0b, sp)
      008164 F7               [ 1]  224 	ld	(x), a
                                    225 ;	main.c: 25: rx_int_chars[1] = num / 10 % 10 + '0';
      008165 4B 0A            [ 1]  226 	push	#0x0a
      008167 4B 00            [ 1]  227 	push	#0x00
      008169 1E 09            [ 2]  228 	ldw	x, (0x09, sp)
      00816B CD 83 88         [ 4]  229 	call	__modsint
      00816E 9F               [ 1]  230 	ld	a, xl
      00816F AB 30            [ 1]  231 	add	a, #0x30
      008171 1E 03            [ 2]  232 	ldw	x, (0x03, sp)
      008173 F7               [ 1]  233 	ld	(x), a
                                    234 ;	main.c: 26: rx_int_chars[2] = num % 10 + '0';
      008174 1E 05            [ 2]  235 	ldw	x, (0x05, sp)
      008176 7B 09            [ 1]  236 	ld	a, (0x09, sp)
      008178 F7               [ 1]  237 	ld	(x), a
                                    238 ;	main.c: 27: rx_int_chars[3] ='\0';
      008179 1E 0B            [ 2]  239 	ldw	x, (0x0b, sp)
      00817B 6F 03            [ 1]  240 	clr	(0x0003, x)
      00817D 20 23            [ 2]  241 	jra	00107$
      00817F                        242 00105$:
                                    243 ;	main.c: 29: } else if (num > 9) {
      00817F 7B 0D            [ 1]  244 	ld	a, (0x0d, sp)
      008181 A1 09            [ 1]  245 	cp	a, #0x09
      008183 23 13            [ 2]  246 	jrule	00102$
                                    247 ;	main.c: 31: rx_int_chars[0] = num / 10 + '0';
      008185 7B 08            [ 1]  248 	ld	a, (0x08, sp)
      008187 6B 0A            [ 1]  249 	ld	(0x0a, sp), a
      008189 AB 30            [ 1]  250 	add	a, #0x30
      00818B 1E 0B            [ 2]  251 	ldw	x, (0x0b, sp)
      00818D F7               [ 1]  252 	ld	(x), a
                                    253 ;	main.c: 32: rx_int_chars[1] = num % 10 + '0';
      00818E 1E 03            [ 2]  254 	ldw	x, (0x03, sp)
      008190 7B 09            [ 1]  255 	ld	a, (0x09, sp)
      008192 F7               [ 1]  256 	ld	(x), a
                                    257 ;	main.c: 33: rx_int_chars[2] ='\0';
      008193 1E 05            [ 2]  258 	ldw	x, (0x05, sp)
      008195 7F               [ 1]  259 	clr	(x)
      008196 20 0A            [ 2]  260 	jra	00107$
      008198                        261 00102$:
                                    262 ;	main.c: 38: rx_int_chars[0] = num + '0';
      008198 7B 0D            [ 1]  263 	ld	a, (0x0d, sp)
      00819A AB 30            [ 1]  264 	add	a, #0x30
      00819C 1E 0B            [ 2]  265 	ldw	x, (0x0b, sp)
      00819E F7               [ 1]  266 	ld	(x), a
                                    267 ;	main.c: 39: rx_int_chars[1] ='\0';
      00819F 1E 03            [ 2]  268 	ldw	x, (0x03, sp)
      0081A1 7F               [ 1]  269 	clr	(x)
      0081A2                        270 00107$:
                                    271 ;	main.c: 41: }
      0081A2 5B 0D            [ 2]  272 	addw	sp, #13
      0081A4 81               [ 4]  273 	ret
                                    274 ;	main.c: 43: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    275 ;	-----------------------------------------
                                    276 ;	 function convert_int_to_binary
                                    277 ;	-----------------------------------------
      0081A5                        278 _convert_int_to_binary:
      0081A5 52 04            [ 2]  279 	sub	sp, #4
      0081A7 1F 01            [ 2]  280 	ldw	(0x01, sp), x
                                    281 ;	main.c: 45: for(int i = 7; i >= 0; i--) {
      0081A9 AE 00 07         [ 2]  282 	ldw	x, #0x0007
      0081AC 1F 03            [ 2]  283 	ldw	(0x03, sp), x
      0081AE                        284 00103$:
      0081AE 0D 03            [ 1]  285 	tnz	(0x03, sp)
      0081B0 2B 22            [ 1]  286 	jrmi	00101$
                                    287 ;	main.c: 47: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      0081B2 AE 00 07         [ 2]  288 	ldw	x, #0x0007
      0081B5 72 F0 03         [ 2]  289 	subw	x, (0x03, sp)
      0081B8 72 FB 07         [ 2]  290 	addw	x, (0x07, sp)
      0081BB 16 01            [ 2]  291 	ldw	y, (0x01, sp)
      0081BD 7B 04            [ 1]  292 	ld	a, (0x04, sp)
      0081BF 27 05            [ 1]  293 	jreq	00120$
      0081C1                        294 00119$:
      0081C1 90 57            [ 2]  295 	sraw	y
      0081C3 4A               [ 1]  296 	dec	a
      0081C4 26 FB            [ 1]  297 	jrne	00119$
      0081C6                        298 00120$:
      0081C6 90 9F            [ 1]  299 	ld	a, yl
      0081C8 A4 01            [ 1]  300 	and	a, #0x01
      0081CA AB 30            [ 1]  301 	add	a, #0x30
      0081CC F7               [ 1]  302 	ld	(x), a
                                    303 ;	main.c: 45: for(int i = 7; i >= 0; i--) {
      0081CD 1E 03            [ 2]  304 	ldw	x, (0x03, sp)
      0081CF 5A               [ 2]  305 	decw	x
      0081D0 1F 03            [ 2]  306 	ldw	(0x03, sp), x
      0081D2 20 DA            [ 2]  307 	jra	00103$
      0081D4                        308 00101$:
                                    309 ;	main.c: 49: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      0081D4 1E 07            [ 2]  310 	ldw	x, (0x07, sp)
      0081D6 6F 08            [ 1]  311 	clr	(0x0008, x)
                                    312 ;	main.c: 50: }
      0081D8 1E 05            [ 2]  313 	ldw	x, (5, sp)
      0081DA 5B 08            [ 2]  314 	addw	sp, #8
      0081DC FC               [ 2]  315 	jp	(x)
                                    316 ;	main.c: 52: void status_check(void){
                                    317 ;	-----------------------------------------
                                    318 ;	 function status_check
                                    319 ;	-----------------------------------------
      0081DD                        320 _status_check:
      0081DD 52 09            [ 2]  321 	sub	sp, #9
                                    322 ;	main.c: 53: char rx_binary_chars[9]={0};
      0081DF 0F 01            [ 1]  323 	clr	(0x01, sp)
      0081E1 0F 02            [ 1]  324 	clr	(0x02, sp)
      0081E3 0F 03            [ 1]  325 	clr	(0x03, sp)
      0081E5 0F 04            [ 1]  326 	clr	(0x04, sp)
      0081E7 0F 05            [ 1]  327 	clr	(0x05, sp)
      0081E9 0F 06            [ 1]  328 	clr	(0x06, sp)
      0081EB 0F 07            [ 1]  329 	clr	(0x07, sp)
      0081ED 0F 08            [ 1]  330 	clr	(0x08, sp)
      0081EF 0F 09            [ 1]  331 	clr	(0x09, sp)
                                    332 ;	main.c: 54: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0081F1 96               [ 1]  333 	ldw	x, sp
      0081F2 5C               [ 1]  334 	incw	x
      0081F3 51               [ 1]  335 	exgw	x, y
      0081F4 C6 52 17         [ 1]  336 	ld	a, 0x5217
      0081F7 5F               [ 1]  337 	clrw	x
      0081F8 90 89            [ 2]  338 	pushw	y
      0081FA 97               [ 1]  339 	ld	xl, a
      0081FB CD 81 A5         [ 4]  340 	call	_convert_int_to_binary
                                    341 ;	main.c: 55: uart_write("\nSR1 -> ");
      0081FE AE 80 2D         [ 2]  342 	ldw	x, #(___str_0+0)
      008201 CD 80 F0         [ 4]  343 	call	_uart_write
                                    344 ;	main.c: 56: uart_write(rx_binary_chars);
      008204 96               [ 1]  345 	ldw	x, sp
      008205 5C               [ 1]  346 	incw	x
      008206 CD 80 F0         [ 4]  347 	call	_uart_write
                                    348 ;	main.c: 57: uart_write(" <-\n");
      008209 AE 80 36         [ 2]  349 	ldw	x, #(___str_1+0)
      00820C CD 80 F0         [ 4]  350 	call	_uart_write
                                    351 ;	main.c: 58: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      00820F 96               [ 1]  352 	ldw	x, sp
      008210 5C               [ 1]  353 	incw	x
      008211 51               [ 1]  354 	exgw	x, y
      008212 C6 52 18         [ 1]  355 	ld	a, 0x5218
      008215 5F               [ 1]  356 	clrw	x
      008216 90 89            [ 2]  357 	pushw	y
      008218 97               [ 1]  358 	ld	xl, a
      008219 CD 81 A5         [ 4]  359 	call	_convert_int_to_binary
                                    360 ;	main.c: 59: uart_write("SR2 -> ");
      00821C AE 80 3B         [ 2]  361 	ldw	x, #(___str_2+0)
      00821F CD 80 F0         [ 4]  362 	call	_uart_write
                                    363 ;	main.c: 60: uart_write(rx_binary_chars);
      008222 96               [ 1]  364 	ldw	x, sp
      008223 5C               [ 1]  365 	incw	x
      008224 CD 80 F0         [ 4]  366 	call	_uart_write
                                    367 ;	main.c: 61: uart_write(" <-\n");
      008227 AE 80 36         [ 2]  368 	ldw	x, #(___str_1+0)
      00822A CD 80 F0         [ 4]  369 	call	_uart_write
                                    370 ;	main.c: 62: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      00822D 96               [ 1]  371 	ldw	x, sp
      00822E 5C               [ 1]  372 	incw	x
      00822F 51               [ 1]  373 	exgw	x, y
      008230 C6 52 19         [ 1]  374 	ld	a, 0x5219
      008233 5F               [ 1]  375 	clrw	x
      008234 90 89            [ 2]  376 	pushw	y
      008236 97               [ 1]  377 	ld	xl, a
      008237 CD 81 A5         [ 4]  378 	call	_convert_int_to_binary
                                    379 ;	main.c: 63: uart_write("SR3 -> ");
      00823A AE 80 43         [ 2]  380 	ldw	x, #(___str_3+0)
      00823D CD 80 F0         [ 4]  381 	call	_uart_write
                                    382 ;	main.c: 64: uart_write(rx_binary_chars);
      008240 96               [ 1]  383 	ldw	x, sp
      008241 5C               [ 1]  384 	incw	x
      008242 CD 80 F0         [ 4]  385 	call	_uart_write
                                    386 ;	main.c: 65: uart_write(" <-\n");
      008245 AE 80 36         [ 2]  387 	ldw	x, #(___str_1+0)
      008248 CD 80 F0         [ 4]  388 	call	_uart_write
                                    389 ;	main.c: 66: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      00824B 96               [ 1]  390 	ldw	x, sp
      00824C 5C               [ 1]  391 	incw	x
      00824D 51               [ 1]  392 	exgw	x, y
      00824E C6 52 10         [ 1]  393 	ld	a, 0x5210
      008251 5F               [ 1]  394 	clrw	x
      008252 90 89            [ 2]  395 	pushw	y
      008254 97               [ 1]  396 	ld	xl, a
      008255 CD 81 A5         [ 4]  397 	call	_convert_int_to_binary
                                    398 ;	main.c: 67: uart_write("CR1 -> ");
      008258 AE 80 4B         [ 2]  399 	ldw	x, #(___str_4+0)
      00825B CD 80 F0         [ 4]  400 	call	_uart_write
                                    401 ;	main.c: 68: uart_write(rx_binary_chars);
      00825E 96               [ 1]  402 	ldw	x, sp
      00825F 5C               [ 1]  403 	incw	x
      008260 CD 80 F0         [ 4]  404 	call	_uart_write
                                    405 ;	main.c: 69: uart_write(" <-\n");
      008263 AE 80 36         [ 2]  406 	ldw	x, #(___str_1+0)
      008266 CD 80 F0         [ 4]  407 	call	_uart_write
                                    408 ;	main.c: 70: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008269 96               [ 1]  409 	ldw	x, sp
      00826A 5C               [ 1]  410 	incw	x
      00826B 51               [ 1]  411 	exgw	x, y
      00826C C6 52 11         [ 1]  412 	ld	a, 0x5211
      00826F 5F               [ 1]  413 	clrw	x
      008270 90 89            [ 2]  414 	pushw	y
      008272 97               [ 1]  415 	ld	xl, a
      008273 CD 81 A5         [ 4]  416 	call	_convert_int_to_binary
                                    417 ;	main.c: 71: uart_write("CR2 -> ");
      008276 AE 80 53         [ 2]  418 	ldw	x, #(___str_5+0)
      008279 CD 80 F0         [ 4]  419 	call	_uart_write
                                    420 ;	main.c: 72: uart_write(rx_binary_chars);
      00827C 96               [ 1]  421 	ldw	x, sp
      00827D 5C               [ 1]  422 	incw	x
      00827E CD 80 F0         [ 4]  423 	call	_uart_write
                                    424 ;	main.c: 73: uart_write(" <-\n");
      008281 AE 80 36         [ 2]  425 	ldw	x, #(___str_1+0)
      008284 CD 80 F0         [ 4]  426 	call	_uart_write
                                    427 ;	main.c: 74: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008287 96               [ 1]  428 	ldw	x, sp
      008288 5C               [ 1]  429 	incw	x
      008289 51               [ 1]  430 	exgw	x, y
      00828A C6 52 16         [ 1]  431 	ld	a, 0x5216
      00828D 5F               [ 1]  432 	clrw	x
      00828E 90 89            [ 2]  433 	pushw	y
      008290 97               [ 1]  434 	ld	xl, a
      008291 CD 81 A5         [ 4]  435 	call	_convert_int_to_binary
                                    436 ;	main.c: 75: uart_write("DR -> ");
      008294 AE 80 5B         [ 2]  437 	ldw	x, #(___str_6+0)
      008297 CD 80 F0         [ 4]  438 	call	_uart_write
                                    439 ;	main.c: 76: uart_write(rx_binary_chars);
      00829A 96               [ 1]  440 	ldw	x, sp
      00829B 5C               [ 1]  441 	incw	x
      00829C CD 80 F0         [ 4]  442 	call	_uart_write
                                    443 ;	main.c: 77: uart_write(" <-\n");
      00829F AE 80 36         [ 2]  444 	ldw	x, #(___str_1+0)
      0082A2 CD 80 F0         [ 4]  445 	call	_uart_write
                                    446 ;	main.c: 78: }
      0082A5 5B 09            [ 2]  447 	addw	sp, #9
      0082A7 81               [ 4]  448 	ret
                                    449 ;	main.c: 80: void uart_init(void){
                                    450 ;	-----------------------------------------
                                    451 ;	 function uart_init
                                    452 ;	-----------------------------------------
      0082A8                        453 _uart_init:
                                    454 ;	main.c: 81: CLK_CKDIVR = 0;
      0082A8 35 00 50 C6      [ 1]  455 	mov	0x50c6+0, #0x00
                                    456 ;	main.c: 84: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0082AC 72 16 52 35      [ 1]  457 	bset	0x5235, #3
                                    458 ;	main.c: 86: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0082B0 C6 52 36         [ 1]  459 	ld	a, 0x5236
      0082B3 A4 CF            [ 1]  460 	and	a, #0xcf
      0082B5 C7 52 36         [ 1]  461 	ld	0x5236, a
                                    462 ;	main.c: 88: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0082B8 35 03 52 33      [ 1]  463 	mov	0x5233+0, #0x03
      0082BC 35 68 52 32      [ 1]  464 	mov	0x5232+0, #0x68
                                    465 ;	main.c: 89: }
      0082C0 81               [ 4]  466 	ret
                                    467 ;	main.c: 93: void i2c_init(void) {
                                    468 ;	-----------------------------------------
                                    469 ;	 function i2c_init
                                    470 ;	-----------------------------------------
      0082C1                        471 _i2c_init:
                                    472 ;	main.c: 99: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      0082C1 72 11 52 10      [ 1]  473 	bres	0x5210, #0
                                    474 ;	main.c: 100: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      0082C5 35 10 52 12      [ 1]  475 	mov	0x5212+0, #0x10
                                    476 ;	main.c: 101: I2C_CCRH = 0;                   // =0
      0082C9 35 00 52 1C      [ 1]  477 	mov	0x521c+0, #0x00
                                    478 ;	main.c: 102: I2C_CCRL = 80;                  // 100kHz for I2C
      0082CD 35 50 52 1B      [ 1]  479 	mov	0x521b+0, #0x50
                                    480 ;	main.c: 103: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0082D1 72 1F 52 1C      [ 1]  481 	bres	0x521c, #7
                                    482 ;	main.c: 104: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0082D5 72 1F 52 14      [ 1]  483 	bres	0x5214, #7
                                    484 ;	main.c: 105: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0082D9 72 1C 52 14      [ 1]  485 	bset	0x5214, #6
                                    486 ;	main.c: 106: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0082DD 72 10 52 10      [ 1]  487 	bset	0x5210, #0
                                    488 ;	main.c: 107: }
      0082E1 81               [ 4]  489 	ret
                                    490 ;	main.c: 111: void i2c_start(void) {
                                    491 ;	-----------------------------------------
                                    492 ;	 function i2c_start
                                    493 ;	-----------------------------------------
      0082E2                        494 _i2c_start:
                                    495 ;	main.c: 112: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0082E2 72 10 52 11      [ 1]  496 	bset	0x5211, #0
                                    497 ;	main.c: 113: while(!(I2C_SR1 & (1 << 0)));
      0082E6                        498 00101$:
      0082E6 C6 52 17         [ 1]  499 	ld	a, 0x5217
      0082E9 44               [ 1]  500 	srl	a
      0082EA 24 FA            [ 1]  501 	jrnc	00101$
                                    502 ;	main.c: 114: uart_write("Start generated\n"); // Ожидание отправки стартового сигнала
      0082EC AE 80 62         [ 2]  503 	ldw	x, #(___str_7+0)
                                    504 ;	main.c: 115: }
      0082EF CC 80 F0         [ 2]  505 	jp	_uart_write
                                    506 ;	main.c: 117: void i2c_send_address(uint8_t address) {
                                    507 ;	-----------------------------------------
                                    508 ;	 function i2c_send_address
                                    509 ;	-----------------------------------------
      0082F2                        510 _i2c_send_address:
                                    511 ;	main.c: 118: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0082F2 48               [ 1]  512 	sll	a
      0082F3 C7 52 16         [ 1]  513 	ld	0x5216, a
                                    514 ;	main.c: 119: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0082F6                        515 00102$:
      0082F6 C6 52 17         [ 1]  516 	ld	a, 0x5217
      0082F9 A5 02            [ 1]  517 	bcp	a, #0x02
      0082FB 26 07            [ 1]  518 	jrne	00104$
      0082FD C6 52 18         [ 1]  519 	ld	a, 0x5218
      008300 A5 04            [ 1]  520 	bcp	a, #0x04
      008302 27 F2            [ 1]  521 	jreq	00102$
      008304                        522 00104$:
                                    523 ;	main.c: 125: uart_write("Addr send\n"); // Ожидание подтверждения адреса
      008304 AE 80 73         [ 2]  524 	ldw	x, #(___str_8+0)
                                    525 ;	main.c: 126: }
      008307 CC 80 F0         [ 2]  526 	jp	_uart_write
                                    527 ;	main.c: 128: void i2c_stop(void) {
                                    528 ;	-----------------------------------------
                                    529 ;	 function i2c_stop
                                    530 ;	-----------------------------------------
      00830A                        531 _i2c_stop:
                                    532 ;	main.c: 129: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      00830A C6 52 11         [ 1]  533 	ld	a, 0x5211
      00830D AA 02            [ 1]  534 	or	a, #0x02
      00830F C7 52 11         [ 1]  535 	ld	0x5211, a
                                    536 ;	main.c: 130: uart_write("Stop generated\n");
      008312 AE 80 7E         [ 2]  537 	ldw	x, #(___str_9+0)
                                    538 ;	main.c: 131: }
      008315 CC 80 F0         [ 2]  539 	jp	_uart_write
                                    540 ;	main.c: 133: void i2c_scan(void) {
                                    541 ;	-----------------------------------------
                                    542 ;	 function i2c_scan
                                    543 ;	-----------------------------------------
      008318                        544 _i2c_scan:
      008318 52 05            [ 2]  545 	sub	sp, #5
                                    546 ;	main.c: 134: for (uint8_t addr = 1; addr < 127; addr++) {
      00831A A6 01            [ 1]  547 	ld	a, #0x01
      00831C 6B 05            [ 1]  548 	ld	(0x05, sp), a
      00831E                        549 00105$:
      00831E 7B 05            [ 1]  550 	ld	a, (0x05, sp)
      008320 A1 7F            [ 1]  551 	cp	a, #0x7f
      008322 24 38            [ 1]  552 	jrnc	00103$
                                    553 ;	main.c: 135: i2c_start();
      008324 CD 82 E2         [ 4]  554 	call	_i2c_start
                                    555 ;	main.c: 136: i2c_send_address(addr);
      008327 7B 05            [ 1]  556 	ld	a, (0x05, sp)
      008329 CD 82 F2         [ 4]  557 	call	_i2c_send_address
                                    558 ;	main.c: 137: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      00832C 72 04 52 18 17   [ 2]  559 	btjt	0x5218, #2, 00102$
                                    560 ;	main.c: 139: uart_write("Device found at: ");
      008331 AE 80 8E         [ 2]  561 	ldw	x, #(___str_10+0)
      008334 CD 80 F0         [ 4]  562 	call	_uart_write
                                    563 ;	main.c: 140: char rx_int_chars[4]={0};
      008337 0F 01            [ 1]  564 	clr	(0x01, sp)
      008339 0F 02            [ 1]  565 	clr	(0x02, sp)
      00833B 0F 03            [ 1]  566 	clr	(0x03, sp)
      00833D 0F 04            [ 1]  567 	clr	(0x04, sp)
                                    568 ;	main.c: 143: uart_write("\r\n");
      00833F AE 80 A0         [ 2]  569 	ldw	x, #(___str_11+0)
      008342 CD 80 F0         [ 4]  570 	call	_uart_write
                                    571 ;	main.c: 144: status_check();
      008345 CD 81 DD         [ 4]  572 	call	_status_check
      008348                        573 00102$:
                                    574 ;	main.c: 146: i2c_stop();
      008348 CD 83 0A         [ 4]  575 	call	_i2c_stop
                                    576 ;	main.c: 147: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      00834B 72 15 52 18      [ 1]  577 	bres	0x5218, #2
                                    578 ;	main.c: 148: delay(10000L); // Небольшая задержка для стабилизации шины
      00834F 4B 10            [ 1]  579 	push	#0x10
      008351 4B 27            [ 1]  580 	push	#0x27
      008353 5F               [ 1]  581 	clrw	x
      008354 89               [ 2]  582 	pushw	x
      008355 CD 80 C2         [ 4]  583 	call	_delay
                                    584 ;	main.c: 134: for (uint8_t addr = 1; addr < 127; addr++) {
      008358 0C 05            [ 1]  585 	inc	(0x05, sp)
      00835A 20 C2            [ 2]  586 	jra	00105$
      00835C                        587 00103$:
                                    588 ;	main.c: 150: uart_write("Devs Not Found");
      00835C AE 80 A3         [ 2]  589 	ldw	x, #(___str_12+0)
      00835F CD 80 F0         [ 4]  590 	call	_uart_write
                                    591 ;	main.c: 151: }
      008362 5B 05            [ 2]  592 	addw	sp, #5
      008364 81               [ 4]  593 	ret
                                    594 ;	main.c: 157: int main(void)
                                    595 ;	-----------------------------------------
                                    596 ;	 function main
                                    597 ;	-----------------------------------------
      008365                        598 _main:
                                    599 ;	main.c: 159: uart_init();
      008365 CD 82 A8         [ 4]  600 	call	_uart_init
                                    601 ;	main.c: 160: uart_write("Start Scanning\n");
      008368 AE 80 B2         [ 2]  602 	ldw	x, #(___str_13+0)
      00836B CD 80 F0         [ 4]  603 	call	_uart_write
                                    604 ;	main.c: 161: i2c_init();
      00836E CD 82 C1         [ 4]  605 	call	_i2c_init
                                    606 ;	main.c: 162: status_check();
      008371 CD 81 DD         [ 4]  607 	call	_status_check
                                    608 ;	main.c: 165: i2c_scan(); 
      008374 CD 83 18         [ 4]  609 	call	_i2c_scan
                                    610 ;	main.c: 167: return 0;
      008377 5F               [ 1]  611 	clrw	x
                                    612 ;	main.c: 168: }
      008378 81               [ 4]  613 	ret
                                    614 	.area CODE
                                    615 	.area CONST
                                    616 	.area CONST
      00802D                        617 ___str_0:
      00802D 0A                     618 	.db 0x0a
      00802E 53 52 31 20 2D 3E 20   619 	.ascii "SR1 -> "
      008035 00                     620 	.db 0x00
                                    621 	.area CODE
                                    622 	.area CONST
      008036                        623 ___str_1:
      008036 20 3C 2D               624 	.ascii " <-"
      008039 0A                     625 	.db 0x0a
      00803A 00                     626 	.db 0x00
                                    627 	.area CODE
                                    628 	.area CONST
      00803B                        629 ___str_2:
      00803B 53 52 32 20 2D 3E 20   630 	.ascii "SR2 -> "
      008042 00                     631 	.db 0x00
                                    632 	.area CODE
                                    633 	.area CONST
      008043                        634 ___str_3:
      008043 53 52 33 20 2D 3E 20   635 	.ascii "SR3 -> "
      00804A 00                     636 	.db 0x00
                                    637 	.area CODE
                                    638 	.area CONST
      00804B                        639 ___str_4:
      00804B 43 52 31 20 2D 3E 20   640 	.ascii "CR1 -> "
      008052 00                     641 	.db 0x00
                                    642 	.area CODE
                                    643 	.area CONST
      008053                        644 ___str_5:
      008053 43 52 32 20 2D 3E 20   645 	.ascii "CR2 -> "
      00805A 00                     646 	.db 0x00
                                    647 	.area CODE
                                    648 	.area CONST
      00805B                        649 ___str_6:
      00805B 44 52 20 2D 3E 20      650 	.ascii "DR -> "
      008061 00                     651 	.db 0x00
                                    652 	.area CODE
                                    653 	.area CONST
      008062                        654 ___str_7:
      008062 53 74 61 72 74 20 67   655 	.ascii "Start generated"
             65 6E 65 72 61 74 65
             64
      008071 0A                     656 	.db 0x0a
      008072 00                     657 	.db 0x00
                                    658 	.area CODE
                                    659 	.area CONST
      008073                        660 ___str_8:
      008073 41 64 64 72 20 73 65   661 	.ascii "Addr send"
             6E 64
      00807C 0A                     662 	.db 0x0a
      00807D 00                     663 	.db 0x00
                                    664 	.area CODE
                                    665 	.area CONST
      00807E                        666 ___str_9:
      00807E 53 74 6F 70 20 67 65   667 	.ascii "Stop generated"
             6E 65 72 61 74 65 64
      00808C 0A                     668 	.db 0x0a
      00808D 00                     669 	.db 0x00
                                    670 	.area CODE
                                    671 	.area CONST
      00808E                        672 ___str_10:
      00808E 44 65 76 69 63 65 20   673 	.ascii "Device found at: "
             66 6F 75 6E 64 20 61
             74 3A 20
      00809F 00                     674 	.db 0x00
                                    675 	.area CODE
                                    676 	.area CONST
      0080A0                        677 ___str_11:
      0080A0 0D                     678 	.db 0x0d
      0080A1 0A                     679 	.db 0x0a
      0080A2 00                     680 	.db 0x00
                                    681 	.area CODE
                                    682 	.area CONST
      0080A3                        683 ___str_12:
      0080A3 44 65 76 73 20 4E 6F   684 	.ascii "Devs Not Found"
             74 20 46 6F 75 6E 64
      0080B1 00                     685 	.db 0x00
                                    686 	.area CODE
                                    687 	.area CONST
      0080B2                        688 ___str_13:
      0080B2 53 74 61 72 74 20 53   689 	.ascii "Start Scanning"
             63 61 6E 6E 69 6E 67
      0080C0 0A                     690 	.db 0x0a
      0080C1 00                     691 	.db 0x00
                                    692 	.area CODE
                                    693 	.area INITIALIZER
                                    694 	.area CABS (ABS)
