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
      008007 CD 84 ED         [ 4]   72 	call	___sdcc_external_startup
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
      008021 D6 80 8F         [ 1]   88 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 84 D6         [ 2]  102 	jp	_main
                                    103 ;	return from main will return to caller
                                    104 ;--------------------------------------------------------
                                    105 ; code
                                    106 ;--------------------------------------------------------
                                    107 	.area CODE
                                    108 ;	main.c: 8: void delay(unsigned long count) {
                                    109 ;	-----------------------------------------
                                    110 ;	 function delay
                                    111 ;	-----------------------------------------
      008191                        112 _delay:
      008191 52 08            [ 2]  113 	sub	sp, #8
                                    114 ;	main.c: 9: while (count--)
      008193 16 0D            [ 2]  115 	ldw	y, (0x0d, sp)
      008195 17 07            [ 2]  116 	ldw	(0x07, sp), y
      008197 1E 0B            [ 2]  117 	ldw	x, (0x0b, sp)
      008199                        118 00101$:
      008199 1F 01            [ 2]  119 	ldw	(0x01, sp), x
      00819B 7B 07            [ 1]  120 	ld	a, (0x07, sp)
      00819D 6B 03            [ 1]  121 	ld	(0x03, sp), a
      00819F 7B 08            [ 1]  122 	ld	a, (0x08, sp)
      0081A1 16 07            [ 2]  123 	ldw	y, (0x07, sp)
      0081A3 72 A2 00 01      [ 2]  124 	subw	y, #0x0001
      0081A7 17 07            [ 2]  125 	ldw	(0x07, sp), y
      0081A9 24 01            [ 1]  126 	jrnc	00117$
      0081AB 5A               [ 2]  127 	decw	x
      0081AC                        128 00117$:
      0081AC 4D               [ 1]  129 	tnz	a
      0081AD 26 08            [ 1]  130 	jrne	00118$
      0081AF 16 02            [ 2]  131 	ldw	y, (0x02, sp)
      0081B1 26 04            [ 1]  132 	jrne	00118$
      0081B3 0D 01            [ 1]  133 	tnz	(0x01, sp)
      0081B5 27 03            [ 1]  134 	jreq	00104$
      0081B7                        135 00118$:
                                    136 ;	main.c: 10: nop();
      0081B7 9D               [ 1]  137 	nop
      0081B8 20 DF            [ 2]  138 	jra	00101$
      0081BA                        139 00104$:
                                    140 ;	main.c: 11: }
      0081BA 1E 09            [ 2]  141 	ldw	x, (9, sp)
      0081BC 5B 0E            [ 2]  142 	addw	sp, #14
      0081BE FC               [ 2]  143 	jp	(x)
                                    144 ;	main.c: 13: int uart_write(const char *str) {
                                    145 ;	-----------------------------------------
                                    146 ;	 function uart_write
                                    147 ;	-----------------------------------------
      0081BF                        148 _uart_write:
      0081BF 52 05            [ 2]  149 	sub	sp, #5
      0081C1 1F 03            [ 2]  150 	ldw	(0x03, sp), x
                                    151 ;	main.c: 15: for(i = 0; i < strlen(str); i++) {
      0081C3 0F 05            [ 1]  152 	clr	(0x05, sp)
      0081C5                        153 00106$:
      0081C5 1E 03            [ 2]  154 	ldw	x, (0x03, sp)
      0081C7 CD 84 EF         [ 4]  155 	call	_strlen
      0081CA 1F 01            [ 2]  156 	ldw	(0x01, sp), x
      0081CC 5F               [ 1]  157 	clrw	x
      0081CD 7B 05            [ 1]  158 	ld	a, (0x05, sp)
      0081CF 97               [ 1]  159 	ld	xl, a
      0081D0 13 01            [ 2]  160 	cpw	x, (0x01, sp)
      0081D2 24 14            [ 1]  161 	jrnc	00104$
                                    162 ;	main.c: 16: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0081D4                        163 00101$:
      0081D4 C6 52 30         [ 1]  164 	ld	a, 0x5230
      0081D7 2A FB            [ 1]  165 	jrpl	00101$
                                    166 ;	main.c: 17: UART1_DR = str[i];
      0081D9 5F               [ 1]  167 	clrw	x
      0081DA 7B 05            [ 1]  168 	ld	a, (0x05, sp)
      0081DC 97               [ 1]  169 	ld	xl, a
      0081DD 72 FB 03         [ 2]  170 	addw	x, (0x03, sp)
      0081E0 F6               [ 1]  171 	ld	a, (x)
      0081E1 C7 52 31         [ 1]  172 	ld	0x5231, a
                                    173 ;	main.c: 15: for(i = 0; i < strlen(str); i++) {
      0081E4 0C 05            [ 1]  174 	inc	(0x05, sp)
      0081E6 20 DD            [ 2]  175 	jra	00106$
      0081E8                        176 00104$:
                                    177 ;	main.c: 19: return(i); // Bytes sent
      0081E8 7B 05            [ 1]  178 	ld	a, (0x05, sp)
      0081EA 5F               [ 1]  179 	clrw	x
      0081EB 97               [ 1]  180 	ld	xl, a
                                    181 ;	main.c: 20: }
      0081EC 5B 05            [ 2]  182 	addw	sp, #5
      0081EE 81               [ 4]  183 	ret
                                    184 ;	main.c: 24: void convert_int_to_chars(uint8_t num, char* rx_int_chars) {
                                    185 ;	-----------------------------------------
                                    186 ;	 function convert_int_to_chars
                                    187 ;	-----------------------------------------
      0081EF                        188 _convert_int_to_chars:
      0081EF 52 0D            [ 2]  189 	sub	sp, #13
      0081F1 6B 0D            [ 1]  190 	ld	(0x0d, sp), a
      0081F3 1F 0B            [ 2]  191 	ldw	(0x0b, sp), x
                                    192 ;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
      0081F5 7B 0D            [ 1]  193 	ld	a, (0x0d, sp)
      0081F7 6B 02            [ 1]  194 	ld	(0x02, sp), a
      0081F9 0F 01            [ 1]  195 	clr	(0x01, sp)
                                    196 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      0081FB 1E 0B            [ 2]  197 	ldw	x, (0x0b, sp)
      0081FD 5C               [ 1]  198 	incw	x
      0081FE 1F 03            [ 2]  199 	ldw	(0x03, sp), x
                                    200 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      008200 1E 0B            [ 2]  201 	ldw	x, (0x0b, sp)
      008202 5C               [ 1]  202 	incw	x
      008203 5C               [ 1]  203 	incw	x
      008204 1F 05            [ 2]  204 	ldw	(0x05, sp), x
                                    205 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      008206 4B 0A            [ 1]  206 	push	#0x0a
      008208 4B 00            [ 1]  207 	push	#0x00
      00820A 1E 03            [ 2]  208 	ldw	x, (0x03, sp)
                                    209 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      00820C CD 85 14         [ 4]  210 	call	__divsint
      00820F 1F 07            [ 2]  211 	ldw	(0x07, sp), x
      008211 4B 0A            [ 1]  212 	push	#0x0a
      008213 4B 00            [ 1]  213 	push	#0x00
      008215 1E 03            [ 2]  214 	ldw	x, (0x03, sp)
      008217 CD 84 FC         [ 4]  215 	call	__modsint
      00821A 9F               [ 1]  216 	ld	a, xl
      00821B AB 30            [ 1]  217 	add	a, #0x30
      00821D 6B 09            [ 1]  218 	ld	(0x09, sp), a
                                    219 ;	main.c: 25: if (num > 99) {
      00821F 7B 0D            [ 1]  220 	ld	a, (0x0d, sp)
      008221 A1 63            [ 1]  221 	cp	a, #0x63
      008223 23 29            [ 2]  222 	jrule	00105$
                                    223 ;	main.c: 27: rx_int_chars[0] = num / 100 + '0';
      008225 4B 64            [ 1]  224 	push	#0x64
      008227 4B 00            [ 1]  225 	push	#0x00
      008229 1E 03            [ 2]  226 	ldw	x, (0x03, sp)
      00822B CD 85 14         [ 4]  227 	call	__divsint
      00822E 9F               [ 1]  228 	ld	a, xl
      00822F AB 30            [ 1]  229 	add	a, #0x30
      008231 1E 0B            [ 2]  230 	ldw	x, (0x0b, sp)
      008233 F7               [ 1]  231 	ld	(x), a
                                    232 ;	main.c: 28: rx_int_chars[1] = num / 10 % 10 + '0';
      008234 4B 0A            [ 1]  233 	push	#0x0a
      008236 4B 00            [ 1]  234 	push	#0x00
      008238 1E 09            [ 2]  235 	ldw	x, (0x09, sp)
      00823A CD 84 FC         [ 4]  236 	call	__modsint
      00823D 9F               [ 1]  237 	ld	a, xl
      00823E AB 30            [ 1]  238 	add	a, #0x30
      008240 1E 03            [ 2]  239 	ldw	x, (0x03, sp)
      008242 F7               [ 1]  240 	ld	(x), a
                                    241 ;	main.c: 29: rx_int_chars[2] = num % 10 + '0';
      008243 1E 05            [ 2]  242 	ldw	x, (0x05, sp)
      008245 7B 09            [ 1]  243 	ld	a, (0x09, sp)
      008247 F7               [ 1]  244 	ld	(x), a
                                    245 ;	main.c: 30: rx_int_chars[3] ='\0';
      008248 1E 0B            [ 2]  246 	ldw	x, (0x0b, sp)
      00824A 6F 03            [ 1]  247 	clr	(0x0003, x)
      00824C 20 23            [ 2]  248 	jra	00107$
      00824E                        249 00105$:
                                    250 ;	main.c: 32: } else if (num > 9) {
      00824E 7B 0D            [ 1]  251 	ld	a, (0x0d, sp)
      008250 A1 09            [ 1]  252 	cp	a, #0x09
      008252 23 13            [ 2]  253 	jrule	00102$
                                    254 ;	main.c: 34: rx_int_chars[0] = num / 10 + '0';
      008254 7B 08            [ 1]  255 	ld	a, (0x08, sp)
      008256 6B 0A            [ 1]  256 	ld	(0x0a, sp), a
      008258 AB 30            [ 1]  257 	add	a, #0x30
      00825A 1E 0B            [ 2]  258 	ldw	x, (0x0b, sp)
      00825C F7               [ 1]  259 	ld	(x), a
                                    260 ;	main.c: 35: rx_int_chars[1] = num % 10 + '0';
      00825D 1E 03            [ 2]  261 	ldw	x, (0x03, sp)
      00825F 7B 09            [ 1]  262 	ld	a, (0x09, sp)
      008261 F7               [ 1]  263 	ld	(x), a
                                    264 ;	main.c: 36: rx_int_chars[2] ='\0';
      008262 1E 05            [ 2]  265 	ldw	x, (0x05, sp)
      008264 7F               [ 1]  266 	clr	(x)
      008265 20 0A            [ 2]  267 	jra	00107$
      008267                        268 00102$:
                                    269 ;	main.c: 41: rx_int_chars[0] = num + '0';
      008267 7B 0D            [ 1]  270 	ld	a, (0x0d, sp)
      008269 AB 30            [ 1]  271 	add	a, #0x30
      00826B 1E 0B            [ 2]  272 	ldw	x, (0x0b, sp)
      00826D F7               [ 1]  273 	ld	(x), a
                                    274 ;	main.c: 42: rx_int_chars[1] ='\0';
      00826E 1E 03            [ 2]  275 	ldw	x, (0x03, sp)
      008270 7F               [ 1]  276 	clr	(x)
      008271                        277 00107$:
                                    278 ;	main.c: 44: }
      008271 5B 0D            [ 2]  279 	addw	sp, #13
      008273 81               [ 4]  280 	ret
                                    281 ;	main.c: 46: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    282 ;	-----------------------------------------
                                    283 ;	 function convert_int_to_binary
                                    284 ;	-----------------------------------------
      008274                        285 _convert_int_to_binary:
      008274 52 04            [ 2]  286 	sub	sp, #4
      008276 1F 01            [ 2]  287 	ldw	(0x01, sp), x
                                    288 ;	main.c: 48: for(int i = 7; i >= 0; i--) {
      008278 AE 00 07         [ 2]  289 	ldw	x, #0x0007
      00827B 1F 03            [ 2]  290 	ldw	(0x03, sp), x
      00827D                        291 00103$:
      00827D 0D 03            [ 1]  292 	tnz	(0x03, sp)
      00827F 2B 22            [ 1]  293 	jrmi	00101$
                                    294 ;	main.c: 50: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008281 AE 00 07         [ 2]  295 	ldw	x, #0x0007
      008284 72 F0 03         [ 2]  296 	subw	x, (0x03, sp)
      008287 72 FB 07         [ 2]  297 	addw	x, (0x07, sp)
      00828A 16 01            [ 2]  298 	ldw	y, (0x01, sp)
      00828C 7B 04            [ 1]  299 	ld	a, (0x04, sp)
      00828E 27 05            [ 1]  300 	jreq	00120$
      008290                        301 00119$:
      008290 90 57            [ 2]  302 	sraw	y
      008292 4A               [ 1]  303 	dec	a
      008293 26 FB            [ 1]  304 	jrne	00119$
      008295                        305 00120$:
      008295 90 9F            [ 1]  306 	ld	a, yl
      008297 A4 01            [ 1]  307 	and	a, #0x01
      008299 AB 30            [ 1]  308 	add	a, #0x30
      00829B F7               [ 1]  309 	ld	(x), a
                                    310 ;	main.c: 48: for(int i = 7; i >= 0; i--) {
      00829C 1E 03            [ 2]  311 	ldw	x, (0x03, sp)
      00829E 5A               [ 2]  312 	decw	x
      00829F 1F 03            [ 2]  313 	ldw	(0x03, sp), x
      0082A1 20 DA            [ 2]  314 	jra	00103$
      0082A3                        315 00101$:
                                    316 ;	main.c: 52: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      0082A3 1E 07            [ 2]  317 	ldw	x, (0x07, sp)
      0082A5 6F 08            [ 1]  318 	clr	(0x0008, x)
                                    319 ;	main.c: 53: }
      0082A7 1E 05            [ 2]  320 	ldw	x, (5, sp)
      0082A9 5B 08            [ 2]  321 	addw	sp, #8
      0082AB FC               [ 2]  322 	jp	(x)
                                    323 ;	main.c: 55: void status_check(void){
                                    324 ;	-----------------------------------------
                                    325 ;	 function status_check
                                    326 ;	-----------------------------------------
      0082AC                        327 _status_check:
      0082AC 52 09            [ 2]  328 	sub	sp, #9
                                    329 ;	main.c: 56: char rx_binary_chars[9]={0};
      0082AE 0F 01            [ 1]  330 	clr	(0x01, sp)
      0082B0 0F 02            [ 1]  331 	clr	(0x02, sp)
      0082B2 0F 03            [ 1]  332 	clr	(0x03, sp)
      0082B4 0F 04            [ 1]  333 	clr	(0x04, sp)
      0082B6 0F 05            [ 1]  334 	clr	(0x05, sp)
      0082B8 0F 06            [ 1]  335 	clr	(0x06, sp)
      0082BA 0F 07            [ 1]  336 	clr	(0x07, sp)
      0082BC 0F 08            [ 1]  337 	clr	(0x08, sp)
      0082BE 0F 09            [ 1]  338 	clr	(0x09, sp)
                                    339 ;	main.c: 57: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0082C0 96               [ 1]  340 	ldw	x, sp
      0082C1 5C               [ 1]  341 	incw	x
      0082C2 51               [ 1]  342 	exgw	x, y
      0082C3 C6 52 17         [ 1]  343 	ld	a, 0x5217
      0082C6 5F               [ 1]  344 	clrw	x
      0082C7 90 89            [ 2]  345 	pushw	y
      0082C9 97               [ 1]  346 	ld	xl, a
      0082CA CD 82 74         [ 4]  347 	call	_convert_int_to_binary
                                    348 ;	main.c: 58: uart_write("\nSR1 -> ");
      0082CD AE 80 2D         [ 2]  349 	ldw	x, #(___str_0+0)
      0082D0 CD 81 BF         [ 4]  350 	call	_uart_write
                                    351 ;	main.c: 59: uart_write(rx_binary_chars);
      0082D3 96               [ 1]  352 	ldw	x, sp
      0082D4 5C               [ 1]  353 	incw	x
      0082D5 CD 81 BF         [ 4]  354 	call	_uart_write
                                    355 ;	main.c: 60: uart_write(" <-\n");
      0082D8 AE 80 36         [ 2]  356 	ldw	x, #(___str_1+0)
      0082DB CD 81 BF         [ 4]  357 	call	_uart_write
                                    358 ;	main.c: 61: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0082DE 96               [ 1]  359 	ldw	x, sp
      0082DF 5C               [ 1]  360 	incw	x
      0082E0 51               [ 1]  361 	exgw	x, y
      0082E1 C6 52 18         [ 1]  362 	ld	a, 0x5218
      0082E4 5F               [ 1]  363 	clrw	x
      0082E5 90 89            [ 2]  364 	pushw	y
      0082E7 97               [ 1]  365 	ld	xl, a
      0082E8 CD 82 74         [ 4]  366 	call	_convert_int_to_binary
                                    367 ;	main.c: 62: uart_write("SR2 -> ");
      0082EB AE 80 3B         [ 2]  368 	ldw	x, #(___str_2+0)
      0082EE CD 81 BF         [ 4]  369 	call	_uart_write
                                    370 ;	main.c: 63: uart_write(rx_binary_chars);
      0082F1 96               [ 1]  371 	ldw	x, sp
      0082F2 5C               [ 1]  372 	incw	x
      0082F3 CD 81 BF         [ 4]  373 	call	_uart_write
                                    374 ;	main.c: 64: uart_write(" <-\n");
      0082F6 AE 80 36         [ 2]  375 	ldw	x, #(___str_1+0)
      0082F9 CD 81 BF         [ 4]  376 	call	_uart_write
                                    377 ;	main.c: 65: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      0082FC 96               [ 1]  378 	ldw	x, sp
      0082FD 5C               [ 1]  379 	incw	x
      0082FE 51               [ 1]  380 	exgw	x, y
      0082FF C6 52 19         [ 1]  381 	ld	a, 0x5219
      008302 5F               [ 1]  382 	clrw	x
      008303 90 89            [ 2]  383 	pushw	y
      008305 97               [ 1]  384 	ld	xl, a
      008306 CD 82 74         [ 4]  385 	call	_convert_int_to_binary
                                    386 ;	main.c: 66: uart_write("SR3 -> ");
      008309 AE 80 43         [ 2]  387 	ldw	x, #(___str_3+0)
      00830C CD 81 BF         [ 4]  388 	call	_uart_write
                                    389 ;	main.c: 67: uart_write(rx_binary_chars);
      00830F 96               [ 1]  390 	ldw	x, sp
      008310 5C               [ 1]  391 	incw	x
      008311 CD 81 BF         [ 4]  392 	call	_uart_write
                                    393 ;	main.c: 68: uart_write(" <-\n");
      008314 AE 80 36         [ 2]  394 	ldw	x, #(___str_1+0)
      008317 CD 81 BF         [ 4]  395 	call	_uart_write
                                    396 ;	main.c: 69: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      00831A 96               [ 1]  397 	ldw	x, sp
      00831B 5C               [ 1]  398 	incw	x
      00831C 51               [ 1]  399 	exgw	x, y
      00831D C6 52 10         [ 1]  400 	ld	a, 0x5210
      008320 5F               [ 1]  401 	clrw	x
      008321 90 89            [ 2]  402 	pushw	y
      008323 97               [ 1]  403 	ld	xl, a
      008324 CD 82 74         [ 4]  404 	call	_convert_int_to_binary
                                    405 ;	main.c: 70: uart_write("CR1 -> ");
      008327 AE 80 4B         [ 2]  406 	ldw	x, #(___str_4+0)
      00832A CD 81 BF         [ 4]  407 	call	_uart_write
                                    408 ;	main.c: 71: uart_write(rx_binary_chars);
      00832D 96               [ 1]  409 	ldw	x, sp
      00832E 5C               [ 1]  410 	incw	x
      00832F CD 81 BF         [ 4]  411 	call	_uart_write
                                    412 ;	main.c: 72: uart_write(" <-\n");
      008332 AE 80 36         [ 2]  413 	ldw	x, #(___str_1+0)
      008335 CD 81 BF         [ 4]  414 	call	_uart_write
                                    415 ;	main.c: 73: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      008338 96               [ 1]  416 	ldw	x, sp
      008339 5C               [ 1]  417 	incw	x
      00833A 51               [ 1]  418 	exgw	x, y
      00833B C6 52 11         [ 1]  419 	ld	a, 0x5211
      00833E 5F               [ 1]  420 	clrw	x
      00833F 90 89            [ 2]  421 	pushw	y
      008341 97               [ 1]  422 	ld	xl, a
      008342 CD 82 74         [ 4]  423 	call	_convert_int_to_binary
                                    424 ;	main.c: 74: uart_write("CR2 -> ");
      008345 AE 80 53         [ 2]  425 	ldw	x, #(___str_5+0)
      008348 CD 81 BF         [ 4]  426 	call	_uart_write
                                    427 ;	main.c: 75: uart_write(rx_binary_chars);
      00834B 96               [ 1]  428 	ldw	x, sp
      00834C 5C               [ 1]  429 	incw	x
      00834D CD 81 BF         [ 4]  430 	call	_uart_write
                                    431 ;	main.c: 76: uart_write(" <-\n");
      008350 AE 80 36         [ 2]  432 	ldw	x, #(___str_1+0)
      008353 CD 81 BF         [ 4]  433 	call	_uart_write
                                    434 ;	main.c: 77: convert_int_to_binary(I2C_DR, rx_binary_chars);
      008356 96               [ 1]  435 	ldw	x, sp
      008357 5C               [ 1]  436 	incw	x
      008358 51               [ 1]  437 	exgw	x, y
      008359 C6 52 16         [ 1]  438 	ld	a, 0x5216
      00835C 5F               [ 1]  439 	clrw	x
      00835D 90 89            [ 2]  440 	pushw	y
      00835F 97               [ 1]  441 	ld	xl, a
      008360 CD 82 74         [ 4]  442 	call	_convert_int_to_binary
                                    443 ;	main.c: 78: uart_write("DR -> ");
      008363 AE 80 5B         [ 2]  444 	ldw	x, #(___str_6+0)
      008366 CD 81 BF         [ 4]  445 	call	_uart_write
                                    446 ;	main.c: 79: uart_write(rx_binary_chars);
      008369 96               [ 1]  447 	ldw	x, sp
      00836A 5C               [ 1]  448 	incw	x
      00836B CD 81 BF         [ 4]  449 	call	_uart_write
                                    450 ;	main.c: 80: uart_write(" <-\n");
      00836E AE 80 36         [ 2]  451 	ldw	x, #(___str_1+0)
      008371 CD 81 BF         [ 4]  452 	call	_uart_write
                                    453 ;	main.c: 81: }
      008374 5B 09            [ 2]  454 	addw	sp, #9
      008376 81               [ 4]  455 	ret
                                    456 ;	main.c: 83: void uart_init(void){
                                    457 ;	-----------------------------------------
                                    458 ;	 function uart_init
                                    459 ;	-----------------------------------------
      008377                        460 _uart_init:
                                    461 ;	main.c: 84: CLK_CKDIVR = 0;
      008377 35 00 50 C6      [ 1]  462 	mov	0x50c6+0, #0x00
                                    463 ;	main.c: 87: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00837B 72 16 52 35      [ 1]  464 	bset	0x5235, #3
                                    465 ;	main.c: 88: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      00837F 72 14 52 35      [ 1]  466 	bset	0x5235, #2
                                    467 ;	main.c: 89: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008383 C6 52 36         [ 1]  468 	ld	a, 0x5236
      008386 A4 CF            [ 1]  469 	and	a, #0xcf
      008388 C7 52 36         [ 1]  470 	ld	0x5236, a
                                    471 ;	main.c: 91: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      00838B 35 03 52 33      [ 1]  472 	mov	0x5233+0, #0x03
      00838F 35 68 52 32      [ 1]  473 	mov	0x5232+0, #0x68
                                    474 ;	main.c: 92: }
      008393 81               [ 4]  475 	ret
                                    476 ;	main.c: 96: void i2c_init(void) {
                                    477 ;	-----------------------------------------
                                    478 ;	 function i2c_init
                                    479 ;	-----------------------------------------
      008394                        480 _i2c_init:
                                    481 ;	main.c: 102: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008394 72 11 52 10      [ 1]  482 	bres	0x5210, #0
                                    483 ;	main.c: 103: I2C_FREQR= 16;                  // peripheral frequence =16MHz
      008398 35 10 52 12      [ 1]  484 	mov	0x5212+0, #0x10
                                    485 ;	main.c: 104: I2C_CCRH = 0;                   // =0
      00839C 35 00 52 1C      [ 1]  486 	mov	0x521c+0, #0x00
                                    487 ;	main.c: 105: I2C_CCRL = 80;                  // 100kHz for I2C
      0083A0 35 50 52 1B      [ 1]  488 	mov	0x521b+0, #0x50
                                    489 ;	main.c: 106: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      0083A4 72 1F 52 1C      [ 1]  490 	bres	0x521c, #7
                                    491 ;	main.c: 107: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      0083A8 72 1F 52 14      [ 1]  492 	bres	0x5214, #7
                                    493 ;	main.c: 108: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      0083AC 72 1C 52 14      [ 1]  494 	bset	0x5214, #6
                                    495 ;	main.c: 109: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      0083B0 72 10 52 10      [ 1]  496 	bset	0x5210, #0
                                    497 ;	main.c: 110: }
      0083B4 81               [ 4]  498 	ret
                                    499 ;	main.c: 114: void i2c_start(void) {
                                    500 ;	-----------------------------------------
                                    501 ;	 function i2c_start
                                    502 ;	-----------------------------------------
      0083B5                        503 _i2c_start:
                                    504 ;	main.c: 115: I2C_CR2 = I2C_CR2 | (1 << 0); // Отправляем стартовый сигнал
      0083B5 72 10 52 11      [ 1]  505 	bset	0x5211, #0
                                    506 ;	main.c: 116: while(!(I2C_SR1 & (1 << 0)));
      0083B9                        507 00101$:
      0083B9 72 01 52 17 FB   [ 2]  508 	btjf	0x5217, #0, 00101$
                                    509 ;	main.c: 118: }
      0083BE 81               [ 4]  510 	ret
                                    511 ;	main.c: 120: void i2c_send_address(uint8_t address) {
                                    512 ;	-----------------------------------------
                                    513 ;	 function i2c_send_address
                                    514 ;	-----------------------------------------
      0083BF                        515 _i2c_send_address:
                                    516 ;	main.c: 121: I2C_DR = address << 1; // Отправка адреса устройства с битом на запись
      0083BF 48               [ 1]  517 	sll	a
      0083C0 C7 52 16         [ 1]  518 	ld	0x5216, a
                                    519 ;	main.c: 122: while (!(I2C_SR1 & (1 << 1)) && !(I2C_SR2 & (1 << 2)));
      0083C3                        520 00102$:
      0083C3 72 03 52 17 01   [ 2]  521 	btjf	0x5217, #1, 00117$
      0083C8 81               [ 4]  522 	ret
      0083C9                        523 00117$:
      0083C9 72 05 52 18 F5   [ 2]  524 	btjf	0x5218, #2, 00102$
                                    525 ;	main.c: 123: }
      0083CE 81               [ 4]  526 	ret
                                    527 ;	main.c: 125: void i2c_stop(void) {
                                    528 ;	-----------------------------------------
                                    529 ;	 function i2c_stop
                                    530 ;	-----------------------------------------
      0083CF                        531 _i2c_stop:
                                    532 ;	main.c: 126: I2C_CR2 = I2C_CR2 | (1 << 1); // Отправка стопового сигнала
      0083CF 72 12 52 11      [ 1]  533 	bset	0x5211, #1
                                    534 ;	main.c: 128: }
      0083D3 81               [ 4]  535 	ret
                                    536 ;	main.c: 132: void i2c_scan(void) {
                                    537 ;	-----------------------------------------
                                    538 ;	 function i2c_scan
                                    539 ;	-----------------------------------------
      0083D4                        540 _i2c_scan:
      0083D4 52 05            [ 2]  541 	sub	sp, #5
                                    542 ;	main.c: 133: for (uint8_t addr = 1; addr < 127; addr++) {
      0083D6 A6 01            [ 1]  543 	ld	a, #0x01
      0083D8 6B 05            [ 1]  544 	ld	(0x05, sp), a
      0083DA                        545 00105$:
      0083DA 7B 05            [ 1]  546 	ld	a, (0x05, sp)
      0083DC A1 7F            [ 1]  547 	cp	a, #0x7f
      0083DE 24 40            [ 1]  548 	jrnc	00107$
                                    549 ;	main.c: 134: i2c_start();
      0083E0 CD 83 B5         [ 4]  550 	call	_i2c_start
                                    551 ;	main.c: 135: i2c_send_address(addr);
      0083E3 7B 05            [ 1]  552 	ld	a, (0x05, sp)
      0083E5 CD 83 BF         [ 4]  553 	call	_i2c_send_address
                                    554 ;	main.c: 136: if (!(I2C_SR2 & (1 << 2))) { // Проверка на ACK
      0083E8 72 04 52 18 28   [ 2]  555 	btjt	0x5218, #2, 00102$
                                    556 ;	main.c: 138: uart_write("SM ");
      0083ED AE 80 62         [ 2]  557 	ldw	x, #(___str_7+0)
      0083F0 CD 81 BF         [ 4]  558 	call	_uart_write
                                    559 ;	main.c: 139: char rx_int_chars[4]={0};
      0083F3 0F 01            [ 1]  560 	clr	(0x01, sp)
      0083F5 0F 02            [ 1]  561 	clr	(0x02, sp)
      0083F7 0F 03            [ 1]  562 	clr	(0x03, sp)
      0083F9 0F 04            [ 1]  563 	clr	(0x04, sp)
                                    564 ;	main.c: 140: convert_int_to_chars(addr, rx_int_chars);
      0083FB 96               [ 1]  565 	ldw	x, sp
      0083FC 5C               [ 1]  566 	incw	x
      0083FD 7B 05            [ 1]  567 	ld	a, (0x05, sp)
      0083FF CD 81 EF         [ 4]  568 	call	_convert_int_to_chars
                                    569 ;	main.c: 141: uart_write(rx_int_chars); 
      008402 96               [ 1]  570 	ldw	x, sp
      008403 5C               [ 1]  571 	incw	x
      008404 CD 81 BF         [ 4]  572 	call	_uart_write
                                    573 ;	main.c: 142: uart_write("\r\n");
      008407 AE 80 66         [ 2]  574 	ldw	x, #(___str_8+0)
      00840A CD 81 BF         [ 4]  575 	call	_uart_write
                                    576 ;	main.c: 143: current_dev = addr;
      00840D 7B 05            [ 1]  577 	ld	a, (0x05, sp)
      00840F C7 01 01         [ 1]  578 	ld	_current_dev+0, a
                                    579 ;	main.c: 144: status_check();
      008412 CD 82 AC         [ 4]  580 	call	_status_check
      008415                        581 00102$:
                                    582 ;	main.c: 146: i2c_stop();
      008415 CD 83 CF         [ 4]  583 	call	_i2c_stop
                                    584 ;	main.c: 147: I2C_SR2 = I2C_SR2 & ~(1 << 2); // Очистка флага ошибки
      008418 72 15 52 18      [ 1]  585 	bres	0x5218, #2
                                    586 ;	main.c: 133: for (uint8_t addr = 1; addr < 127; addr++) {
      00841C 0C 05            [ 1]  587 	inc	(0x05, sp)
      00841E 20 BA            [ 2]  588 	jra	00105$
      008420                        589 00107$:
                                    590 ;	main.c: 151: }
      008420 5B 05            [ 2]  591 	addw	sp, #5
      008422 81               [ 4]  592 	ret
                                    593 ;	main.c: 154: int uart_read(void)
                                    594 ;	-----------------------------------------
                                    595 ;	 function uart_read
                                    596 ;	-----------------------------------------
      008423                        597 _uart_read:
      008423 52 0D            [ 2]  598 	sub	sp, #13
                                    599 ;	main.c: 156: char rx_binary_chars[9]={0};
      008425 0F 01            [ 1]  600 	clr	(0x01, sp)
      008427 0F 02            [ 1]  601 	clr	(0x02, sp)
      008429 0F 03            [ 1]  602 	clr	(0x03, sp)
      00842B 0F 04            [ 1]  603 	clr	(0x04, sp)
      00842D 0F 05            [ 1]  604 	clr	(0x05, sp)
      00842F 0F 06            [ 1]  605 	clr	(0x06, sp)
      008431 0F 07            [ 1]  606 	clr	(0x07, sp)
      008433 0F 08            [ 1]  607 	clr	(0x08, sp)
      008435 0F 09            [ 1]  608 	clr	(0x09, sp)
                                    609 ;	main.c: 157: for(int i = 0; i < sizeof(buffer); i++)
      008437 5F               [ 1]  610 	clrw	x
      008438                        611 00110$:
      008438 A3 01 00         [ 2]  612 	cpw	x, #0x0100
      00843B 2E 11            [ 1]  613 	jrsge	00101$
                                    614 ;	main.c: 159: buffer[i] = 0;
      00843D 9F               [ 1]  615 	ld	a, xl
      00843E AB 01            [ 1]  616 	add	a, #<(_buffer+0)
      008440 88               [ 1]  617 	push	a
      008441 9E               [ 1]  618 	ld	a, xh
      008442 A9 00            [ 1]  619 	adc	a, #((_buffer+0) >> 8)
      008444 90 95            [ 1]  620 	ld	yh, a
      008446 84               [ 1]  621 	pop	a
      008447 90 97            [ 1]  622 	ld	yl, a
      008449 90 7F            [ 1]  623 	clr	(y)
                                    624 ;	main.c: 157: for(int i = 0; i < sizeof(buffer); i++)
      00844B 5C               [ 1]  625 	incw	x
      00844C 20 EA            [ 2]  626 	jra	00110$
      00844E                        627 00101$:
                                    628 ;	main.c: 161: for(int i = 0; i < sizeof(buffer); i++) {
      00844E 5F               [ 1]  629 	clrw	x
      00844F 1F 0C            [ 2]  630 	ldw	(0x0c, sp), x
      008451                        631 00113$:
      008451 1E 0C            [ 2]  632 	ldw	x, (0x0c, sp)
      008453 A3 01 00         [ 2]  633 	cpw	x, #0x0100
      008456 2E 77            [ 1]  634 	jrsge	00108$
                                    635 ;	main.c: 162: uart_write("flag1");
      008458 AE 80 69         [ 2]  636 	ldw	x, #(___str_9+0)
      00845B CD 81 BF         [ 4]  637 	call	_uart_write
                                    638 ;	main.c: 163: while(!(UART1_SR & UART_SR_RXNE)); // !Transmit data register empty
      00845E                        639 00102$:
      00845E 72 0B 52 30 FB   [ 2]  640 	btjf	0x5230, #5, 00102$
                                    641 ;	main.c: 164: uart_write("flag2");
      008463 AE 80 6F         [ 2]  642 	ldw	x, #(___str_10+0)
      008466 CD 81 BF         [ 4]  643 	call	_uart_write
                                    644 ;	main.c: 165: convert_int_to_binary(UART1_DR, rx_binary_chars);
      008469 C6 52 31         [ 1]  645 	ld	a, 0x5231
      00846C 5F               [ 1]  646 	clrw	x
      00846D 90 96            [ 1]  647 	ldw	y, sp
      00846F 90 5C            [ 1]  648 	incw	y
      008471 90 89            [ 2]  649 	pushw	y
      008473 97               [ 1]  650 	ld	xl, a
      008474 CD 82 74         [ 4]  651 	call	_convert_int_to_binary
                                    652 ;	main.c: 166: uart_write("DRS -> ");
      008477 AE 80 75         [ 2]  653 	ldw	x, #(___str_11+0)
      00847A CD 81 BF         [ 4]  654 	call	_uart_write
                                    655 ;	main.c: 167: uart_write(rx_binary_chars);
      00847D 96               [ 1]  656 	ldw	x, sp
      00847E 5C               [ 1]  657 	incw	x
      00847F CD 81 BF         [ 4]  658 	call	_uart_write
                                    659 ;	main.c: 168: uart_write(" <-\n");
      008482 AE 80 36         [ 2]  660 	ldw	x, #(___str_1+0)
      008485 CD 81 BF         [ 4]  661 	call	_uart_write
                                    662 ;	main.c: 169: buffer[i] = UART1_DR;
      008488 1E 0C            [ 2]  663 	ldw	x, (0x0c, sp)
      00848A 1C 00 01         [ 2]  664 	addw	x, #(_buffer+0)
      00848D 1F 0A            [ 2]  665 	ldw	(0x0a, sp), x
      00848F C6 52 31         [ 1]  666 	ld	a, 0x5231
      008492 1E 0A            [ 2]  667 	ldw	x, (0x0a, sp)
      008494 F7               [ 1]  668 	ld	(x), a
                                    669 ;	main.c: 170: convert_int_to_binary(UART1_DR, rx_binary_chars);
      008495 C6 52 31         [ 1]  670 	ld	a, 0x5231
      008498 5F               [ 1]  671 	clrw	x
      008499 90 96            [ 1]  672 	ldw	y, sp
      00849B 90 5C            [ 1]  673 	incw	y
      00849D 90 89            [ 2]  674 	pushw	y
      00849F 97               [ 1]  675 	ld	xl, a
      0084A0 CD 82 74         [ 4]  676 	call	_convert_int_to_binary
                                    677 ;	main.c: 171: uart_write("DRE -> ");
      0084A3 AE 80 7D         [ 2]  678 	ldw	x, #(___str_12+0)
      0084A6 CD 81 BF         [ 4]  679 	call	_uart_write
                                    680 ;	main.c: 172: uart_write(rx_binary_chars);
      0084A9 96               [ 1]  681 	ldw	x, sp
      0084AA 5C               [ 1]  682 	incw	x
      0084AB CD 81 BF         [ 4]  683 	call	_uart_write
                                    684 ;	main.c: 173: uart_write(" <-\n");
      0084AE AE 80 36         [ 2]  685 	ldw	x, #(___str_1+0)
      0084B1 CD 81 BF         [ 4]  686 	call	_uart_write
                                    687 ;	main.c: 174: if(buffer[i] == '\n' || buffer[i] == '\0')
      0084B4 1E 0A            [ 2]  688 	ldw	x, (0x0a, sp)
      0084B6 F6               [ 1]  689 	ld	a, (x)
      0084B7 A1 0A            [ 1]  690 	cp	a, #0x0a
      0084B9 27 03            [ 1]  691 	jreq	00105$
      0084BB 4D               [ 1]  692 	tnz	a
      0084BC 26 0A            [ 1]  693 	jrne	00114$
      0084BE                        694 00105$:
                                    695 ;	main.c: 176: uart_write("flag_S");
      0084BE AE 80 85         [ 2]  696 	ldw	x, #(___str_13+0)
      0084C1 CD 81 BF         [ 4]  697 	call	_uart_write
                                    698 ;	main.c: 177: return 1;
      0084C4 5F               [ 1]  699 	clrw	x
      0084C5 5C               [ 1]  700 	incw	x
      0084C6 20 0B            [ 2]  701 	jra	00115$
      0084C8                        702 00114$:
                                    703 ;	main.c: 161: for(int i = 0; i < sizeof(buffer); i++) {
      0084C8 1E 0C            [ 2]  704 	ldw	x, (0x0c, sp)
      0084CA 5C               [ 1]  705 	incw	x
      0084CB 1F 0C            [ 2]  706 	ldw	(0x0c, sp), x
      0084CD 20 82            [ 2]  707 	jra	00113$
      0084CF                        708 00108$:
                                    709 ;	main.c: 181: status_check();
      0084CF CD 82 AC         [ 4]  710 	call	_status_check
                                    711 ;	main.c: 182: return 0;
      0084D2 5F               [ 1]  712 	clrw	x
      0084D3                        713 00115$:
                                    714 ;	main.c: 183: }
      0084D3 5B 0D            [ 2]  715 	addw	sp, #13
      0084D5 81               [ 4]  716 	ret
                                    717 ;	main.c: 186: int main(void)
                                    718 ;	-----------------------------------------
                                    719 ;	 function main
                                    720 ;	-----------------------------------------
      0084D6                        721 _main:
                                    722 ;	main.c: 188: uart_init();
      0084D6 CD 83 77         [ 4]  723 	call	_uart_init
                                    724 ;	main.c: 189: uart_write("SS\n");
      0084D9 AE 80 8C         [ 2]  725 	ldw	x, #(___str_14+0)
      0084DC CD 81 BF         [ 4]  726 	call	_uart_write
                                    727 ;	main.c: 191: while(uart_read()); 
      0084DF                        728 00101$:
      0084DF CD 84 23         [ 4]  729 	call	_uart_read
      0084E2 5D               [ 2]  730 	tnzw	x
      0084E3 26 FA            [ 1]  731 	jrne	00101$
                                    732 ;	main.c: 192: i2c_init();
      0084E5 CD 83 94         [ 4]  733 	call	_i2c_init
                                    734 ;	main.c: 196: i2c_scan(); 
      0084E8 CD 83 D4         [ 4]  735 	call	_i2c_scan
                                    736 ;	main.c: 198: return 0;
      0084EB 5F               [ 1]  737 	clrw	x
                                    738 ;	main.c: 199: }
      0084EC 81               [ 4]  739 	ret
                                    740 	.area CODE
                                    741 	.area CONST
                                    742 	.area CONST
      00802D                        743 ___str_0:
      00802D 0A                     744 	.db 0x0a
      00802E 53 52 31 20 2D 3E 20   745 	.ascii "SR1 -> "
      008035 00                     746 	.db 0x00
                                    747 	.area CODE
                                    748 	.area CONST
      008036                        749 ___str_1:
      008036 20 3C 2D               750 	.ascii " <-"
      008039 0A                     751 	.db 0x0a
      00803A 00                     752 	.db 0x00
                                    753 	.area CODE
                                    754 	.area CONST
      00803B                        755 ___str_2:
      00803B 53 52 32 20 2D 3E 20   756 	.ascii "SR2 -> "
      008042 00                     757 	.db 0x00
                                    758 	.area CODE
                                    759 	.area CONST
      008043                        760 ___str_3:
      008043 53 52 33 20 2D 3E 20   761 	.ascii "SR3 -> "
      00804A 00                     762 	.db 0x00
                                    763 	.area CODE
                                    764 	.area CONST
      00804B                        765 ___str_4:
      00804B 43 52 31 20 2D 3E 20   766 	.ascii "CR1 -> "
      008052 00                     767 	.db 0x00
                                    768 	.area CODE
                                    769 	.area CONST
      008053                        770 ___str_5:
      008053 43 52 32 20 2D 3E 20   771 	.ascii "CR2 -> "
      00805A 00                     772 	.db 0x00
                                    773 	.area CODE
                                    774 	.area CONST
      00805B                        775 ___str_6:
      00805B 44 52 20 2D 3E 20      776 	.ascii "DR -> "
      008061 00                     777 	.db 0x00
                                    778 	.area CODE
                                    779 	.area CONST
      008062                        780 ___str_7:
      008062 53 4D 20               781 	.ascii "SM "
      008065 00                     782 	.db 0x00
                                    783 	.area CODE
                                    784 	.area CONST
      008066                        785 ___str_8:
      008066 0D                     786 	.db 0x0d
      008067 0A                     787 	.db 0x0a
      008068 00                     788 	.db 0x00
                                    789 	.area CODE
                                    790 	.area CONST
      008069                        791 ___str_9:
      008069 66 6C 61 67 31         792 	.ascii "flag1"
      00806E 00                     793 	.db 0x00
                                    794 	.area CODE
                                    795 	.area CONST
      00806F                        796 ___str_10:
      00806F 66 6C 61 67 32         797 	.ascii "flag2"
      008074 00                     798 	.db 0x00
                                    799 	.area CODE
                                    800 	.area CONST
      008075                        801 ___str_11:
      008075 44 52 53 20 2D 3E 20   802 	.ascii "DRS -> "
      00807C 00                     803 	.db 0x00
                                    804 	.area CODE
                                    805 	.area CONST
      00807D                        806 ___str_12:
      00807D 44 52 45 20 2D 3E 20   807 	.ascii "DRE -> "
      008084 00                     808 	.db 0x00
                                    809 	.area CODE
                                    810 	.area CONST
      008085                        811 ___str_13:
      008085 66 6C 61 67 5F 53      812 	.ascii "flag_S"
      00808B 00                     813 	.db 0x00
                                    814 	.area CODE
                                    815 	.area CONST
      00808C                        816 ___str_14:
      00808C 53 53                  817 	.ascii "SS"
      00808E 0A                     818 	.db 0x0a
      00808F 00                     819 	.db 0x00
                                    820 	.area CODE
                                    821 	.area INITIALIZER
      008090                        822 __xinit__buffer:
      008090 00                     823 	.db #0x00	; 0
      008091 00                     824 	.db 0x00
      008092 00                     825 	.db 0x00
      008093 00                     826 	.db 0x00
      008094 00                     827 	.db 0x00
      008095 00                     828 	.db 0x00
      008096 00                     829 	.db 0x00
      008097 00                     830 	.db 0x00
      008098 00                     831 	.db 0x00
      008099 00                     832 	.db 0x00
      00809A 00                     833 	.db 0x00
      00809B 00                     834 	.db 0x00
      00809C 00                     835 	.db 0x00
      00809D 00                     836 	.db 0x00
      00809E 00                     837 	.db 0x00
      00809F 00                     838 	.db 0x00
      0080A0 00                     839 	.db 0x00
      0080A1 00                     840 	.db 0x00
      0080A2 00                     841 	.db 0x00
      0080A3 00                     842 	.db 0x00
      0080A4 00                     843 	.db 0x00
      0080A5 00                     844 	.db 0x00
      0080A6 00                     845 	.db 0x00
      0080A7 00                     846 	.db 0x00
      0080A8 00                     847 	.db 0x00
      0080A9 00                     848 	.db 0x00
      0080AA 00                     849 	.db 0x00
      0080AB 00                     850 	.db 0x00
      0080AC 00                     851 	.db 0x00
      0080AD 00                     852 	.db 0x00
      0080AE 00                     853 	.db 0x00
      0080AF 00                     854 	.db 0x00
      0080B0 00                     855 	.db 0x00
      0080B1 00                     856 	.db 0x00
      0080B2 00                     857 	.db 0x00
      0080B3 00                     858 	.db 0x00
      0080B4 00                     859 	.db 0x00
      0080B5 00                     860 	.db 0x00
      0080B6 00                     861 	.db 0x00
      0080B7 00                     862 	.db 0x00
      0080B8 00                     863 	.db 0x00
      0080B9 00                     864 	.db 0x00
      0080BA 00                     865 	.db 0x00
      0080BB 00                     866 	.db 0x00
      0080BC 00                     867 	.db 0x00
      0080BD 00                     868 	.db 0x00
      0080BE 00                     869 	.db 0x00
      0080BF 00                     870 	.db 0x00
      0080C0 00                     871 	.db 0x00
      0080C1 00                     872 	.db 0x00
      0080C2 00                     873 	.db 0x00
      0080C3 00                     874 	.db 0x00
      0080C4 00                     875 	.db 0x00
      0080C5 00                     876 	.db 0x00
      0080C6 00                     877 	.db 0x00
      0080C7 00                     878 	.db 0x00
      0080C8 00                     879 	.db 0x00
      0080C9 00                     880 	.db 0x00
      0080CA 00                     881 	.db 0x00
      0080CB 00                     882 	.db 0x00
      0080CC 00                     883 	.db 0x00
      0080CD 00                     884 	.db 0x00
      0080CE 00                     885 	.db 0x00
      0080CF 00                     886 	.db 0x00
      0080D0 00                     887 	.db 0x00
      0080D1 00                     888 	.db 0x00
      0080D2 00                     889 	.db 0x00
      0080D3 00                     890 	.db 0x00
      0080D4 00                     891 	.db 0x00
      0080D5 00                     892 	.db 0x00
      0080D6 00                     893 	.db 0x00
      0080D7 00                     894 	.db 0x00
      0080D8 00                     895 	.db 0x00
      0080D9 00                     896 	.db 0x00
      0080DA 00                     897 	.db 0x00
      0080DB 00                     898 	.db 0x00
      0080DC 00                     899 	.db 0x00
      0080DD 00                     900 	.db 0x00
      0080DE 00                     901 	.db 0x00
      0080DF 00                     902 	.db 0x00
      0080E0 00                     903 	.db 0x00
      0080E1 00                     904 	.db 0x00
      0080E2 00                     905 	.db 0x00
      0080E3 00                     906 	.db 0x00
      0080E4 00                     907 	.db 0x00
      0080E5 00                     908 	.db 0x00
      0080E6 00                     909 	.db 0x00
      0080E7 00                     910 	.db 0x00
      0080E8 00                     911 	.db 0x00
      0080E9 00                     912 	.db 0x00
      0080EA 00                     913 	.db 0x00
      0080EB 00                     914 	.db 0x00
      0080EC 00                     915 	.db 0x00
      0080ED 00                     916 	.db 0x00
      0080EE 00                     917 	.db 0x00
      0080EF 00                     918 	.db 0x00
      0080F0 00                     919 	.db 0x00
      0080F1 00                     920 	.db 0x00
      0080F2 00                     921 	.db 0x00
      0080F3 00                     922 	.db 0x00
      0080F4 00                     923 	.db 0x00
      0080F5 00                     924 	.db 0x00
      0080F6 00                     925 	.db 0x00
      0080F7 00                     926 	.db 0x00
      0080F8 00                     927 	.db 0x00
      0080F9 00                     928 	.db 0x00
      0080FA 00                     929 	.db 0x00
      0080FB 00                     930 	.db 0x00
      0080FC 00                     931 	.db 0x00
      0080FD 00                     932 	.db 0x00
      0080FE 00                     933 	.db 0x00
      0080FF 00                     934 	.db 0x00
      008100 00                     935 	.db 0x00
      008101 00                     936 	.db 0x00
      008102 00                     937 	.db 0x00
      008103 00                     938 	.db 0x00
      008104 00                     939 	.db 0x00
      008105 00                     940 	.db 0x00
      008106 00                     941 	.db 0x00
      008107 00                     942 	.db 0x00
      008108 00                     943 	.db 0x00
      008109 00                     944 	.db 0x00
      00810A 00                     945 	.db 0x00
      00810B 00                     946 	.db 0x00
      00810C 00                     947 	.db 0x00
      00810D 00                     948 	.db 0x00
      00810E 00                     949 	.db 0x00
      00810F 00                     950 	.db 0x00
      008110 00                     951 	.db 0x00
      008111 00                     952 	.db 0x00
      008112 00                     953 	.db 0x00
      008113 00                     954 	.db 0x00
      008114 00                     955 	.db 0x00
      008115 00                     956 	.db 0x00
      008116 00                     957 	.db 0x00
      008117 00                     958 	.db 0x00
      008118 00                     959 	.db 0x00
      008119 00                     960 	.db 0x00
      00811A 00                     961 	.db 0x00
      00811B 00                     962 	.db 0x00
      00811C 00                     963 	.db 0x00
      00811D 00                     964 	.db 0x00
      00811E 00                     965 	.db 0x00
      00811F 00                     966 	.db 0x00
      008120 00                     967 	.db 0x00
      008121 00                     968 	.db 0x00
      008122 00                     969 	.db 0x00
      008123 00                     970 	.db 0x00
      008124 00                     971 	.db 0x00
      008125 00                     972 	.db 0x00
      008126 00                     973 	.db 0x00
      008127 00                     974 	.db 0x00
      008128 00                     975 	.db 0x00
      008129 00                     976 	.db 0x00
      00812A 00                     977 	.db 0x00
      00812B 00                     978 	.db 0x00
      00812C 00                     979 	.db 0x00
      00812D 00                     980 	.db 0x00
      00812E 00                     981 	.db 0x00
      00812F 00                     982 	.db 0x00
      008130 00                     983 	.db 0x00
      008131 00                     984 	.db 0x00
      008132 00                     985 	.db 0x00
      008133 00                     986 	.db 0x00
      008134 00                     987 	.db 0x00
      008135 00                     988 	.db 0x00
      008136 00                     989 	.db 0x00
      008137 00                     990 	.db 0x00
      008138 00                     991 	.db 0x00
      008139 00                     992 	.db 0x00
      00813A 00                     993 	.db 0x00
      00813B 00                     994 	.db 0x00
      00813C 00                     995 	.db 0x00
      00813D 00                     996 	.db 0x00
      00813E 00                     997 	.db 0x00
      00813F 00                     998 	.db 0x00
      008140 00                     999 	.db 0x00
      008141 00                    1000 	.db 0x00
      008142 00                    1001 	.db 0x00
      008143 00                    1002 	.db 0x00
      008144 00                    1003 	.db 0x00
      008145 00                    1004 	.db 0x00
      008146 00                    1005 	.db 0x00
      008147 00                    1006 	.db 0x00
      008148 00                    1007 	.db 0x00
      008149 00                    1008 	.db 0x00
      00814A 00                    1009 	.db 0x00
      00814B 00                    1010 	.db 0x00
      00814C 00                    1011 	.db 0x00
      00814D 00                    1012 	.db 0x00
      00814E 00                    1013 	.db 0x00
      00814F 00                    1014 	.db 0x00
      008150 00                    1015 	.db 0x00
      008151 00                    1016 	.db 0x00
      008152 00                    1017 	.db 0x00
      008153 00                    1018 	.db 0x00
      008154 00                    1019 	.db 0x00
      008155 00                    1020 	.db 0x00
      008156 00                    1021 	.db 0x00
      008157 00                    1022 	.db 0x00
      008158 00                    1023 	.db 0x00
      008159 00                    1024 	.db 0x00
      00815A 00                    1025 	.db 0x00
      00815B 00                    1026 	.db 0x00
      00815C 00                    1027 	.db 0x00
      00815D 00                    1028 	.db 0x00
      00815E 00                    1029 	.db 0x00
      00815F 00                    1030 	.db 0x00
      008160 00                    1031 	.db 0x00
      008161 00                    1032 	.db 0x00
      008162 00                    1033 	.db 0x00
      008163 00                    1034 	.db 0x00
      008164 00                    1035 	.db 0x00
      008165 00                    1036 	.db 0x00
      008166 00                    1037 	.db 0x00
      008167 00                    1038 	.db 0x00
      008168 00                    1039 	.db 0x00
      008169 00                    1040 	.db 0x00
      00816A 00                    1041 	.db 0x00
      00816B 00                    1042 	.db 0x00
      00816C 00                    1043 	.db 0x00
      00816D 00                    1044 	.db 0x00
      00816E 00                    1045 	.db 0x00
      00816F 00                    1046 	.db 0x00
      008170 00                    1047 	.db 0x00
      008171 00                    1048 	.db 0x00
      008172 00                    1049 	.db 0x00
      008173 00                    1050 	.db 0x00
      008174 00                    1051 	.db 0x00
      008175 00                    1052 	.db 0x00
      008176 00                    1053 	.db 0x00
      008177 00                    1054 	.db 0x00
      008178 00                    1055 	.db 0x00
      008179 00                    1056 	.db 0x00
      00817A 00                    1057 	.db 0x00
      00817B 00                    1058 	.db 0x00
      00817C 00                    1059 	.db 0x00
      00817D 00                    1060 	.db 0x00
      00817E 00                    1061 	.db 0x00
      00817F 00                    1062 	.db 0x00
      008180 00                    1063 	.db 0x00
      008181 00                    1064 	.db 0x00
      008182 00                    1065 	.db 0x00
      008183 00                    1066 	.db 0x00
      008184 00                    1067 	.db 0x00
      008185 00                    1068 	.db 0x00
      008186 00                    1069 	.db 0x00
      008187 00                    1070 	.db 0x00
      008188 00                    1071 	.db 0x00
      008189 00                    1072 	.db 0x00
      00818A 00                    1073 	.db 0x00
      00818B 00                    1074 	.db 0x00
      00818C 00                    1075 	.db 0x00
      00818D 00                    1076 	.db 0x00
      00818E 00                    1077 	.db 0x00
      00818F 00                    1078 	.db 0x00
      008190                       1079 __xinit__current_dev:
      008190 00                    1080 	.db #0x00	; 0
                                   1081 	.area CABS (ABS)
