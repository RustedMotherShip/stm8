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
      008007 CD 84 6F         [ 4]   72 	call	___sdcc_external_startup
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
      008021 D6 80 7F         [ 1]   88 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 84 58         [ 2]  102 	jp	_main
                                    103 ;	return from main will return to caller
                                    104 ;--------------------------------------------------------
                                    105 ; code
                                    106 ;--------------------------------------------------------
                                    107 	.area CODE
                                    108 ;	main.c: 8: void delay(unsigned long count) {
                                    109 ;	-----------------------------------------
                                    110 ;	 function delay
                                    111 ;	-----------------------------------------
      008181                        112 _delay:
      008181 52 08            [ 2]  113 	sub	sp, #8
                                    114 ;	main.c: 9: while (count--)
      008183 16 0D            [ 2]  115 	ldw	y, (0x0d, sp)
      008185 17 07            [ 2]  116 	ldw	(0x07, sp), y
      008187 1E 0B            [ 2]  117 	ldw	x, (0x0b, sp)
      008189                        118 00101$:
      008189 1F 01            [ 2]  119 	ldw	(0x01, sp), x
      00818B 7B 07            [ 1]  120 	ld	a, (0x07, sp)
      00818D 6B 03            [ 1]  121 	ld	(0x03, sp), a
      00818F 7B 08            [ 1]  122 	ld	a, (0x08, sp)
      008191 16 07            [ 2]  123 	ldw	y, (0x07, sp)
      008193 72 A2 00 01      [ 2]  124 	subw	y, #0x0001
      008197 17 07            [ 2]  125 	ldw	(0x07, sp), y
      008199 24 01            [ 1]  126 	jrnc	00117$
      00819B 5A               [ 2]  127 	decw	x
      00819C                        128 00117$:
      00819C 4D               [ 1]  129 	tnz	a
      00819D 26 08            [ 1]  130 	jrne	00118$
      00819F 16 02            [ 2]  131 	ldw	y, (0x02, sp)
      0081A1 26 04            [ 1]  132 	jrne	00118$
      0081A3 0D 01            [ 1]  133 	tnz	(0x01, sp)
      0081A5 27 03            [ 1]  134 	jreq	00104$
      0081A7                        135 00118$:
                                    136 ;	main.c: 10: nop();
      0081A7 9D               [ 1]  137 	nop
      0081A8 20 DF            [ 2]  138 	jra	00101$
      0081AA                        139 00104$:
                                    140 ;	main.c: 11: }
      0081AA 1E 09            [ 2]  141 	ldw	x, (9, sp)
      0081AC 5B 0E            [ 2]  142 	addw	sp, #14
      0081AE FC               [ 2]  143 	jp	(x)
                                    144 ;	main.c: 13: int uart_write(const char *str) {
                                    145 ;	-----------------------------------------
                                    146 ;	 function uart_write
                                    147 ;	-----------------------------------------
      0081AF                        148 _uart_write:
      0081AF 52 05            [ 2]  149 	sub	sp, #5
      0081B1 1F 03            [ 2]  150 	ldw	(0x03, sp), x
                                    151 ;	main.c: 15: for(i = 0; i < strlen(str); i++) {
      0081B3 0F 05            [ 1]  152 	clr	(0x05, sp)
      0081B5                        153 00106$:
      0081B5 1E 03            [ 2]  154 	ldw	x, (0x03, sp)
      0081B7 CD 84 71         [ 4]  155 	call	_strlen
      0081BA 1F 01            [ 2]  156 	ldw	(0x01, sp), x
      0081BC 5F               [ 1]  157 	clrw	x
      0081BD 7B 05            [ 1]  158 	ld	a, (0x05, sp)
      0081BF 97               [ 1]  159 	ld	xl, a
      0081C0 13 01            [ 2]  160 	cpw	x, (0x01, sp)
      0081C2 24 14            [ 1]  161 	jrnc	00104$
                                    162 ;	main.c: 16: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0081C4                        163 00101$:
      0081C4 C6 52 30         [ 1]  164 	ld	a, 0x5230
      0081C7 2A FB            [ 1]  165 	jrpl	00101$
                                    166 ;	main.c: 17: UART1_DR = str[i];
      0081C9 5F               [ 1]  167 	clrw	x
      0081CA 7B 05            [ 1]  168 	ld	a, (0x05, sp)
      0081CC 97               [ 1]  169 	ld	xl, a
      0081CD 72 FB 03         [ 2]  170 	addw	x, (0x03, sp)
      0081D0 F6               [ 1]  171 	ld	a, (x)
      0081D1 C7 52 31         [ 1]  172 	ld	0x5231, a
                                    173 ;	main.c: 15: for(i = 0; i < strlen(str); i++) {
      0081D4 0C 05            [ 1]  174 	inc	(0x05, sp)
      0081D6 20 DD            [ 2]  175 	jra	00106$
      0081D8                        176 00104$:
                                    177 ;	main.c: 19: return(i); // Bytes sent
      0081D8 7B 05            [ 1]  178 	ld	a, (0x05, sp)
      0081DA 5F               [ 1]  179 	clrw	x
      0081DB 97               [ 1]  180 	ld	xl, a
                                    181 ;	main.c: 20: }
      0081DC 5B 05            [ 2]  182 	addw	sp, #5
      0081DE 81               [ 4]  183 	ret
                                    184 ;	main.c: 24: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    185 ;	-----------------------------------------
                                    186 ;	 function convert_int_to_chars
                                    187 ;	-----------------------------------------
      0081DF                        188 _convert_int_to_chars:
      0081DF 52 0D            [ 2]  189 	sub	sp, #13
      0081E1 6B 0D            [ 1]  190 	ld	(0x0d, sp), a
      0081E3 1F 0B            [ 2]  191 	ldw	(0x0b, sp), x
                                    192 ;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
      0081E5 7B 0D            [ 1]  193 	ld	a, (0x0d, sp)
      0081E7 6B 02            [ 1]  194 	ld	(0x02, sp), a
      0081E9 0F 01            [ 1]  195 	clr	(0x01, sp)
                                    196 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      0081EB 1E 0B            [ 2]  197 	ldw	x, (0x0b, sp)
      0081ED 5C               [ 1]  198 	incw	x
      0081EE 1F 03            [ 2]  199 	ldw	(0x03, sp), x
                                    200 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      0081F0 1E 0B            [ 2]  201 	ldw	x, (0x0b, sp)
      0081F2 5C               [ 1]  202 	incw	x
      0081F3 5C               [ 1]  203 	incw	x
      0081F4 1F 05            [ 2]  204 	ldw	(0x05, sp), x
                                    205 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      0081F6 4B 0A            [ 1]  206 	push	#0x0a
      0081F8 4B 00            [ 1]  207 	push	#0x00
      0081FA 1E 03            [ 2]  208 	ldw	x, (0x03, sp)
                                    209 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      0081FC CD 84 96         [ 4]  210 	call	__divsint
      0081FF 1F 07            [ 2]  211 	ldw	(0x07, sp), x
      008201 4B 0A            [ 1]  212 	push	#0x0a
      008203 4B 00            [ 1]  213 	push	#0x00
      008205 1E 03            [ 2]  214 	ldw	x, (0x03, sp)
      008207 CD 84 7E         [ 4]  215 	call	__modsint
      00820A 9F               [ 1]  216 	ld	a, xl
      00820B AB 30            [ 1]  217 	add	a, #0x30
      00820D 6B 09            [ 1]  218 	ld	(0x09, sp), a
                                    219 ;	main.c: 25: if (num > 99) {
      00820F 7B 0D            [ 1]  220 	ld	a, (0x0d, sp)
      008211 A1 63            [ 1]  221 	cp	a, #0x63
      008213 23 29            [ 2]  222 	jrule	00105$
                                    223 ;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
      008215 4B 64            [ 1]  224 	push	#0x64
      008217 4B 00            [ 1]  225 	push	#0x00
      008219 1E 03            [ 2]  226 	ldw	x, (0x03, sp)
      00821B CD 84 96         [ 4]  227 	call	__divsint
      00821E 9F               [ 1]  228 	ld	a, xl
      00821F AB 30            [ 1]  229 	add	a, #0x30
      008221 1E 0B            [ 2]  230 	ldw	x, (0x0b, sp)
      008223 F7               [ 1]  231 	ld	(x), a
                                    232 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      008224 4B 0A            [ 1]  233 	push	#0x0a
      008226 4B 00            [ 1]  234 	push	#0x00
      008228 1E 09            [ 2]  235 	ldw	x, (0x09, sp)
      00822A CD 84 7E         [ 4]  236 	call	__modsint
      00822D 9F               [ 1]  237 	ld	a, xl
      00822E AB 30            [ 1]  238 	add	a, #0x30
      008230 1E 03            [ 2]  239 	ldw	x, (0x03, sp)
      008232 F7               [ 1]  240 	ld	(x), a
                                    241 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      008233 1E 05            [ 2]  242 	ldw	x, (0x05, sp)
      008235 7B 09            [ 1]  243 	ld	a, (0x09, sp)
      008237 F7               [ 1]  244 	ld	(x), a
                                    245 ;	main.c: 30: rx_int_chars[3] ='\0';
      008238 1E 0B            [ 2]  246 	ldw	x, (0x0b, sp)
      00823A 6F 03            [ 1]  247 	clr	(0x0003, x)
      00823C 20 23            [ 2]  248 	jra	00107$
      00823E                        249 00105$:
                                    250 ;	main.c: 32: } else if (num > 9) {
      00823E 7B 0D            [ 1]  251 	ld	a, (0x0d, sp)
      008240 A1 09            [ 1]  252 	cp	a, #0x09
      008242 23 13            [ 2]  253 	jrule	00102$
                                    254 ;	main.c: 34: rx_int_chars[0] = num / 10 + '0';
      008244 7B 08            [ 1]  255 	ld	a, (0x08, sp)
      008246 6B 0A            [ 1]  256 	ld	(0x0a, sp), a
      008248 AB 30            [ 1]  257 	add	a, #0x30
      00824A 1E 0B            [ 2]  258 	ldw	x, (0x0b, sp)
      00824C F7               [ 1]  259 	ld	(x), a
                                    260 ;	main.c: 35: rx_int_chars[1] = num % 10 + '0';
      00824D 1E 03            [ 2]  261 	ldw	x, (0x03, sp)
      00824F 7B 09            [ 1]  262 	ld	a, (0x09, sp)
      008251 F7               [ 1]  263 	ld	(x), a
                                    264 ;	main.c: 36: rx_int_chars[2] ='\0';
      008252 1E 05            [ 2]  265 	ldw	x, (0x05, sp)
      008254 7F               [ 1]  266 	clr	(x)
      008255 20 0A            [ 2]  267 	jra	00107$
      008257                        268 00102$:
                                    269 ;	main.c: 41: rx_int_chars[0] = num + '0';
      008257 7B 0D            [ 1]  270 	ld	a, (0x0d, sp)
      008259 AB 30            [ 1]  271 	add	a, #0x30
      00825B 1E 0B            [ 2]  272 	ldw	x, (0x0b, sp)
      00825D F7               [ 1]  273 	ld	(x), a
                                    274 ;	main.c: 42: rx_int_chars[1] ='\0';
      00825E 1E 03            [ 2]  275 	ldw	x, (0x03, sp)
      008260 7F               [ 1]  276 	clr	(x)
      008261                        277 00107$:
                                    278 ;	main.c: 44: }
      008261 5B 0D            [ 2]  279 	addw	sp, #13
      008263 81               [ 4]  280 	ret
                                    281 ;	main.c: 46: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    282 ;	-----------------------------------------
                                    283 ;	 function convert_int_to_binary
                                    284 ;	-----------------------------------------
      008264                        285 _convert_int_to_binary:
      008264 52 04            [ 2]  286 	sub	sp, #4
      008266 1F 01            [ 2]  287 	ldw	(0x01, sp), x
                                    288 ;	main.c: 48: for(int i = 7; i >= 0; i--) {
      008268 AE 00 07         [ 2]  289 	ldw	x, #0x0007
      00826B 1F 03            [ 2]  290 	ldw	(0x03, sp), x
      00826D                        291 00103$:
      00826D 0D 03            [ 1]  292 	tnz	(0x03, sp)
      00826F 2B 22            [ 1]  293 	jrmi	00101$
                                    294 ;	main.c: 50: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008271 AE 00 07         [ 2]  295 	ldw	x, #0x0007
      008274 72 F0 03         [ 2]  296 	subw	x, (0x03, sp)
      008277 72 FB 07         [ 2]  297 	addw	x, (0x07, sp)
      00827A 16 01            [ 2]  298 	ldw	y, (0x01, sp)
      00827C 7B 04            [ 1]  299 	ld	a, (0x04, sp)
      00827E 27 05            [ 1]  300 	jreq	00120$
      008280                        301 00119$:
      008280 90 57            [ 2]  302 	sraw	y
      008282 4A               [ 1]  303 	dec	a
      008283 26 FB            [ 1]  304 	jrne	00119$
      008285                        305 00120$:
      008285 90 9F            [ 1]  306 	ld	a, yl
      008287 A4 01            [ 1]  307 	and	a, #0x01
      008289 AB 30            [ 1]  308 	add	a, #0x30
      00828B F7               [ 1]  309 	ld	(x), a
                                    310 ;	main.c: 48: for(int i = 7; i >= 0; i--) {
      00828C 1E 03            [ 2]  311 	ldw	x, (0x03, sp)
      00828E 5A               [ 2]  312 	decw	x
      00828F 1F 03            [ 2]  313 	ldw	(0x03, sp), x
      008291 20 DA            [ 2]  314 	jra	00103$
      008293                        315 00101$:
                                    316 ;	main.c: 52: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008293 1E 07            [ 2]  317 	ldw	x, (0x07, sp)
      008295 6F 08            [ 1]  318 	clr	(0x0008, x)
                                    319 ;	main.c: 53: }
      008297 1E 05            [ 2]  320 	ldw	x, (5, sp)
      008299 5B 08            [ 2]  321 	addw	sp, #8
      00829B FC               [ 2]  322 	jp	(x)
                                    323 ;	main.c: 55: void status_check(void){
                                    324 ;	-----------------------------------------
                                    325 ;	 function status_check
                                    326 ;	-----------------------------------------
      00829C                        327 _status_check:
      00829C 52 09            [ 2]  328 	sub	sp, #9
                                    329 ;	main.c: 56: char rx_binary_chars[9]={0};
      00829E 0F 01            [ 1]  330 	clr	(0x01, sp)
      0082A0 0F 02            [ 1]  331 	clr	(0x02, sp)
      0082A2 0F 03            [ 1]  332 	clr	(0x03, sp)
      0082A4 0F 04            [ 1]  333 	clr	(0x04, sp)
      0082A6 0F 05            [ 1]  334 	clr	(0x05, sp)
      0082A8 0F 06            [ 1]  335 	clr	(0x06, sp)
      0082AA 0F 07            [ 1]  336 	clr	(0x07, sp)
      0082AC 0F 08            [ 1]  337 	clr	(0x08, sp)
      0082AE 0F 09            [ 1]  338 	clr	(0x09, sp)
                                    339 ;	main.c: 57: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0082B0 96               [ 1]  340 	ldw	x, sp
      0082B1 5C               [ 1]  341 	incw	x
      0082B2 51               [ 1]  342 	exgw	x, y
      0082B3 C6 52 17         [ 1]  343 	ld	a, 0x5217
      0082B6 5F               [ 1]  344 	clrw	x
      0082B7 90 89            [ 2]  345 	pushw	y
      0082B9 97               [ 1]  346 	ld	xl, a
      0082BA CD 82 64         [ 4]  347 	call	_convert_int_to_binary
                                    348 ;	main.c: 58: uart_write("\nSR1 -> ");
      0082BD AE 80 2D         [ 2]  349 	ldw	x, #(___str_0+0)
      0082C0 CD 81 AF         [ 4]  350 	call	_uart_write
                                    351 ;	main.c: 59: uart_write(rx_binary_chars);
      0082C3 96               [ 1]  352 	ldw	x, sp
      0082C4 5C               [ 1]  353 	incw	x
      0082C5 CD 81 AF         [ 4]  354 	call	_uart_write
                                    355 ;	main.c: 60: uart_write(" <-\n");
      0082C8 AE 80 36         [ 2]  356 	ldw	x, #(___str_1+0)
      0082CB CD 81 AF         [ 4]  357 	call	_uart_write
                                    358 ;	main.c: 61: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0082CE 96               [ 1]  359 	ldw	x, sp
      0082CF 5C               [ 1]  360 	incw	x
      0082D0 51               [ 1]  361 	exgw	x, y
      0082D1 C6 52 18         [ 1]  362 	ld	a, 0x5218
      0082D4 5F               [ 1]  363 	clrw	x
      0082D5 90 89            [ 2]  364 	pushw	y
      0082D7 97               [ 1]  365 	ld	xl, a
      0082D8 CD 82 64         [ 4]  366 	call	_convert_int_to_binary
                                    367 ;	main.c: 62: uart_write("SR2 -> ");
      0082DB AE 80 3B         [ 2]  368 	ldw	x, #(___str_2+0)
      0082DE CD 81 AF         [ 4]  369 	call	_uart_write
                                    370 ;	main.c: 63: uart_write(rx_binary_chars);
      0082E1 96               [ 1]  371 	ldw	x, sp
      0082E2 5C               [ 1]  372 	incw	x
      0082E3 CD 81 AF         [ 4]  373 	call	_uart_write
                                    374 ;	main.c: 64: uart_write(" <-\n");
      0082E6 AE 80 36         [ 2]  375 	ldw	x, #(___str_1+0)
      0082E9 CD 81 AF         [ 4]  376 	call	_uart_write
                                    377 ;	main.c: 65: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0082EC 96               [ 1]  378 	ldw	x, sp
      0082ED 5C               [ 1]  379 	incw	x
      0082EE 51               [ 1]  380 	exgw	x, y
      0082EF C6 52 19         [ 1]  381 	ld	a, 0x5219
      0082F2 5F               [ 1]  382 	clrw	x
      0082F3 90 89            [ 2]  383 	pushw	y
      0082F5 97               [ 1]  384 	ld	xl, a
      0082F6 CD 82 64         [ 4]  385 	call	_convert_int_to_binary
                                    386 ;	main.c: 66: uart_write("SR3 -> ");
      0082F9 AE 80 43         [ 2]  387 	ldw	x, #(___str_3+0)
      0082FC CD 81 AF         [ 4]  388 	call	_uart_write
                                    389 ;	main.c: 67: uart_write(rx_binary_chars);
      0082FF 96               [ 1]  390 	ldw	x, sp
      008300 5C               [ 1]  391 	incw	x
      008301 CD 81 AF         [ 4]  392 	call	_uart_write
                                    393 ;	main.c: 68: uart_write(" <-\n");
      008304 AE 80 36         [ 2]  394 	ldw	x, #(___str_1+0)
      008307 CD 81 AF         [ 4]  395 	call	_uart_write
                                    396 ;	main.c: 69: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      00830A 96               [ 1]  397 	ldw	x, sp
      00830B 5C               [ 1]  398 	incw	x
      00830C 51               [ 1]  399 	exgw	x, y
      00830D C6 52 10         [ 1]  400 	ld	a, 0x5210
      008310 5F               [ 1]  401 	clrw	x
      008311 90 89            [ 2]  402 	pushw	y
      008313 97               [ 1]  403 	ld	xl, a
      008314 CD 82 64         [ 4]  404 	call	_convert_int_to_binary
                                    405 ;	main.c: 70: uart_write("CR1 -> ");
      008317 AE 80 4B         [ 2]  406 	ldw	x, #(___str_4+0)
      00831A CD 81 AF         [ 4]  407 	call	_uart_write
                                    408 ;	main.c: 71: uart_write(rx_binary_chars);
      00831D 96               [ 1]  409 	ldw	x, sp
      00831E 5C               [ 1]  410 	incw	x
      00831F CD 81 AF         [ 4]  411 	call	_uart_write
                                    412 ;	main.c: 72: uart_write(" <-\n");
      008322 AE 80 36         [ 2]  413 	ldw	x, #(___str_1+0)
      008325 CD 81 AF         [ 4]  414 	call	_uart_write
                                    415 ;	main.c: 73: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008328 96               [ 1]  416 	ldw	x, sp
      008329 5C               [ 1]  417 	incw	x
      00832A 51               [ 1]  418 	exgw	x, y
      00832B C6 52 11         [ 1]  419 	ld	a, 0x5211
      00832E 5F               [ 1]  420 	clrw	x
      00832F 90 89            [ 2]  421 	pushw	y
      008331 97               [ 1]  422 	ld	xl, a
      008332 CD 82 64         [ 4]  423 	call	_convert_int_to_binary
                                    424 ;	main.c: 74: uart_write("CR2 -> ");
      008335 AE 80 53         [ 2]  425 	ldw	x, #(___str_5+0)
      008338 CD 81 AF         [ 4]  426 	call	_uart_write
                                    427 ;	main.c: 75: uart_write(rx_binary_chars);
      00833B 96               [ 1]  428 	ldw	x, sp
      00833C 5C               [ 1]  429 	incw	x
      00833D CD 81 AF         [ 4]  430 	call	_uart_write
                                    431 ;	main.c: 76: uart_write(" <-\n");
      008340 AE 80 36         [ 2]  432 	ldw	x, #(___str_1+0)
      008343 CD 81 AF         [ 4]  433 	call	_uart_write
                                    434 ;	main.c: 77: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008346 96               [ 1]  435 	ldw	x, sp
      008347 5C               [ 1]  436 	incw	x
      008348 51               [ 1]  437 	exgw	x, y
      008349 C6 52 16         [ 1]  438 	ld	a, 0x5216
      00834C 5F               [ 1]  439 	clrw	x
      00834D 90 89            [ 2]  440 	pushw	y
      00834F 97               [ 1]  441 	ld	xl, a
      008350 CD 82 64         [ 4]  442 	call	_convert_int_to_binary
                                    443 ;	main.c: 78: uart_write("DR -> ");
      008353 AE 80 5B         [ 2]  444 	ldw	x, #(___str_6+0)
      008356 CD 81 AF         [ 4]  445 	call	_uart_write
                                    446 ;	main.c: 79: uart_write(rx_binary_chars);
      008359 96               [ 1]  447 	ldw	x, sp
      00835A 5C               [ 1]  448 	incw	x
      00835B CD 81 AF         [ 4]  449 	call	_uart_write
                                    450 ;	main.c: 80: uart_write(" <-\n");
      00835E AE 80 36         [ 2]  451 	ldw	x, #(___str_1+0)
      008361 CD 81 AF         [ 4]  452 	call	_uart_write
                                    453 ;	main.c: 81: }
      008364 5B 09            [ 2]  454 	addw	sp, #9
      008366 81               [ 4]  455 	ret
                                    456 ;	main.c: 83: void uart_init(void){
                                    457 ;	-----------------------------------------
                                    458 ;	 function uart_init
                                    459 ;	-----------------------------------------
      008367                        460 _uart_init:
                                    461 ;	main.c: 84: CLK_CKDIVR = 0;
      008367 35 00 50 C6      [ 1]  462 	mov	0x50c6+0, #0x00
                                    463 ;	main.c: 87: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00836B 72 16 52 35      [ 1]  464 	bset	0x5235, #3
                                    465 ;	main.c: 88: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      00836F 72 14 52 35      [ 1]  466 	bset	0x5235, #2
                                    467 ;	main.c: 89: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008373 C6 52 36         [ 1]  468 	ld	a, 0x5236
      008376 A4 CF            [ 1]  469 	and	a, #0xcf
      008378 C7 52 36         [ 1]  470 	ld	0x5236, a
                                    471 ;	main.c: 91: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      00837B 35 03 52 33      [ 1]  472 	mov	0x5233+0, #0x03
      00837F 35 68 52 32      [ 1]  473 	mov	0x5232+0, #0x68
                                    474 ;	main.c: 92: }
      008383 81               [ 4]  475 	ret
                                    476 ;	main.c: 96: void i2c_init(void) {
                                    477 ;	-----------------------------------------
                                    478 ;	 function i2c_init
                                    479 ;	-----------------------------------------
      008384                        480 _i2c_init:
                                    481 ;	main.c: 102: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008384 72 11 52 10      [ 1]  482 	bres	0x5210, #0
                                    483 ;	main.c: 103: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008388 35 10 52 12      [ 1]  484 	mov	0x5212+0, #0x10
                                    485 ;	main.c: 104: I2C_CCRH = 0;                   // =0
      00838C 35 00 52 1C      [ 1]  486 	mov	0x521c+0, #0x00
                                    487 ;	main.c: 105: I2C_CCRL = 80;                  // 100kHz for I2C
      008390 35 50 52 1B      [ 1]  488 	mov	0x521b+0, #0x50
                                    489 ;	main.c: 106: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      008394 72 1F 52 1C      [ 1]  490 	bres	0x521c, #7
                                    491 ;	main.c: 107: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      008398 72 1F 52 14      [ 1]  492 	bres	0x5214, #7
                                    493 ;	main.c: 108: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      00839C 72 1C 52 14      [ 1]  494 	bset	0x5214, #6
                                    495 ;	main.c: 109: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0083A0 72 10 52 10      [ 1]  496 	bset	0x5210, #0
                                    497 ;	main.c: 110: }
      0083A4 81               [ 4]  498 	ret
                                    499 ;	main.c: 114: void i2c_start(void) {
                                    500 ;	-----------------------------------------
                                    501 ;	 function i2c_start
                                    502 ;	-----------------------------------------
      0083A5                        503 _i2c_start:
                                    504 ;	main.c: 115: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0083A5 72 10 52 11      [ 1]  505 	bset	0x5211, #0
                                    506 ;	main.c: 116: while(!(I2C_SR1 & (1 << 0)));
      0083A9                        507 00101$:
      0083A9 72 01 52 17 FB   [ 2]  508 	btjf	0x5217, #0, 00101$
                                    509 ;	main.c: 118: }
      0083AE 81               [ 4]  510 	ret
                                    511 ;	main.c: 120: void i2c_send_address(uint8_t address) {
                                    512 ;	-----------------------------------------
                                    513 ;	 function i2c_send_address
                                    514 ;	-----------------------------------------
      0083AF                        515 _i2c_send_address:
                                    516 ;	main.c: 121: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0083AF 48               [ 1]  517 	sll	a
      0083B0 C7 52 16         [ 1]  518 	ld	0x5216, a
                                    519 ;	main.c: 122: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0083B3                        520 00102$:
      0083B3 72 03 52 17 01   [ 2]  521 	btjf	0x5217, #1, 00117$
      0083B8 81               [ 4]  522 	ret
      0083B9                        523 00117$:
      0083B9 72 05 52 18 F5   [ 2]  524 	btjf	0x5218, #2, 00102$
                                    525 ;	main.c: 123: }
      0083BE 81               [ 4]  526 	ret
                                    527 ;	main.c: 125: void i2c_stop(void) {
                                    528 ;	-----------------------------------------
                                    529 ;	 function i2c_stop
                                    530 ;	-----------------------------------------
      0083BF                        531 _i2c_stop:
                                    532 ;	main.c: 126: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      0083BF 72 12 52 11      [ 1]  533 	bset	0x5211, #1
                                    534 ;	main.c: 128: }
      0083C3 81               [ 4]  535 	ret
                                    536 ;	main.c: 132: void i2c_scan(void) {
                                    537 ;	-----------------------------------------
                                    538 ;	 function i2c_scan
                                    539 ;	-----------------------------------------
      0083C4                        540 _i2c_scan:
      0083C4 52 05            [ 2]  541 	sub	sp, #5
                                    542 ;	main.c: 133: for (uint8_t addr = 1; addr < 127; addr++) {
      0083C6 A6 01            [ 1]  543 	ld	a, #0x01
      0083C8 6B 05            [ 1]  544 	ld	(0x05, sp), a
      0083CA                        545 00105$:
      0083CA 7B 05            [ 1]  546 	ld	a, (0x05, sp)
      0083CC A1 7F            [ 1]  547 	cp	a, #0x7f
      0083CE 24 40            [ 1]  548 	jrnc	00107$
                                    549 ;	main.c: 134: i2c_start();
      0083D0 CD 83 A5         [ 4]  550 	call	_i2c_start
                                    551 ;	main.c: 135: i2c_send_address(addr);
      0083D3 7B 05            [ 1]  552 	ld	a, (0x05, sp)
      0083D5 CD 83 AF         [ 4]  553 	call	_i2c_send_address
                                    554 ;	main.c: 136: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0083D8 72 04 52 18 28   [ 2]  555 	btjt	0x5218, #2, 00102$
                                    556 ;	main.c: 138: uart_write("SM ");
      0083DD AE 80 62         [ 2]  557 	ldw	x, #(___str_7+0)
      0083E0 CD 81 AF         [ 4]  558 	call	_uart_write
                                    559 ;	main.c: 139: char rx_int_chars[4]={0};
      0083E3 0F 01            [ 1]  560 	clr	(0x01, sp)
      0083E5 0F 02            [ 1]  561 	clr	(0x02, sp)
      0083E7 0F 03            [ 1]  562 	clr	(0x03, sp)
      0083E9 0F 04            [ 1]  563 	clr	(0x04, sp)
                                    564 ;	main.c: 140: convert_int_to_chars(addr, rx_int_chars);
      0083EB 96               [ 1]  565 	ldw	x, sp
      0083EC 5C               [ 1]  566 	incw	x
      0083ED 7B 05            [ 1]  567 	ld	a, (0x05, sp)
      0083EF CD 81 DF         [ 4]  568 	call	_convert_int_to_chars
                                    569 ;	main.c: 141: uart_write(rx_int_chars); 
      0083F2 96               [ 1]  570 	ldw	x, sp
      0083F3 5C               [ 1]  571 	incw	x
      0083F4 CD 81 AF         [ 4]  572 	call	_uart_write
                                    573 ;	main.c: 142: uart_write("\r\n");
      0083F7 AE 80 66         [ 2]  574 	ldw	x, #(___str_8+0)
      0083FA CD 81 AF         [ 4]  575 	call	_uart_write
                                    576 ;	main.c: 143: current_dev = addr;
      0083FD 7B 05            [ 1]  577 	ld	a, (0x05, sp)
      0083FF C7 01 01         [ 1]  578 	ld	_current_dev+0, a
                                    579 ;	main.c: 144: status_check();
      008402 CD 82 9C         [ 4]  580 	call	_status_check
      008405                        581 00102$:
                                    582 ;	main.c: 146: i2c_stop();
      008405 CD 83 BF         [ 4]  583 	call	_i2c_stop
                                    584 ;	main.c: 147: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      008408 72 15 52 18      [ 1]  585 	bres	0x5218, #2
                                    586 ;	main.c: 133: for (uint8_t addr = 1; addr < 127; addr++) {
      00840C 0C 05            [ 1]  587 	inc	(0x05, sp)
      00840E 20 BA            [ 2]  588 	jra	00105$
      008410                        589 00107$:
                                    590 ;	main.c: 151: }
      008410 5B 05            [ 2]  591 	addw	sp, #5
      008412 81               [ 4]  592 	ret
                                    593 ;	main.c: 154: int uart_read(void)
                                    594 ;	-----------------------------------------
                                    595 ;	 function uart_read
                                    596 ;	-----------------------------------------
      008413                        597 _uart_read:
                                    598 ;	main.c: 156: for(int i = 0; i < sizeof(buffer); i++)
      008413 5F               [ 1]  599 	clrw	x
      008414                        600 00109$:
      008414 A3 01 00         [ 2]  601 	cpw	x, #0x0100
      008417 2E 09            [ 1]  602 	jrsge	00101$
                                    603 ;	main.c: 158: buffer[i] = 0;
      008419 90 93            [ 1]  604 	ldw	y, x
      00841B 90 4F 00 01      [ 1]  605 	clr	((_buffer+0), y)
                                    606 ;	main.c: 156: for(int i = 0; i < sizeof(buffer); i++)
      00841F 5C               [ 1]  607 	incw	x
      008420 20 F2            [ 2]  608 	jra	00109$
      008422                        609 00101$:
                                    610 ;	main.c: 160: for(int i = 0; i < sizeof(buffer); i++) {
      008422 5F               [ 1]  611 	clrw	x
      008423                        612 00112$:
      008423 A3 01 00         [ 2]  613 	cpw	x, #0x0100
      008426 2E 2B            [ 1]  614 	jrsge	00107$
                                    615 ;	main.c: 161: uart_write("flag1");
      008428 89               [ 2]  616 	pushw	x
      008429 AE 80 69         [ 2]  617 	ldw	x, #(___str_9+0)
      00842C CD 81 AF         [ 4]  618 	call	_uart_write
      00842F 85               [ 2]  619 	popw	x
                                    620 ;	main.c: 162: while(!(UART1_SR & UART_SR_RXNE)); // !Transmit data register empty
      008430                        621 00102$:
      008430 72 0B 52 30 FB   [ 2]  622 	btjf	0x5230, #5, 00102$
                                    623 ;	main.c: 163: uart_write("flag2");
      008435 89               [ 2]  624 	pushw	x
      008436 AE 80 6F         [ 2]  625 	ldw	x, #(___str_10+0)
      008439 CD 81 AF         [ 4]  626 	call	_uart_write
      00843C 85               [ 2]  627 	popw	x
                                    628 ;	main.c: 164: buffer[i] = UART1_DR;
      00843D C6 52 31         [ 1]  629 	ld	a, 0x5231
      008440 D7 00 01         [ 1]  630 	ld	((_buffer+0), x), a
                                    631 ;	main.c: 165: if(buffer[i] == '\n')
      008443 A1 0A            [ 1]  632 	cp	a, #0x0a
      008445 26 09            [ 1]  633 	jrne	00113$
                                    634 ;	main.c: 167: uart_write("flag_S");
      008447 AE 80 75         [ 2]  635 	ldw	x, #(___str_11+0)
      00844A CD 81 AF         [ 4]  636 	call	_uart_write
                                    637 ;	main.c: 168: return 1;
      00844D 5F               [ 1]  638 	clrw	x
      00844E 5C               [ 1]  639 	incw	x
      00844F 81               [ 4]  640 	ret
      008450                        641 00113$:
                                    642 ;	main.c: 160: for(int i = 0; i < sizeof(buffer); i++) {
      008450 5C               [ 1]  643 	incw	x
      008451 20 D0            [ 2]  644 	jra	00112$
      008453                        645 00107$:
                                    646 ;	main.c: 172: status_check();
      008453 CD 82 9C         [ 4]  647 	call	_status_check
                                    648 ;	main.c: 173: return 0;
      008456 5F               [ 1]  649 	clrw	x
                                    650 ;	main.c: 174: }
      008457 81               [ 4]  651 	ret
                                    652 ;	main.c: 177: int main(void)
                                    653 ;	-----------------------------------------
                                    654 ;	 function main
                                    655 ;	-----------------------------------------
      008458                        656 _main:
                                    657 ;	main.c: 179: uart_init();
      008458 CD 83 67         [ 4]  658 	call	_uart_init
                                    659 ;	main.c: 180: uart_write("SS\n");
      00845B AE 80 7C         [ 2]  660 	ldw	x, #(___str_12+0)
      00845E CD 81 AF         [ 4]  661 	call	_uart_write
                                    662 ;	main.c: 182: while(uart_read()); 
      008461                        663 00101$:
      008461 CD 84 13         [ 4]  664 	call	_uart_read
      008464 5D               [ 2]  665 	tnzw	x
      008465 26 FA            [ 1]  666 	jrne	00101$
                                    667 ;	main.c: 183: i2c_init();
      008467 CD 83 84         [ 4]  668 	call	_i2c_init
                                    669 ;	main.c: 187: i2c_scan(); 
      00846A CD 83 C4         [ 4]  670 	call	_i2c_scan
                                    671 ;	main.c: 189: return 0;
      00846D 5F               [ 1]  672 	clrw	x
                                    673 ;	main.c: 190: }
      00846E 81               [ 4]  674 	ret
                                    675 	.area CODE
                                    676 	.area CONST
                                    677 	.area CONST
      00802D                        678 ___str_0:
      00802D 0A                     679 	.db 0x0a
      00802E 53 52 31 20 2D 3E 20   680 	.ascii "SR1 -> "
      008035 00                     681 	.db 0x00
                                    682 	.area CODE
                                    683 	.area CONST
      008036                        684 ___str_1:
      008036 20 3C 2D               685 	.ascii " <-"
      008039 0A                     686 	.db 0x0a
      00803A 00                     687 	.db 0x00
                                    688 	.area CODE
                                    689 	.area CONST
      00803B                        690 ___str_2:
      00803B 53 52 32 20 2D 3E 20   691 	.ascii "SR2 -> "
      008042 00                     692 	.db 0x00
                                    693 	.area CODE
                                    694 	.area CONST
      008043                        695 ___str_3:
      008043 53 52 33 20 2D 3E 20   696 	.ascii "SR3 -> "
      00804A 00                     697 	.db 0x00
                                    698 	.area CODE
                                    699 	.area CONST
      00804B                        700 ___str_4:
      00804B 43 52 31 20 2D 3E 20   701 	.ascii "CR1 -> "
      008052 00                     702 	.db 0x00
                                    703 	.area CODE
                                    704 	.area CONST
      008053                        705 ___str_5:
      008053 43 52 32 20 2D 3E 20   706 	.ascii "CR2 -> "
      00805A 00                     707 	.db 0x00
                                    708 	.area CODE
                                    709 	.area CONST
      00805B                        710 ___str_6:
      00805B 44 52 20 2D 3E 20      711 	.ascii "DR -> "
      008061 00                     712 	.db 0x00
                                    713 	.area CODE
                                    714 	.area CONST
      008062                        715 ___str_7:
      008062 53 4D 20               716 	.ascii "SM "
      008065 00                     717 	.db 0x00
                                    718 	.area CODE
                                    719 	.area CONST
      008066                        720 ___str_8:
      008066 0D                     721 	.db 0x0d
      008067 0A                     722 	.db 0x0a
      008068 00                     723 	.db 0x00
                                    724 	.area CODE
                                    725 	.area CONST
      008069                        726 ___str_9:
      008069 66 6C 61 67 31         727 	.ascii "flag1"
      00806E 00                     728 	.db 0x00
                                    729 	.area CODE
                                    730 	.area CONST
      00806F                        731 ___str_10:
      00806F 66 6C 61 67 32         732 	.ascii "flag2"
      008074 00                     733 	.db 0x00
                                    734 	.area CODE
                                    735 	.area CONST
      008075                        736 ___str_11:
      008075 66 6C 61 67 5F 53      737 	.ascii "flag_S"
      00807B 00                     738 	.db 0x00
                                    739 	.area CODE
                                    740 	.area CONST
      00807C                        741 ___str_12:
      00807C 53 53                  742 	.ascii "SS"
      00807E 0A                     743 	.db 0x0a
      00807F 00                     744 	.db 0x00
                                    745 	.area CODE
                                    746 	.area INITIALIZER
      008080                        747 __xinit__buffer:
      008080 00                     748 	.db #0x00	; 0
      008081 00                     749 	.db 0x00
      008082 00                     750 	.db 0x00
      008083 00                     751 	.db 0x00
      008084 00                     752 	.db 0x00
      008085 00                     753 	.db 0x00
      008086 00                     754 	.db 0x00
      008087 00                     755 	.db 0x00
      008088 00                     756 	.db 0x00
      008089 00                     757 	.db 0x00
      00808A 00                     758 	.db 0x00
      00808B 00                     759 	.db 0x00
      00808C 00                     760 	.db 0x00
      00808D 00                     761 	.db 0x00
      00808E 00                     762 	.db 0x00
      00808F 00                     763 	.db 0x00
      008090 00                     764 	.db 0x00
      008091 00                     765 	.db 0x00
      008092 00                     766 	.db 0x00
      008093 00                     767 	.db 0x00
      008094 00                     768 	.db 0x00
      008095 00                     769 	.db 0x00
      008096 00                     770 	.db 0x00
      008097 00                     771 	.db 0x00
      008098 00                     772 	.db 0x00
      008099 00                     773 	.db 0x00
      00809A 00                     774 	.db 0x00
      00809B 00                     775 	.db 0x00
      00809C 00                     776 	.db 0x00
      00809D 00                     777 	.db 0x00
      00809E 00                     778 	.db 0x00
      00809F 00                     779 	.db 0x00
      0080A0 00                     780 	.db 0x00
      0080A1 00                     781 	.db 0x00
      0080A2 00                     782 	.db 0x00
      0080A3 00                     783 	.db 0x00
      0080A4 00                     784 	.db 0x00
      0080A5 00                     785 	.db 0x00
      0080A6 00                     786 	.db 0x00
      0080A7 00                     787 	.db 0x00
      0080A8 00                     788 	.db 0x00
      0080A9 00                     789 	.db 0x00
      0080AA 00                     790 	.db 0x00
      0080AB 00                     791 	.db 0x00
      0080AC 00                     792 	.db 0x00
      0080AD 00                     793 	.db 0x00
      0080AE 00                     794 	.db 0x00
      0080AF 00                     795 	.db 0x00
      0080B0 00                     796 	.db 0x00
      0080B1 00                     797 	.db 0x00
      0080B2 00                     798 	.db 0x00
      0080B3 00                     799 	.db 0x00
      0080B4 00                     800 	.db 0x00
      0080B5 00                     801 	.db 0x00
      0080B6 00                     802 	.db 0x00
      0080B7 00                     803 	.db 0x00
      0080B8 00                     804 	.db 0x00
      0080B9 00                     805 	.db 0x00
      0080BA 00                     806 	.db 0x00
      0080BB 00                     807 	.db 0x00
      0080BC 00                     808 	.db 0x00
      0080BD 00                     809 	.db 0x00
      0080BE 00                     810 	.db 0x00
      0080BF 00                     811 	.db 0x00
      0080C0 00                     812 	.db 0x00
      0080C1 00                     813 	.db 0x00
      0080C2 00                     814 	.db 0x00
      0080C3 00                     815 	.db 0x00
      0080C4 00                     816 	.db 0x00
      0080C5 00                     817 	.db 0x00
      0080C6 00                     818 	.db 0x00
      0080C7 00                     819 	.db 0x00
      0080C8 00                     820 	.db 0x00
      0080C9 00                     821 	.db 0x00
      0080CA 00                     822 	.db 0x00
      0080CB 00                     823 	.db 0x00
      0080CC 00                     824 	.db 0x00
      0080CD 00                     825 	.db 0x00
      0080CE 00                     826 	.db 0x00
      0080CF 00                     827 	.db 0x00
      0080D0 00                     828 	.db 0x00
      0080D1 00                     829 	.db 0x00
      0080D2 00                     830 	.db 0x00
      0080D3 00                     831 	.db 0x00
      0080D4 00                     832 	.db 0x00
      0080D5 00                     833 	.db 0x00
      0080D6 00                     834 	.db 0x00
      0080D7 00                     835 	.db 0x00
      0080D8 00                     836 	.db 0x00
      0080D9 00                     837 	.db 0x00
      0080DA 00                     838 	.db 0x00
      0080DB 00                     839 	.db 0x00
      0080DC 00                     840 	.db 0x00
      0080DD 00                     841 	.db 0x00
      0080DE 00                     842 	.db 0x00
      0080DF 00                     843 	.db 0x00
      0080E0 00                     844 	.db 0x00
      0080E1 00                     845 	.db 0x00
      0080E2 00                     846 	.db 0x00
      0080E3 00                     847 	.db 0x00
      0080E4 00                     848 	.db 0x00
      0080E5 00                     849 	.db 0x00
      0080E6 00                     850 	.db 0x00
      0080E7 00                     851 	.db 0x00
      0080E8 00                     852 	.db 0x00
      0080E9 00                     853 	.db 0x00
      0080EA 00                     854 	.db 0x00
      0080EB 00                     855 	.db 0x00
      0080EC 00                     856 	.db 0x00
      0080ED 00                     857 	.db 0x00
      0080EE 00                     858 	.db 0x00
      0080EF 00                     859 	.db 0x00
      0080F0 00                     860 	.db 0x00
      0080F1 00                     861 	.db 0x00
      0080F2 00                     862 	.db 0x00
      0080F3 00                     863 	.db 0x00
      0080F4 00                     864 	.db 0x00
      0080F5 00                     865 	.db 0x00
      0080F6 00                     866 	.db 0x00
      0080F7 00                     867 	.db 0x00
      0080F8 00                     868 	.db 0x00
      0080F9 00                     869 	.db 0x00
      0080FA 00                     870 	.db 0x00
      0080FB 00                     871 	.db 0x00
      0080FC 00                     872 	.db 0x00
      0080FD 00                     873 	.db 0x00
      0080FE 00                     874 	.db 0x00
      0080FF 00                     875 	.db 0x00
      008100 00                     876 	.db 0x00
      008101 00                     877 	.db 0x00
      008102 00                     878 	.db 0x00
      008103 00                     879 	.db 0x00
      008104 00                     880 	.db 0x00
      008105 00                     881 	.db 0x00
      008106 00                     882 	.db 0x00
      008107 00                     883 	.db 0x00
      008108 00                     884 	.db 0x00
      008109 00                     885 	.db 0x00
      00810A 00                     886 	.db 0x00
      00810B 00                     887 	.db 0x00
      00810C 00                     888 	.db 0x00
      00810D 00                     889 	.db 0x00
      00810E 00                     890 	.db 0x00
      00810F 00                     891 	.db 0x00
      008110 00                     892 	.db 0x00
      008111 00                     893 	.db 0x00
      008112 00                     894 	.db 0x00
      008113 00                     895 	.db 0x00
      008114 00                     896 	.db 0x00
      008115 00                     897 	.db 0x00
      008116 00                     898 	.db 0x00
      008117 00                     899 	.db 0x00
      008118 00                     900 	.db 0x00
      008119 00                     901 	.db 0x00
      00811A 00                     902 	.db 0x00
      00811B 00                     903 	.db 0x00
      00811C 00                     904 	.db 0x00
      00811D 00                     905 	.db 0x00
      00811E 00                     906 	.db 0x00
      00811F 00                     907 	.db 0x00
      008120 00                     908 	.db 0x00
      008121 00                     909 	.db 0x00
      008122 00                     910 	.db 0x00
      008123 00                     911 	.db 0x00
      008124 00                     912 	.db 0x00
      008125 00                     913 	.db 0x00
      008126 00                     914 	.db 0x00
      008127 00                     915 	.db 0x00
      008128 00                     916 	.db 0x00
      008129 00                     917 	.db 0x00
      00812A 00                     918 	.db 0x00
      00812B 00                     919 	.db 0x00
      00812C 00                     920 	.db 0x00
      00812D 00                     921 	.db 0x00
      00812E 00                     922 	.db 0x00
      00812F 00                     923 	.db 0x00
      008130 00                     924 	.db 0x00
      008131 00                     925 	.db 0x00
      008132 00                     926 	.db 0x00
      008133 00                     927 	.db 0x00
      008134 00                     928 	.db 0x00
      008135 00                     929 	.db 0x00
      008136 00                     930 	.db 0x00
      008137 00                     931 	.db 0x00
      008138 00                     932 	.db 0x00
      008139 00                     933 	.db 0x00
      00813A 00                     934 	.db 0x00
      00813B 00                     935 	.db 0x00
      00813C 00                     936 	.db 0x00
      00813D 00                     937 	.db 0x00
      00813E 00                     938 	.db 0x00
      00813F 00                     939 	.db 0x00
      008140 00                     940 	.db 0x00
      008141 00                     941 	.db 0x00
      008142 00                     942 	.db 0x00
      008143 00                     943 	.db 0x00
      008144 00                     944 	.db 0x00
      008145 00                     945 	.db 0x00
      008146 00                     946 	.db 0x00
      008147 00                     947 	.db 0x00
      008148 00                     948 	.db 0x00
      008149 00                     949 	.db 0x00
      00814A 00                     950 	.db 0x00
      00814B 00                     951 	.db 0x00
      00814C 00                     952 	.db 0x00
      00814D 00                     953 	.db 0x00
      00814E 00                     954 	.db 0x00
      00814F 00                     955 	.db 0x00
      008150 00                     956 	.db 0x00
      008151 00                     957 	.db 0x00
      008152 00                     958 	.db 0x00
      008153 00                     959 	.db 0x00
      008154 00                     960 	.db 0x00
      008155 00                     961 	.db 0x00
      008156 00                     962 	.db 0x00
      008157 00                     963 	.db 0x00
      008158 00                     964 	.db 0x00
      008159 00                     965 	.db 0x00
      00815A 00                     966 	.db 0x00
      00815B 00                     967 	.db 0x00
      00815C 00                     968 	.db 0x00
      00815D 00                     969 	.db 0x00
      00815E 00                     970 	.db 0x00
      00815F 00                     971 	.db 0x00
      008160 00                     972 	.db 0x00
      008161 00                     973 	.db 0x00
      008162 00                     974 	.db 0x00
      008163 00                     975 	.db 0x00
      008164 00                     976 	.db 0x00
      008165 00                     977 	.db 0x00
      008166 00                     978 	.db 0x00
      008167 00                     979 	.db 0x00
      008168 00                     980 	.db 0x00
      008169 00                     981 	.db 0x00
      00816A 00                     982 	.db 0x00
      00816B 00                     983 	.db 0x00
      00816C 00                     984 	.db 0x00
      00816D 00                     985 	.db 0x00
      00816E 00                     986 	.db 0x00
      00816F 00                     987 	.db 0x00
      008170 00                     988 	.db 0x00
      008171 00                     989 	.db 0x00
      008172 00                     990 	.db 0x00
      008173 00                     991 	.db 0x00
      008174 00                     992 	.db 0x00
      008175 00                     993 	.db 0x00
      008176 00                     994 	.db 0x00
      008177 00                     995 	.db 0x00
      008178 00                     996 	.db 0x00
      008179 00                     997 	.db 0x00
      00817A 00                     998 	.db 0x00
      00817B 00                     999 	.db 0x00
      00817C 00                    1000 	.db 0x00
      00817D 00                    1001 	.db 0x00
      00817E 00                    1002 	.db 0x00
      00817F 00                    1003 	.db 0x00
      008180                       1004 __xinit__current_dev:
      008180 00                    1005 	.db #0x00	; 0
                                   1006 	.area CABS (ABS)
