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
                                     12 	.globl _status_check
                                     13 	.globl _uart_write_line
                                     14 	.globl _convert_int_to_binary
                                     15 	.globl _convert_int_to_chars
                                     16 	.globl _delay
                                     17 	.globl _strlen
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
                                     26 ;--------------------------------------------------------
                                     27 ; Stack segment in internal ram
                                     28 ;--------------------------------------------------------
                                     29 	.area SSEG
      000001                         30 __start__stack:
      000001                         31 	.ds	1
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; absolute external ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DABS (ABS)
                                     37 
                                     38 ; default segment ordering for linker
                                     39 	.area HOME
                                     40 	.area GSINIT
                                     41 	.area GSFINAL
                                     42 	.area CONST
                                     43 	.area INITIALIZER
                                     44 	.area CODE
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; interrupt vector
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
      008000                         50 __interrupt_vect:
      008000 82 00 80 07             51 	int s_GSINIT ; reset
                                     52 ;--------------------------------------------------------
                                     53 ; global & static initialisations
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area GSINIT
      008007 CD 83 09         [ 4]   59 	call	___sdcc_external_startup
      00800A 4D               [ 1]   60 	tnz	a
      00800B 27 03            [ 1]   61 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   62 	jp	__sdcc_program_startup
      008010                         63 __sdcc_init_data:
                                     64 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   65 	ldw x, #l_DATA
      008013 27 07            [ 1]   66 	jreq	00002$
      008015                         67 00001$:
      008015 72 4F 00 00      [ 1]   68 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   69 	decw x
      00801A 26 F9            [ 1]   70 	jrne	00001$
      00801C                         71 00002$:
      00801C AE 00 00         [ 2]   72 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   73 	jreq	00004$
      008021                         74 00003$:
      008021 D6 80 A4         [ 1]   75 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   76 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   77 	decw	x
      008028 26 F7            [ 1]   78 	jrne	00003$
      00802A                         79 00004$:
                                     80 ; stm8_genXINIT() end
                                     81 	.area GSFINAL
      00802A CC 80 04         [ 2]   82 	jp	__sdcc_program_startup
                                     83 ;--------------------------------------------------------
                                     84 ; Home
                                     85 ;--------------------------------------------------------
                                     86 	.area HOME
                                     87 	.area HOME
      008004                         88 __sdcc_program_startup:
      008004 CC 82 6D         [ 2]   89 	jp	_main
                                     90 ;	return from main will return to caller
                                     91 ;--------------------------------------------------------
                                     92 ; code
                                     93 ;--------------------------------------------------------
                                     94 	.area CODE
                                     95 ;	main.c: 7: void delay(unsigned long count) {
                                     96 ;	-----------------------------------------
                                     97 ;	 function delay
                                     98 ;	-----------------------------------------
      0080A5                         99 _delay:
      0080A5 52 08            [ 2]  100 	sub	sp, #8
                                    101 ;	main.c: 8: while (count--)
      0080A7 16 0D            [ 2]  102 	ldw	y, (0x0d, sp)
      0080A9 17 07            [ 2]  103 	ldw	(0x07, sp), y
      0080AB 1E 0B            [ 2]  104 	ldw	x, (0x0b, sp)
      0080AD                        105 00101$:
      0080AD 1F 01            [ 2]  106 	ldw	(0x01, sp), x
      0080AF 7B 07            [ 1]  107 	ld	a, (0x07, sp)
      0080B1 6B 03            [ 1]  108 	ld	(0x03, sp), a
      0080B3 7B 08            [ 1]  109 	ld	a, (0x08, sp)
      0080B5 16 07            [ 2]  110 	ldw	y, (0x07, sp)
      0080B7 72 A2 00 01      [ 2]  111 	subw	y, #0x0001
      0080BB 17 07            [ 2]  112 	ldw	(0x07, sp), y
      0080BD 24 01            [ 1]  113 	jrnc	00117$
      0080BF 5A               [ 2]  114 	decw	x
      0080C0                        115 00117$:
      0080C0 4D               [ 1]  116 	tnz	a
      0080C1 26 08            [ 1]  117 	jrne	00118$
      0080C3 16 02            [ 2]  118 	ldw	y, (0x02, sp)
      0080C5 26 04            [ 1]  119 	jrne	00118$
      0080C7 0D 01            [ 1]  120 	tnz	(0x01, sp)
      0080C9 27 03            [ 1]  121 	jreq	00104$
      0080CB                        122 00118$:
                                    123 ;	main.c: 9: nop();
      0080CB 9D               [ 1]  124 	nop
      0080CC 20 DF            [ 2]  125 	jra	00101$
      0080CE                        126 00104$:
                                    127 ;	main.c: 10: }
      0080CE 1E 09            [ 2]  128 	ldw	x, (9, sp)
      0080D0 5B 0E            [ 2]  129 	addw	sp, #14
      0080D2 FC               [ 2]  130 	jp	(x)
                                    131 ;	main.c: 12: void convert_int_to_chars(int num, char* rx_int_chars) {
                                    132 ;	-----------------------------------------
                                    133 ;	 function convert_int_to_chars
                                    134 ;	-----------------------------------------
      0080D3                        135 _convert_int_to_chars:
      0080D3 52 0B            [ 2]  136 	sub	sp, #11
      0080D5 1F 0A            [ 2]  137 	ldw	(0x0a, sp), x
                                    138 ;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
      0080D7 16 0E            [ 2]  139 	ldw	y, (0x0e, sp)
      0080D9 17 01            [ 2]  140 	ldw	(0x01, sp), y
                                    141 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      0080DB 4B 0A            [ 1]  142 	push	#0x0a
      0080DD 4B 00            [ 1]  143 	push	#0x00
      0080DF 1E 0C            [ 2]  144 	ldw	x, (0x0c, sp)
                                    145 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      0080E1 CD 83 30         [ 4]  146 	call	__divsint
      0080E4 1F 03            [ 2]  147 	ldw	(0x03, sp), x
      0080E6 4B 0A            [ 1]  148 	push	#0x0a
      0080E8 4B 00            [ 1]  149 	push	#0x00
      0080EA 1E 0C            [ 2]  150 	ldw	x, (0x0c, sp)
                                    151 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      0080EC CD 83 18         [ 4]  152 	call	__modsint
      0080EF 90 93            [ 1]  153 	ldw	y, x
      0080F1 9F               [ 1]  154 	ld	a, xl
      0080F2 1E 01            [ 2]  155 	ldw	x, (0x01, sp)
      0080F4 5C               [ 1]  156 	incw	x
      0080F5 1F 05            [ 2]  157 	ldw	(0x05, sp), x
                                    158 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      0080F7 1E 01            [ 2]  159 	ldw	x, (0x01, sp)
      0080F9 5C               [ 1]  160 	incw	x
      0080FA 5C               [ 1]  161 	incw	x
      0080FB 1F 07            [ 2]  162 	ldw	(0x07, sp), x
      0080FD AB 30            [ 1]  163 	add	a, #0x30
      0080FF 6B 09            [ 1]  164 	ld	(0x09, sp), a
                                    165 ;	main.c: 13: if (num > 99) {
      008101 1E 0A            [ 2]  166 	ldw	x, (0x0a, sp)
      008103 A3 00 63         [ 2]  167 	cpw	x, #0x0063
      008106 2D 29            [ 1]  168 	jrsle	00105$
                                    169 ;	main.c: 15: rx_int_chars[0] = num / 100 + '0';
      008108 4B 64            [ 1]  170 	push	#0x64
      00810A 4B 00            [ 1]  171 	push	#0x00
      00810C 1E 0C            [ 2]  172 	ldw	x, (0x0c, sp)
      00810E CD 83 30         [ 4]  173 	call	__divsint
      008111 9F               [ 1]  174 	ld	a, xl
      008112 AB 30            [ 1]  175 	add	a, #0x30
      008114 1E 01            [ 2]  176 	ldw	x, (0x01, sp)
      008116 F7               [ 1]  177 	ld	(x), a
                                    178 ;	main.c: 16: rx_int_chars[1] = num / 10 % 10 + '0';
      008117 4B 0A            [ 1]  179 	push	#0x0a
      008119 4B 00            [ 1]  180 	push	#0x00
      00811B 1E 05            [ 2]  181 	ldw	x, (0x05, sp)
      00811D CD 83 18         [ 4]  182 	call	__modsint
      008120 9F               [ 1]  183 	ld	a, xl
      008121 AB 30            [ 1]  184 	add	a, #0x30
      008123 1E 05            [ 2]  185 	ldw	x, (0x05, sp)
      008125 F7               [ 1]  186 	ld	(x), a
                                    187 ;	main.c: 17: rx_int_chars[2] = num % 10 + '0';
      008126 1E 07            [ 2]  188 	ldw	x, (0x07, sp)
      008128 7B 09            [ 1]  189 	ld	a, (0x09, sp)
      00812A F7               [ 1]  190 	ld	(x), a
                                    191 ;	main.c: 18: rx_int_chars[3] ='\0';
      00812B 1E 01            [ 2]  192 	ldw	x, (0x01, sp)
      00812D 6F 03            [ 1]  193 	clr	(0x0003, x)
      00812F 20 22            [ 2]  194 	jra	00107$
      008131                        195 00105$:
                                    196 ;	main.c: 20: } else if (num > 9) {
      008131 1E 0A            [ 2]  197 	ldw	x, (0x0a, sp)
      008133 A3 00 09         [ 2]  198 	cpw	x, #0x0009
      008136 2D 11            [ 1]  199 	jrsle	00102$
                                    200 ;	main.c: 22: rx_int_chars[0] = num / 10 + '0';
      008138 7B 04            [ 1]  201 	ld	a, (0x04, sp)
      00813A AB 30            [ 1]  202 	add	a, #0x30
      00813C 1E 01            [ 2]  203 	ldw	x, (0x01, sp)
      00813E F7               [ 1]  204 	ld	(x), a
                                    205 ;	main.c: 23: rx_int_chars[1] = num % 10 + '0';
      00813F 1E 05            [ 2]  206 	ldw	x, (0x05, sp)
      008141 7B 09            [ 1]  207 	ld	a, (0x09, sp)
      008143 F7               [ 1]  208 	ld	(x), a
                                    209 ;	main.c: 24: rx_int_chars[2] ='\0';
      008144 1E 07            [ 2]  210 	ldw	x, (0x07, sp)
      008146 7F               [ 1]  211 	clr	(x)
      008147 20 0A            [ 2]  212 	jra	00107$
      008149                        213 00102$:
                                    214 ;	main.c: 29: rx_int_chars[0] = num + '0';
      008149 7B 0B            [ 1]  215 	ld	a, (0x0b, sp)
      00814B AB 30            [ 1]  216 	add	a, #0x30
      00814D 1E 01            [ 2]  217 	ldw	x, (0x01, sp)
      00814F F7               [ 1]  218 	ld	(x), a
                                    219 ;	main.c: 30: rx_int_chars[1] ='\0';
      008150 1E 05            [ 2]  220 	ldw	x, (0x05, sp)
      008152 7F               [ 1]  221 	clr	(x)
      008153                        222 00107$:
                                    223 ;	main.c: 32: }
      008153 1E 0C            [ 2]  224 	ldw	x, (12, sp)
      008155 5B 0F            [ 2]  225 	addw	sp, #15
      008157 FC               [ 2]  226 	jp	(x)
                                    227 ;	main.c: 34: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    228 ;	-----------------------------------------
                                    229 ;	 function convert_int_to_binary
                                    230 ;	-----------------------------------------
      008158                        231 _convert_int_to_binary:
      008158 52 04            [ 2]  232 	sub	sp, #4
      00815A 1F 01            [ 2]  233 	ldw	(0x01, sp), x
                                    234 ;	main.c: 36: for(int i = 7; i >= 0; i--) {
      00815C AE 00 07         [ 2]  235 	ldw	x, #0x0007
      00815F 1F 03            [ 2]  236 	ldw	(0x03, sp), x
      008161                        237 00103$:
      008161 0D 03            [ 1]  238 	tnz	(0x03, sp)
      008163 2B 22            [ 1]  239 	jrmi	00101$
                                    240 ;	main.c: 38: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008165 AE 00 07         [ 2]  241 	ldw	x, #0x0007
      008168 72 F0 03         [ 2]  242 	subw	x, (0x03, sp)
      00816B 72 FB 07         [ 2]  243 	addw	x, (0x07, sp)
      00816E 16 01            [ 2]  244 	ldw	y, (0x01, sp)
      008170 7B 04            [ 1]  245 	ld	a, (0x04, sp)
      008172 27 05            [ 1]  246 	jreq	00120$
      008174                        247 00119$:
      008174 90 57            [ 2]  248 	sraw	y
      008176 4A               [ 1]  249 	dec	a
      008177 26 FB            [ 1]  250 	jrne	00119$
      008179                        251 00120$:
      008179 90 9F            [ 1]  252 	ld	a, yl
      00817B A4 01            [ 1]  253 	and	a, #0x01
      00817D AB 30            [ 1]  254 	add	a, #0x30
      00817F F7               [ 1]  255 	ld	(x), a
                                    256 ;	main.c: 36: for(int i = 7; i >= 0; i--) {
      008180 1E 03            [ 2]  257 	ldw	x, (0x03, sp)
      008182 5A               [ 2]  258 	decw	x
      008183 1F 03            [ 2]  259 	ldw	(0x03, sp), x
      008185 20 DA            [ 2]  260 	jra	00103$
      008187                        261 00101$:
                                    262 ;	main.c: 40: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      008187 1E 07            [ 2]  263 	ldw	x, (0x07, sp)
      008189 6F 08            [ 1]  264 	clr	(0x0008, x)
                                    265 ;	main.c: 41: }
      00818B 1E 05            [ 2]  266 	ldw	x, (5, sp)
      00818D 5B 08            [ 2]  267 	addw	sp, #8
      00818F FC               [ 2]  268 	jp	(x)
                                    269 ;	main.c: 46: int uart_write_line(const char *str) {
                                    270 ;	-----------------------------------------
                                    271 ;	 function uart_write_line
                                    272 ;	-----------------------------------------
      008190                        273 _uart_write_line:
      008190 52 05            [ 2]  274 	sub	sp, #5
      008192 1F 03            [ 2]  275 	ldw	(0x03, sp), x
                                    276 ;	main.c: 48: for(i = 0; i < strlen(str); i++) {
      008194 0F 05            [ 1]  277 	clr	(0x05, sp)
      008196                        278 00106$:
      008196 1E 03            [ 2]  279 	ldw	x, (0x03, sp)
      008198 CD 83 0B         [ 4]  280 	call	_strlen
      00819B 1F 01            [ 2]  281 	ldw	(0x01, sp), x
      00819D 5F               [ 1]  282 	clrw	x
      00819E 7B 05            [ 1]  283 	ld	a, (0x05, sp)
      0081A0 97               [ 1]  284 	ld	xl, a
      0081A1 13 01            [ 2]  285 	cpw	x, (0x01, sp)
      0081A3 24 14            [ 1]  286 	jrnc	00104$
                                    287 ;	main.c: 49: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0081A5                        288 00101$:
      0081A5 C6 52 30         [ 1]  289 	ld	a, 0x5230
      0081A8 2A FB            [ 1]  290 	jrpl	00101$
                                    291 ;	main.c: 50: UART1_DR = str[i];
      0081AA 5F               [ 1]  292 	clrw	x
      0081AB 7B 05            [ 1]  293 	ld	a, (0x05, sp)
      0081AD 97               [ 1]  294 	ld	xl, a
      0081AE 72 FB 03         [ 2]  295 	addw	x, (0x03, sp)
      0081B1 F6               [ 1]  296 	ld	a, (x)
      0081B2 C7 52 31         [ 1]  297 	ld	0x5231, a
                                    298 ;	main.c: 48: for(i = 0; i < strlen(str); i++) {
      0081B5 0C 05            [ 1]  299 	inc	(0x05, sp)
      0081B7 20 DD            [ 2]  300 	jra	00106$
      0081B9                        301 00104$:
                                    302 ;	main.c: 52: return(i); // Bytes sent
      0081B9 7B 05            [ 1]  303 	ld	a, (0x05, sp)
      0081BB 5F               [ 1]  304 	clrw	x
      0081BC 97               [ 1]  305 	ld	xl, a
                                    306 ;	main.c: 53: }
      0081BD 5B 05            [ 2]  307 	addw	sp, #5
      0081BF 81               [ 4]  308 	ret
                                    309 ;	main.c: 55: void status_check(void){
                                    310 ;	-----------------------------------------
                                    311 ;	 function status_check
                                    312 ;	-----------------------------------------
      0081C0                        313 _status_check:
      0081C0 52 09            [ 2]  314 	sub	sp, #9
                                    315 ;	main.c: 56: char rx_binary_chars[9]={0};
      0081C2 0F 01            [ 1]  316 	clr	(0x01, sp)
      0081C4 0F 02            [ 1]  317 	clr	(0x02, sp)
      0081C6 0F 03            [ 1]  318 	clr	(0x03, sp)
      0081C8 0F 04            [ 1]  319 	clr	(0x04, sp)
      0081CA 0F 05            [ 1]  320 	clr	(0x05, sp)
      0081CC 0F 06            [ 1]  321 	clr	(0x06, sp)
      0081CE 0F 07            [ 1]  322 	clr	(0x07, sp)
      0081D0 0F 08            [ 1]  323 	clr	(0x08, sp)
      0081D2 0F 09            [ 1]  324 	clr	(0x09, sp)
                                    325 ;	main.c: 57: convert_int_to_binary(I2C_SR1, rx_binary_chars);
      0081D4 96               [ 1]  326 	ldw	x, sp
      0081D5 5C               [ 1]  327 	incw	x
      0081D6 51               [ 1]  328 	exgw	x, y
      0081D7 C6 52 17         [ 1]  329 	ld	a, 0x5217
      0081DA 5F               [ 1]  330 	clrw	x
      0081DB 90 89            [ 2]  331 	pushw	y
      0081DD 97               [ 1]  332 	ld	xl, a
      0081DE CD 81 58         [ 4]  333 	call	_convert_int_to_binary
                                    334 ;	main.c: 58: uart_write_line("SR1 -> ");
      0081E1 AE 80 2D         [ 2]  335 	ldw	x, #(___str_0+0)
      0081E4 CD 81 90         [ 4]  336 	call	_uart_write_line
                                    337 ;	main.c: 59: uart_write_line(rx_binary_chars);
      0081E7 96               [ 1]  338 	ldw	x, sp
      0081E8 5C               [ 1]  339 	incw	x
      0081E9 CD 81 90         [ 4]  340 	call	_uart_write_line
                                    341 ;	main.c: 60: uart_write_line(" <-\n");
      0081EC AE 80 35         [ 2]  342 	ldw	x, #(___str_1+0)
      0081EF CD 81 90         [ 4]  343 	call	_uart_write_line
                                    344 ;	main.c: 61: convert_int_to_binary(I2C_SR2, rx_binary_chars);
      0081F2 96               [ 1]  345 	ldw	x, sp
      0081F3 5C               [ 1]  346 	incw	x
      0081F4 51               [ 1]  347 	exgw	x, y
      0081F5 C6 52 18         [ 1]  348 	ld	a, 0x5218
      0081F8 5F               [ 1]  349 	clrw	x
      0081F9 90 89            [ 2]  350 	pushw	y
      0081FB 97               [ 1]  351 	ld	xl, a
      0081FC CD 81 58         [ 4]  352 	call	_convert_int_to_binary
                                    353 ;	main.c: 62: uart_write_line("SR2 -> ");
      0081FF AE 80 3A         [ 2]  354 	ldw	x, #(___str_2+0)
      008202 CD 81 90         [ 4]  355 	call	_uart_write_line
                                    356 ;	main.c: 63: uart_write_line(rx_binary_chars);
      008205 96               [ 1]  357 	ldw	x, sp
      008206 5C               [ 1]  358 	incw	x
      008207 CD 81 90         [ 4]  359 	call	_uart_write_line
                                    360 ;	main.c: 64: uart_write_line(" <-\n");
      00820A AE 80 35         [ 2]  361 	ldw	x, #(___str_1+0)
      00820D CD 81 90         [ 4]  362 	call	_uart_write_line
                                    363 ;	main.c: 65: convert_int_to_binary(I2C_SR3, rx_binary_chars);
      008210 96               [ 1]  364 	ldw	x, sp
      008211 5C               [ 1]  365 	incw	x
      008212 51               [ 1]  366 	exgw	x, y
      008213 C6 52 19         [ 1]  367 	ld	a, 0x5219
      008216 5F               [ 1]  368 	clrw	x
      008217 90 89            [ 2]  369 	pushw	y
      008219 97               [ 1]  370 	ld	xl, a
      00821A CD 81 58         [ 4]  371 	call	_convert_int_to_binary
                                    372 ;	main.c: 66: uart_write_line("SR3 -> ");
      00821D AE 80 42         [ 2]  373 	ldw	x, #(___str_3+0)
      008220 CD 81 90         [ 4]  374 	call	_uart_write_line
                                    375 ;	main.c: 67: uart_write_line(rx_binary_chars);
      008223 96               [ 1]  376 	ldw	x, sp
      008224 5C               [ 1]  377 	incw	x
      008225 CD 81 90         [ 4]  378 	call	_uart_write_line
                                    379 ;	main.c: 68: uart_write_line(" <-\n");
      008228 AE 80 35         [ 2]  380 	ldw	x, #(___str_1+0)
      00822B CD 81 90         [ 4]  381 	call	_uart_write_line
                                    382 ;	main.c: 69: convert_int_to_binary(I2C_CR1, rx_binary_chars);
      00822E 96               [ 1]  383 	ldw	x, sp
      00822F 5C               [ 1]  384 	incw	x
      008230 51               [ 1]  385 	exgw	x, y
      008231 C6 52 10         [ 1]  386 	ld	a, 0x5210
      008234 5F               [ 1]  387 	clrw	x
      008235 90 89            [ 2]  388 	pushw	y
      008237 97               [ 1]  389 	ld	xl, a
      008238 CD 81 58         [ 4]  390 	call	_convert_int_to_binary
                                    391 ;	main.c: 70: uart_write_line("CR1 -> ");
      00823B AE 80 4A         [ 2]  392 	ldw	x, #(___str_4+0)
      00823E CD 81 90         [ 4]  393 	call	_uart_write_line
                                    394 ;	main.c: 71: uart_write_line(rx_binary_chars);
      008241 96               [ 1]  395 	ldw	x, sp
      008242 5C               [ 1]  396 	incw	x
      008243 CD 81 90         [ 4]  397 	call	_uart_write_line
                                    398 ;	main.c: 72: uart_write_line(" <-\n");
      008246 AE 80 35         [ 2]  399 	ldw	x, #(___str_1+0)
      008249 CD 81 90         [ 4]  400 	call	_uart_write_line
                                    401 ;	main.c: 73: convert_int_to_binary(I2C_CR2, rx_binary_chars);
      00824C 96               [ 1]  402 	ldw	x, sp
      00824D 5C               [ 1]  403 	incw	x
      00824E 51               [ 1]  404 	exgw	x, y
      00824F C6 52 11         [ 1]  405 	ld	a, 0x5211
      008252 5F               [ 1]  406 	clrw	x
      008253 90 89            [ 2]  407 	pushw	y
      008255 97               [ 1]  408 	ld	xl, a
      008256 CD 81 58         [ 4]  409 	call	_convert_int_to_binary
                                    410 ;	main.c: 74: uart_write_line("CR2 -> ");
      008259 AE 80 52         [ 2]  411 	ldw	x, #(___str_5+0)
      00825C CD 81 90         [ 4]  412 	call	_uart_write_line
                                    413 ;	main.c: 75: uart_write_line(rx_binary_chars);
      00825F 96               [ 1]  414 	ldw	x, sp
      008260 5C               [ 1]  415 	incw	x
      008261 CD 81 90         [ 4]  416 	call	_uart_write_line
                                    417 ;	main.c: 76: uart_write_line(" <-\n");
      008264 AE 80 35         [ 2]  418 	ldw	x, #(___str_1+0)
      008267 CD 81 90         [ 4]  419 	call	_uart_write_line
                                    420 ;	main.c: 77: }
      00826A 5B 09            [ 2]  421 	addw	sp, #9
      00826C 81               [ 4]  422 	ret
                                    423 ;	main.c: 79: int main(void)
                                    424 ;	-----------------------------------------
                                    425 ;	 function main
                                    426 ;	-----------------------------------------
      00826D                        427 _main:
      00826D 52 05            [ 2]  428 	sub	sp, #5
                                    429 ;	main.c: 82: CLK_CKDIVR = 0;
      00826F 35 00 50 C6      [ 1]  430 	mov	0x50c6+0, #0x00
                                    431 ;	main.c: 85: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      008273 72 16 52 35      [ 1]  432 	bset	0x5235, #3
                                    433 ;	main.c: 87: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      008277 C6 52 36         [ 1]  434 	ld	a, 0x5236
      00827A A4 CF            [ 1]  435 	and	a, #0xcf
      00827C C7 52 36         [ 1]  436 	ld	0x5236, a
                                    437 ;	main.c: 89: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      00827F 35 03 52 33      [ 1]  438 	mov	0x5233+0, #0x03
      008283 35 68 52 32      [ 1]  439 	mov	0x5232+0, #0x68
                                    440 ;	main.c: 93: I2C_CR1 = I2C_CR1 & ~0x01;      // PE=0, disable I2C before setup
      008287 72 11 52 10      [ 1]  441 	bres	0x5210, #0
                                    442 ;	main.c: 97: I2C_CCRH = I2C_CCRH & ~0x80;    // set standart mode(100кHz)
      00828B 72 1F 52 1C      [ 1]  443 	bres	0x521c, #7
                                    444 ;	main.c: 98: I2C_OARH = I2C_OARH & ~0x80;    // 7-bit address mode
      00828F 72 1F 52 14      [ 1]  445 	bres	0x5214, #7
                                    446 ;	main.c: 99: I2C_OARH = I2C_OARH | 0x40;     // see reference manual
      008293 72 1C 52 14      [ 1]  447 	bset	0x5214, #6
                                    448 ;	main.c: 100: I2C_CR1 = I2C_CR1 | 0x01;       // PE=1, enable I2C
      008297 72 10 52 10      [ 1]  449 	bset	0x5210, #0
                                    450 ;	main.c: 101: status_check();
      00829B CD 81 C0         [ 4]  451 	call	_status_check
                                    452 ;	main.c: 106: uart_write_line("Start Scanning\n");
      00829E AE 80 5A         [ 2]  453 	ldw	x, #(___str_6+0)
      0082A1 CD 81 90         [ 4]  454 	call	_uart_write_line
                                    455 ;	main.c: 108: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
      0082A4 0F 05            [ 1]  456 	clr	(0x05, sp)
      0082A6                        457 00106$:
      0082A6 7B 05            [ 1]  458 	ld	a, (0x05, sp)
      0082A8 A1 FF            [ 1]  459 	cp	a, #0xff
      0082AA 24 59            [ 1]  460 	jrnc	00104$
                                    461 ;	main.c: 111: uart_write_line("_______Start______\n");
      0082AC AE 80 6A         [ 2]  462 	ldw	x, #(___str_7+0)
      0082AF CD 81 90         [ 4]  463 	call	_uart_write_line
                                    464 ;	main.c: 112: uart_write_line("Dev ->  ");
      0082B2 AE 80 7E         [ 2]  465 	ldw	x, #(___str_8+0)
      0082B5 CD 81 90         [ 4]  466 	call	_uart_write_line
                                    467 ;	main.c: 113: char rx_int_chars[4]={0};
      0082B8 0F 01            [ 1]  468 	clr	(0x01, sp)
      0082BA 0F 02            [ 1]  469 	clr	(0x02, sp)
      0082BC 0F 03            [ 1]  470 	clr	(0x03, sp)
      0082BE 0F 04            [ 1]  471 	clr	(0x04, sp)
                                    472 ;	main.c: 115: convert_int_to_chars(addr, rx_int_chars);
      0082C0 96               [ 1]  473 	ldw	x, sp
      0082C1 5C               [ 1]  474 	incw	x
      0082C2 51               [ 1]  475 	exgw	x, y
      0082C3 7B 05            [ 1]  476 	ld	a, (0x05, sp)
      0082C5 5F               [ 1]  477 	clrw	x
      0082C6 90 89            [ 2]  478 	pushw	y
      0082C8 97               [ 1]  479 	ld	xl, a
      0082C9 CD 80 D3         [ 4]  480 	call	_convert_int_to_chars
                                    481 ;	main.c: 116: uart_write_line(rx_int_chars);
      0082CC 96               [ 1]  482 	ldw	x, sp
      0082CD 5C               [ 1]  483 	incw	x
      0082CE CD 81 90         [ 4]  484 	call	_uart_write_line
                                    485 ;	main.c: 117: uart_write_line("  <- Dev\n");
      0082D1 AE 80 87         [ 2]  486 	ldw	x, #(___str_9+0)
      0082D4 CD 81 90         [ 4]  487 	call	_uart_write_line
                                    488 ;	main.c: 123: I2C_CR2 = I2C_CR2 | (1 << 2); // Set ACK bit
      0082D7 72 14 52 11      [ 1]  489 	bset	0x5211, #2
                                    490 ;	main.c: 126: I2C_CR2 = I2C_CR2 | (1 << 0); // START
      0082DB 72 10 52 11      [ 1]  491 	bset	0x5211, #0
                                    492 ;	main.c: 129: while (!(I2C_SR1 & (1 << 0)));
      0082DF                        493 00101$:
      0082DF 72 01 52 17 FB   [ 2]  494 	btjf	0x5217, #0, 00101$
                                    495 ;	main.c: 133: I2C_DR = I2C_DR | addr;
      0082E4 C6 52 16         [ 1]  496 	ld	a, 0x5216
      0082E7 1A 05            [ 1]  497 	or	a, (0x05, sp)
      0082E9 C7 52 16         [ 1]  498 	ld	0x5216, a
                                    499 ;	main.c: 140: I2C_SR1 = 0x00;
      0082EC 35 00 52 17      [ 1]  500 	mov	0x5217+0, #0x00
                                    501 ;	main.c: 141: I2C_SR3 = 0x00;
      0082F0 35 00 52 19      [ 1]  502 	mov	0x5219+0, #0x00
                                    503 ;	main.c: 142: I2C_CR2 = I2C_CR2 | (1 << 1); // STOP
      0082F4 72 12 52 11      [ 1]  504 	bset	0x5211, #1
                                    505 ;	main.c: 143: status_check();
      0082F8 CD 81 C0         [ 4]  506 	call	_status_check
                                    507 ;	main.c: 146: uart_write_line("_______Stop_______\n");
      0082FB AE 80 91         [ 2]  508 	ldw	x, #(___str_10+0)
      0082FE CD 81 90         [ 4]  509 	call	_uart_write_line
                                    510 ;	main.c: 108: for(uint8_t addr = 0x00; addr < 0xFF;addr++)
      008301 0C 05            [ 1]  511 	inc	(0x05, sp)
      008303 20 A1            [ 2]  512 	jra	00106$
      008305                        513 00104$:
                                    514 ;	main.c: 152: return 0;
      008305 5F               [ 1]  515 	clrw	x
                                    516 ;	main.c: 153: }
      008306 5B 05            [ 2]  517 	addw	sp, #5
      008308 81               [ 4]  518 	ret
                                    519 	.area CODE
                                    520 	.area CONST
                                    521 	.area CONST
      00802D                        522 ___str_0:
      00802D 53 52 31 20 2D 3E 20   523 	.ascii "SR1 -> "
      008034 00                     524 	.db 0x00
                                    525 	.area CODE
                                    526 	.area CONST
      008035                        527 ___str_1:
      008035 20 3C 2D               528 	.ascii " <-"
      008038 0A                     529 	.db 0x0a
      008039 00                     530 	.db 0x00
                                    531 	.area CODE
                                    532 	.area CONST
      00803A                        533 ___str_2:
      00803A 53 52 32 20 2D 3E 20   534 	.ascii "SR2 -> "
      008041 00                     535 	.db 0x00
                                    536 	.area CODE
                                    537 	.area CONST
      008042                        538 ___str_3:
      008042 53 52 33 20 2D 3E 20   539 	.ascii "SR3 -> "
      008049 00                     540 	.db 0x00
                                    541 	.area CODE
                                    542 	.area CONST
      00804A                        543 ___str_4:
      00804A 43 52 31 20 2D 3E 20   544 	.ascii "CR1 -> "
      008051 00                     545 	.db 0x00
                                    546 	.area CODE
                                    547 	.area CONST
      008052                        548 ___str_5:
      008052 43 52 32 20 2D 3E 20   549 	.ascii "CR2 -> "
      008059 00                     550 	.db 0x00
                                    551 	.area CODE
                                    552 	.area CONST
      00805A                        553 ___str_6:
      00805A 53 74 61 72 74 20 53   554 	.ascii "Start Scanning"
             63 61 6E 6E 69 6E 67
      008068 0A                     555 	.db 0x0a
      008069 00                     556 	.db 0x00
                                    557 	.area CODE
                                    558 	.area CONST
      00806A                        559 ___str_7:
      00806A 5F 5F 5F 5F 5F 5F 5F   560 	.ascii "_______Start______"
             53 74 61 72 74 5F 5F
             5F 5F 5F 5F
      00807C 0A                     561 	.db 0x0a
      00807D 00                     562 	.db 0x00
                                    563 	.area CODE
                                    564 	.area CONST
      00807E                        565 ___str_8:
      00807E 44 65 76 20 2D 3E 20   566 	.ascii "Dev ->  "
             20
      008086 00                     567 	.db 0x00
                                    568 	.area CODE
                                    569 	.area CONST
      008087                        570 ___str_9:
      008087 20 20 3C 2D 20 44 65   571 	.ascii "  <- Dev"
             76
      00808F 0A                     572 	.db 0x0a
      008090 00                     573 	.db 0x00
                                    574 	.area CODE
                                    575 	.area CONST
      008091                        576 ___str_10:
      008091 5F 5F 5F 5F 5F 5F 5F   577 	.ascii "_______Stop_______"
             53 74 6F 70 5F 5F 5F
             5F 5F 5F 5F
      0080A3 0A                     578 	.db 0x0a
      0080A4 00                     579 	.db 0x00
                                    580 	.area CODE
                                    581 	.area INITIALIZER
                                    582 	.area CABS (ABS)
