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
                                     13 	.globl _uart_init
                                     14 	.globl _status_check
                                     15 	.globl _convert_int_to_binary
                                     16 	.globl _uart_write
                                     17 	.globl _UART_RX
                                     18 	.globl _UART_TX
                                     19 	.globl _delay
                                     20 	.globl _strlen
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area INITIALIZED
                                     29 ;--------------------------------------------------------
                                     30 ; Stack segment in internal ram
                                     31 ;--------------------------------------------------------
                                     32 	.area SSEG
      000001                         33 __start__stack:
      000001                         34 	.ds	1
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; absolute external ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DABS (ABS)
                                     40 
                                     41 ; default segment ordering for linker
                                     42 	.area HOME
                                     43 	.area GSINIT
                                     44 	.area GSFINAL
                                     45 	.area CONST
                                     46 	.area INITIALIZER
                                     47 	.area CODE
                                     48 
                                     49 ;--------------------------------------------------------
                                     50 ; interrupt vector
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
      008000                         53 __interrupt_vect:
      008000 82 00 80 07             54 	int s_GSINIT ; reset
                                     55 ;--------------------------------------------------------
                                     56 ; global & static initialisations
                                     57 ;--------------------------------------------------------
                                     58 	.area HOME
                                     59 	.area GSINIT
                                     60 	.area GSFINAL
                                     61 	.area GSINIT
      008007 CD 85 7E         [ 4]   62 	call	___sdcc_external_startup
      00800A 4D               [ 1]   63 	tnz	a
      00800B 27 03            [ 1]   64 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   65 	jp	__sdcc_program_startup
      008010                         66 __sdcc_init_data:
                                     67 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   68 	ldw x, #l_DATA
      008013 27 07            [ 1]   69 	jreq	00002$
      008015                         70 00001$:
      008015 72 4F 00 00      [ 1]   71 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   72 	decw x
      00801A 26 F9            [ 1]   73 	jrne	00001$
      00801C                         74 00002$:
      00801C AE 00 00         [ 2]   75 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   76 	jreq	00004$
      008021                         77 00003$:
      008021 D6 80 B0         [ 1]   78 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   79 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   80 	decw	x
      008028 26 F7            [ 1]   81 	jrne	00003$
      00802A                         82 00004$:
                                     83 ; stm8_genXINIT() end
                                     84 	.area GSFINAL
      00802A CC 80 04         [ 2]   85 	jp	__sdcc_program_startup
                                     86 ;--------------------------------------------------------
                                     87 ; Home
                                     88 ;--------------------------------------------------------
                                     89 	.area HOME
                                     90 	.area HOME
      008004                         91 __sdcc_program_startup:
      008004 CC 85 65         [ 2]   92 	jp	_main
                                     93 ;	return from main will return to caller
                                     94 ;--------------------------------------------------------
                                     95 ; code
                                     96 ;--------------------------------------------------------
                                     97 	.area CODE
                                     98 ;	main.c: 6: void delay(unsigned long count) {
                                     99 ;	-----------------------------------------
                                    100 ;	 function delay
                                    101 ;	-----------------------------------------
      0080B1                        102 _delay:
      0080B1 52 08            [ 2]  103 	sub	sp, #8
                                    104 ;	main.c: 7: while (count--)
      0080B3 16 0D            [ 2]  105 	ldw	y, (0x0d, sp)
      0080B5 17 07            [ 2]  106 	ldw	(0x07, sp), y
      0080B7 1E 0B            [ 2]  107 	ldw	x, (0x0b, sp)
      0080B9                        108 00101$:
      0080B9 1F 01            [ 2]  109 	ldw	(0x01, sp), x
      0080BB 7B 07            [ 1]  110 	ld	a, (0x07, sp)
      0080BD 6B 03            [ 1]  111 	ld	(0x03, sp), a
      0080BF 7B 08            [ 1]  112 	ld	a, (0x08, sp)
      0080C1 16 07            [ 2]  113 	ldw	y, (0x07, sp)
      0080C3 72 A2 00 01      [ 2]  114 	subw	y, #0x0001
      0080C7 17 07            [ 2]  115 	ldw	(0x07, sp), y
      0080C9 24 01            [ 1]  116 	jrnc	00117$
      0080CB 5A               [ 2]  117 	decw	x
      0080CC                        118 00117$:
      0080CC 4D               [ 1]  119 	tnz	a
      0080CD 26 08            [ 1]  120 	jrne	00118$
      0080CF 16 02            [ 2]  121 	ldw	y, (0x02, sp)
      0080D1 26 04            [ 1]  122 	jrne	00118$
      0080D3 0D 01            [ 1]  123 	tnz	(0x01, sp)
      0080D5 27 03            [ 1]  124 	jreq	00104$
      0080D7                        125 00118$:
                                    126 ;	main.c: 8: nop();
      0080D7 9D               [ 1]  127 	nop
      0080D8 20 DF            [ 2]  128 	jra	00101$
      0080DA                        129 00104$:
                                    130 ;	main.c: 9: }
      0080DA 1E 09            [ 2]  131 	ldw	x, (9, sp)
      0080DC 5B 0E            [ 2]  132 	addw	sp, #14
      0080DE FC               [ 2]  133 	jp	(x)
                                    134 ;	main.c: 10: void UART_TX(unsigned char value)
                                    135 ;	-----------------------------------------
                                    136 ;	 function UART_TX
                                    137 ;	-----------------------------------------
      0080DF                        138 _UART_TX:
                                    139 ;	main.c: 12: UART1_DR = value;
      0080DF C7 52 31         [ 1]  140 	ld	0x5231, a
                                    141 ;	main.c: 13: while(!(UART1_SR & UART_SR_TXE));
      0080E2                        142 00101$:
      0080E2 C6 52 30         [ 1]  143 	ld	a, 0x5230
      0080E5 2A FB            [ 1]  144 	jrpl	00101$
                                    145 ;	main.c: 14: }
      0080E7 81               [ 4]  146 	ret
                                    147 ;	main.c: 15: unsigned char UART_RX(void)
                                    148 ;	-----------------------------------------
                                    149 ;	 function UART_RX
                                    150 ;	-----------------------------------------
      0080E8                        151 _UART_RX:
                                    152 ;	main.c: 17: while(!(UART1_SR & UART_SR_RXNE));
      0080E8                        153 00101$:
      0080E8 72 0B 52 30 FB   [ 2]  154 	btjf	0x5230, #5, 00101$
                                    155 ;	main.c: 18: return UART1_DR;
      0080ED C6 52 31         [ 1]  156 	ld	a, 0x5231
                                    157 ;	main.c: 19: }
      0080F0 81               [ 4]  158 	ret
                                    159 ;	main.c: 20: int uart_write(const char *str) {
                                    160 ;	-----------------------------------------
                                    161 ;	 function uart_write
                                    162 ;	-----------------------------------------
      0080F1                        163 _uart_write:
      0080F1 52 05            [ 2]  164 	sub	sp, #5
      0080F3 1F 03            [ 2]  165 	ldw	(0x03, sp), x
                                    166 ;	main.c: 23: for(i = 0; i < strlen(str); i++) {
      0080F5 0F 05            [ 1]  167 	clr	(0x05, sp)
      0080F7                        168 00103$:
      0080F7 1E 03            [ 2]  169 	ldw	x, (0x03, sp)
      0080F9 CD 85 80         [ 4]  170 	call	_strlen
      0080FC 1F 01            [ 2]  171 	ldw	(0x01, sp), x
      0080FE 7B 05            [ 1]  172 	ld	a, (0x05, sp)
      008100 5F               [ 1]  173 	clrw	x
      008101 97               [ 1]  174 	ld	xl, a
      008102 13 01            [ 2]  175 	cpw	x, (0x01, sp)
      008104 24 0F            [ 1]  176 	jrnc	00101$
                                    177 ;	main.c: 25: UART_TX(str[i]);
      008106 5F               [ 1]  178 	clrw	x
      008107 7B 05            [ 1]  179 	ld	a, (0x05, sp)
      008109 97               [ 1]  180 	ld	xl, a
      00810A 72 FB 03         [ 2]  181 	addw	x, (0x03, sp)
      00810D F6               [ 1]  182 	ld	a, (x)
      00810E CD 80 DF         [ 4]  183 	call	_UART_TX
                                    184 ;	main.c: 23: for(i = 0; i < strlen(str); i++) {
      008111 0C 05            [ 1]  185 	inc	(0x05, sp)
      008113 20 E2            [ 2]  186 	jra	00103$
      008115                        187 00101$:
                                    188 ;	main.c: 27: return(i); // Bytes sent
      008115 7B 05            [ 1]  189 	ld	a, (0x05, sp)
      008117 5F               [ 1]  190 	clrw	x
      008118 97               [ 1]  191 	ld	xl, a
                                    192 ;	main.c: 28: }
      008119 5B 05            [ 2]  193 	addw	sp, #5
      00811B 81               [ 4]  194 	ret
                                    195 ;	main.c: 30: void convert_int_to_binary(int num, char* rx_binary_chars) {
                                    196 ;	-----------------------------------------
                                    197 ;	 function convert_int_to_binary
                                    198 ;	-----------------------------------------
      00811C                        199 _convert_int_to_binary:
      00811C 52 04            [ 2]  200 	sub	sp, #4
      00811E 1F 01            [ 2]  201 	ldw	(0x01, sp), x
                                    202 ;	main.c: 32: for(int i = 7; i >= 0; i--) {
      008120 AE 00 07         [ 2]  203 	ldw	x, #0x0007
      008123 1F 03            [ 2]  204 	ldw	(0x03, sp), x
      008125                        205 00103$:
      008125 0D 03            [ 1]  206 	tnz	(0x03, sp)
      008127 2B 22            [ 1]  207 	jrmi	00101$
                                    208 ;	main.c: 34: rx_binary_chars[7 - i] = ((num >> i) & 1) + '0';
      008129 AE 00 07         [ 2]  209 	ldw	x, #0x0007
      00812C 72 F0 03         [ 2]  210 	subw	x, (0x03, sp)
      00812F 72 FB 07         [ 2]  211 	addw	x, (0x07, sp)
      008132 16 01            [ 2]  212 	ldw	y, (0x01, sp)
      008134 7B 04            [ 1]  213 	ld	a, (0x04, sp)
      008136 27 05            [ 1]  214 	jreq	00120$
      008138                        215 00119$:
      008138 90 57            [ 2]  216 	sraw	y
      00813A 4A               [ 1]  217 	dec	a
      00813B 26 FB            [ 1]  218 	jrne	00119$
      00813D                        219 00120$:
      00813D 90 9F            [ 1]  220 	ld	a, yl
      00813F A4 01            [ 1]  221 	and	a, #0x01
      008141 AB 30            [ 1]  222 	add	a, #0x30
      008143 F7               [ 1]  223 	ld	(x), a
                                    224 ;	main.c: 32: for(int i = 7; i >= 0; i--) {
      008144 1E 03            [ 2]  225 	ldw	x, (0x03, sp)
      008146 5A               [ 2]  226 	decw	x
      008147 1F 03            [ 2]  227 	ldw	(0x03, sp), x
      008149 20 DA            [ 2]  228 	jra	00103$
      00814B                        229 00101$:
                                    230 ;	main.c: 36: rx_binary_chars[8] = '\0'; // Добавляем символ конца строки
      00814B 1E 07            [ 2]  231 	ldw	x, (0x07, sp)
      00814D 6F 08            [ 1]  232 	clr	(0x0008, x)
                                    233 ;	main.c: 37: }
      00814F 1E 05            [ 2]  234 	ldw	x, (5, sp)
      008151 5B 08            [ 2]  235 	addw	sp, #8
      008153 FC               [ 2]  236 	jp	(x)
                                    237 ;	main.c: 39: void status_check(void){
                                    238 ;	-----------------------------------------
                                    239 ;	 function status_check
                                    240 ;	-----------------------------------------
      008154                        241 _status_check:
      008154 52 09            [ 2]  242 	sub	sp, #9
                                    243 ;	main.c: 40: char rx_binary_chars[9]={0};
      008156 0F 01            [ 1]  244 	clr	(0x01, sp)
      008158 0F 02            [ 1]  245 	clr	(0x02, sp)
      00815A 0F 03            [ 1]  246 	clr	(0x03, sp)
      00815C 0F 04            [ 1]  247 	clr	(0x04, sp)
      00815E 0F 05            [ 1]  248 	clr	(0x05, sp)
      008160 0F 06            [ 1]  249 	clr	(0x06, sp)
      008162 0F 07            [ 1]  250 	clr	(0x07, sp)
      008164 0F 08            [ 1]  251 	clr	(0x08, sp)
      008166 0F 09            [ 1]  252 	clr	(0x09, sp)
                                    253 ;	main.c: 41: uart_write("UART_REGS >.<\n");
      008168 AE 80 2D         [ 2]  254 	ldw	x, #(___str_0+0)
      00816B CD 80 F1         [ 4]  255 	call	_uart_write
                                    256 ;	main.c: 42: convert_int_to_binary(UART1_SR, rx_binary_chars);
      00816E 96               [ 1]  257 	ldw	x, sp
      00816F 5C               [ 1]  258 	incw	x
      008170 51               [ 1]  259 	exgw	x, y
      008171 C6 52 30         [ 1]  260 	ld	a, 0x5230
      008174 5F               [ 1]  261 	clrw	x
      008175 90 89            [ 2]  262 	pushw	y
      008177 97               [ 1]  263 	ld	xl, a
      008178 CD 81 1C         [ 4]  264 	call	_convert_int_to_binary
                                    265 ;	main.c: 43: uart_write("\nSR -> ");
      00817B AE 80 3C         [ 2]  266 	ldw	x, #(___str_1+0)
      00817E CD 80 F1         [ 4]  267 	call	_uart_write
                                    268 ;	main.c: 44: uart_write(rx_binary_chars);
      008181 96               [ 1]  269 	ldw	x, sp
      008182 5C               [ 1]  270 	incw	x
      008183 CD 80 F1         [ 4]  271 	call	_uart_write
                                    272 ;	main.c: 45: uart_write(" <-\n");
      008186 AE 80 44         [ 2]  273 	ldw	x, #(___str_2+0)
      008189 CD 80 F1         [ 4]  274 	call	_uart_write
                                    275 ;	main.c: 46: convert_int_to_binary(UART1_DR, rx_binary_chars);
      00818C 96               [ 1]  276 	ldw	x, sp
      00818D 5C               [ 1]  277 	incw	x
      00818E 51               [ 1]  278 	exgw	x, y
      00818F C6 52 31         [ 1]  279 	ld	a, 0x5231
      008192 5F               [ 1]  280 	clrw	x
      008193 90 89            [ 2]  281 	pushw	y
      008195 97               [ 1]  282 	ld	xl, a
      008196 CD 81 1C         [ 4]  283 	call	_convert_int_to_binary
                                    284 ;	main.c: 47: uart_write("DR -> ");
      008199 AE 80 49         [ 2]  285 	ldw	x, #(___str_3+0)
      00819C CD 80 F1         [ 4]  286 	call	_uart_write
                                    287 ;	main.c: 48: uart_write(rx_binary_chars);
      00819F 96               [ 1]  288 	ldw	x, sp
      0081A0 5C               [ 1]  289 	incw	x
      0081A1 CD 80 F1         [ 4]  290 	call	_uart_write
                                    291 ;	main.c: 49: uart_write(" <-\n");
      0081A4 AE 80 44         [ 2]  292 	ldw	x, #(___str_2+0)
      0081A7 CD 80 F1         [ 4]  293 	call	_uart_write
                                    294 ;	main.c: 50: convert_int_to_binary(UART1_BRR1, rx_binary_chars);
      0081AA 96               [ 1]  295 	ldw	x, sp
      0081AB 5C               [ 1]  296 	incw	x
      0081AC 51               [ 1]  297 	exgw	x, y
      0081AD C6 52 32         [ 1]  298 	ld	a, 0x5232
      0081B0 5F               [ 1]  299 	clrw	x
      0081B1 90 89            [ 2]  300 	pushw	y
      0081B3 97               [ 1]  301 	ld	xl, a
      0081B4 CD 81 1C         [ 4]  302 	call	_convert_int_to_binary
                                    303 ;	main.c: 51: uart_write("BRR1 -> ");
      0081B7 AE 80 50         [ 2]  304 	ldw	x, #(___str_4+0)
      0081BA CD 80 F1         [ 4]  305 	call	_uart_write
                                    306 ;	main.c: 52: uart_write(rx_binary_chars);
      0081BD 96               [ 1]  307 	ldw	x, sp
      0081BE 5C               [ 1]  308 	incw	x
      0081BF CD 80 F1         [ 4]  309 	call	_uart_write
                                    310 ;	main.c: 53: uart_write(" <-\n");
      0081C2 AE 80 44         [ 2]  311 	ldw	x, #(___str_2+0)
      0081C5 CD 80 F1         [ 4]  312 	call	_uart_write
                                    313 ;	main.c: 54: convert_int_to_binary(UART1_BRR2, rx_binary_chars);
      0081C8 96               [ 1]  314 	ldw	x, sp
      0081C9 5C               [ 1]  315 	incw	x
      0081CA 51               [ 1]  316 	exgw	x, y
      0081CB C6 52 33         [ 1]  317 	ld	a, 0x5233
      0081CE 5F               [ 1]  318 	clrw	x
      0081CF 90 89            [ 2]  319 	pushw	y
      0081D1 97               [ 1]  320 	ld	xl, a
      0081D2 CD 81 1C         [ 4]  321 	call	_convert_int_to_binary
                                    322 ;	main.c: 55: uart_write("BRR2 -> ");
      0081D5 AE 80 59         [ 2]  323 	ldw	x, #(___str_5+0)
      0081D8 CD 80 F1         [ 4]  324 	call	_uart_write
                                    325 ;	main.c: 56: uart_write(rx_binary_chars);
      0081DB 96               [ 1]  326 	ldw	x, sp
      0081DC 5C               [ 1]  327 	incw	x
      0081DD CD 80 F1         [ 4]  328 	call	_uart_write
                                    329 ;	main.c: 57: uart_write(" <-\n");
      0081E0 AE 80 44         [ 2]  330 	ldw	x, #(___str_2+0)
      0081E3 CD 80 F1         [ 4]  331 	call	_uart_write
                                    332 ;	main.c: 58: convert_int_to_binary(UART1_CR1, rx_binary_chars);
      0081E6 96               [ 1]  333 	ldw	x, sp
      0081E7 5C               [ 1]  334 	incw	x
      0081E8 51               [ 1]  335 	exgw	x, y
      0081E9 C6 52 34         [ 1]  336 	ld	a, 0x5234
      0081EC 5F               [ 1]  337 	clrw	x
      0081ED 90 89            [ 2]  338 	pushw	y
      0081EF 97               [ 1]  339 	ld	xl, a
      0081F0 CD 81 1C         [ 4]  340 	call	_convert_int_to_binary
                                    341 ;	main.c: 59: uart_write("CR1 -> ");
      0081F3 AE 80 62         [ 2]  342 	ldw	x, #(___str_6+0)
      0081F6 CD 80 F1         [ 4]  343 	call	_uart_write
                                    344 ;	main.c: 60: uart_write(rx_binary_chars);
      0081F9 96               [ 1]  345 	ldw	x, sp
      0081FA 5C               [ 1]  346 	incw	x
      0081FB CD 80 F1         [ 4]  347 	call	_uart_write
                                    348 ;	main.c: 61: uart_write(" <-\n");
      0081FE AE 80 44         [ 2]  349 	ldw	x, #(___str_2+0)
      008201 CD 80 F1         [ 4]  350 	call	_uart_write
                                    351 ;	main.c: 62: convert_int_to_binary(UART1_CR2, rx_binary_chars);
      008204 96               [ 1]  352 	ldw	x, sp
      008205 5C               [ 1]  353 	incw	x
      008206 51               [ 1]  354 	exgw	x, y
      008207 C6 52 35         [ 1]  355 	ld	a, 0x5235
      00820A 5F               [ 1]  356 	clrw	x
      00820B 90 89            [ 2]  357 	pushw	y
      00820D 97               [ 1]  358 	ld	xl, a
      00820E CD 81 1C         [ 4]  359 	call	_convert_int_to_binary
                                    360 ;	main.c: 63: uart_write("CR2 -> ");
      008211 AE 80 6A         [ 2]  361 	ldw	x, #(___str_7+0)
      008214 CD 80 F1         [ 4]  362 	call	_uart_write
                                    363 ;	main.c: 64: uart_write(rx_binary_chars);
      008217 96               [ 1]  364 	ldw	x, sp
      008218 5C               [ 1]  365 	incw	x
      008219 CD 80 F1         [ 4]  366 	call	_uart_write
                                    367 ;	main.c: 65: uart_write(" <-\n");
      00821C AE 80 44         [ 2]  368 	ldw	x, #(___str_2+0)
      00821F CD 80 F1         [ 4]  369 	call	_uart_write
                                    370 ;	main.c: 66: convert_int_to_binary(UART1_CR3, rx_binary_chars);
      008222 96               [ 1]  371 	ldw	x, sp
      008223 5C               [ 1]  372 	incw	x
      008224 51               [ 1]  373 	exgw	x, y
      008225 C6 52 36         [ 1]  374 	ld	a, 0x5236
      008228 5F               [ 1]  375 	clrw	x
      008229 90 89            [ 2]  376 	pushw	y
      00822B 97               [ 1]  377 	ld	xl, a
      00822C CD 81 1C         [ 4]  378 	call	_convert_int_to_binary
                                    379 ;	main.c: 67: uart_write("CR3 -> ");
      00822F AE 80 72         [ 2]  380 	ldw	x, #(___str_8+0)
      008232 CD 80 F1         [ 4]  381 	call	_uart_write
                                    382 ;	main.c: 68: uart_write(rx_binary_chars);
      008235 96               [ 1]  383 	ldw	x, sp
      008236 5C               [ 1]  384 	incw	x
      008237 CD 80 F1         [ 4]  385 	call	_uart_write
                                    386 ;	main.c: 69: uart_write(" <-\n");
      00823A AE 80 44         [ 2]  387 	ldw	x, #(___str_2+0)
      00823D CD 80 F1         [ 4]  388 	call	_uart_write
                                    389 ;	main.c: 70: convert_int_to_binary(UART1_CR4, rx_binary_chars);
      008240 96               [ 1]  390 	ldw	x, sp
      008241 5C               [ 1]  391 	incw	x
      008242 51               [ 1]  392 	exgw	x, y
      008243 C6 52 37         [ 1]  393 	ld	a, 0x5237
      008246 5F               [ 1]  394 	clrw	x
      008247 90 89            [ 2]  395 	pushw	y
      008249 97               [ 1]  396 	ld	xl, a
      00824A CD 81 1C         [ 4]  397 	call	_convert_int_to_binary
                                    398 ;	main.c: 71: uart_write("CR4 -> ");
      00824D AE 80 7A         [ 2]  399 	ldw	x, #(___str_9+0)
      008250 CD 80 F1         [ 4]  400 	call	_uart_write
                                    401 ;	main.c: 72: uart_write(rx_binary_chars);
      008253 96               [ 1]  402 	ldw	x, sp
      008254 5C               [ 1]  403 	incw	x
      008255 CD 80 F1         [ 4]  404 	call	_uart_write
                                    405 ;	main.c: 73: uart_write(" <-\n");
      008258 AE 80 44         [ 2]  406 	ldw	x, #(___str_2+0)
      00825B CD 80 F1         [ 4]  407 	call	_uart_write
                                    408 ;	main.c: 74: convert_int_to_binary(UART1_CR5, rx_binary_chars);
      00825E 96               [ 1]  409 	ldw	x, sp
      00825F 5C               [ 1]  410 	incw	x
      008260 51               [ 1]  411 	exgw	x, y
      008261 C6 52 38         [ 1]  412 	ld	a, 0x5238
      008264 5F               [ 1]  413 	clrw	x
      008265 90 89            [ 2]  414 	pushw	y
      008267 97               [ 1]  415 	ld	xl, a
      008268 CD 81 1C         [ 4]  416 	call	_convert_int_to_binary
                                    417 ;	main.c: 75: uart_write("CR5 -> ");
      00826B AE 80 82         [ 2]  418 	ldw	x, #(___str_10+0)
      00826E CD 80 F1         [ 4]  419 	call	_uart_write
                                    420 ;	main.c: 76: uart_write(rx_binary_chars);
      008271 96               [ 1]  421 	ldw	x, sp
      008272 5C               [ 1]  422 	incw	x
      008273 CD 80 F1         [ 4]  423 	call	_uart_write
                                    424 ;	main.c: 77: uart_write(" <-\n");
      008276 AE 80 44         [ 2]  425 	ldw	x, #(___str_2+0)
      008279 CD 80 F1         [ 4]  426 	call	_uart_write
                                    427 ;	main.c: 78: convert_int_to_binary(UART1_GTR, rx_binary_chars);
      00827C 96               [ 1]  428 	ldw	x, sp
      00827D 5C               [ 1]  429 	incw	x
      00827E 51               [ 1]  430 	exgw	x, y
      00827F C6 52 39         [ 1]  431 	ld	a, 0x5239
      008282 5F               [ 1]  432 	clrw	x
      008283 90 89            [ 2]  433 	pushw	y
      008285 97               [ 1]  434 	ld	xl, a
      008286 CD 81 1C         [ 4]  435 	call	_convert_int_to_binary
                                    436 ;	main.c: 79: uart_write("GTR -> ");
      008289 AE 80 8A         [ 2]  437 	ldw	x, #(___str_11+0)
      00828C CD 80 F1         [ 4]  438 	call	_uart_write
                                    439 ;	main.c: 80: uart_write(rx_binary_chars);
      00828F 96               [ 1]  440 	ldw	x, sp
      008290 5C               [ 1]  441 	incw	x
      008291 CD 80 F1         [ 4]  442 	call	_uart_write
                                    443 ;	main.c: 81: uart_write(" <-\n");
      008294 AE 80 44         [ 2]  444 	ldw	x, #(___str_2+0)
      008297 CD 80 F1         [ 4]  445 	call	_uart_write
                                    446 ;	main.c: 82: convert_int_to_binary(UART1_PSCR, rx_binary_chars);
      00829A 96               [ 1]  447 	ldw	x, sp
      00829B 5C               [ 1]  448 	incw	x
      00829C 51               [ 1]  449 	exgw	x, y
      00829D C6 52 3A         [ 1]  450 	ld	a, 0x523a
      0082A0 5F               [ 1]  451 	clrw	x
      0082A1 90 89            [ 2]  452 	pushw	y
      0082A3 97               [ 1]  453 	ld	xl, a
      0082A4 CD 81 1C         [ 4]  454 	call	_convert_int_to_binary
                                    455 ;	main.c: 83: uart_write("PSCR -> ");
      0082A7 AE 80 92         [ 2]  456 	ldw	x, #(___str_12+0)
      0082AA CD 80 F1         [ 4]  457 	call	_uart_write
                                    458 ;	main.c: 84: uart_write(rx_binary_chars);
      0082AD 96               [ 1]  459 	ldw	x, sp
      0082AE 5C               [ 1]  460 	incw	x
      0082AF CD 80 F1         [ 4]  461 	call	_uart_write
                                    462 ;	main.c: 85: uart_write(" <-\n");
      0082B2 AE 80 44         [ 2]  463 	ldw	x, #(___str_2+0)
      0082B5 CD 80 F1         [ 4]  464 	call	_uart_write
                                    465 ;	main.c: 86: }
      0082B8 5B 09            [ 2]  466 	addw	sp, #9
      0082BA 81               [ 4]  467 	ret
                                    468 ;	main.c: 92: void uart_init(void){
                                    469 ;	-----------------------------------------
                                    470 ;	 function uart_init
                                    471 ;	-----------------------------------------
      0082BB                        472 _uart_init:
                                    473 ;	main.c: 93: CLK_CKDIVR = 0;
      0082BB 35 00 50 C6      [ 1]  474 	mov	0x50c6+0, #0x00
                                    475 ;	main.c: 96: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0082BF 72 16 52 35      [ 1]  476 	bset	0x5235, #3
                                    477 ;	main.c: 97: UART1_CR2 |= UART_CR2_REN; // Receiver enable
      0082C3 72 14 52 35      [ 1]  478 	bset	0x5235, #2
                                    479 ;	main.c: 98: UART1_CR2 |= UART_CR2_ILIEN; //String Enable
      0082C7 72 18 52 35      [ 1]  480 	bset	0x5235, #4
                                    481 ;	main.c: 99: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0082CB C6 52 36         [ 1]  482 	ld	a, 0x5236
      0082CE A4 CF            [ 1]  483 	and	a, #0xcf
      0082D0 C7 52 36         [ 1]  484 	ld	0x5236, a
                                    485 ;	main.c: 101: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0082D3 35 03 52 33      [ 1]  486 	mov	0x5233+0, #0x03
      0082D7 35 68 52 32      [ 1]  487 	mov	0x5232+0, #0x68
                                    488 ;	main.c: 102: }
      0082DB 81               [ 4]  489 	ret
                                    490 ;	main.c: 104: int uart_read(void)
                                    491 ;	-----------------------------------------
                                    492 ;	 function uart_read
                                    493 ;	-----------------------------------------
      0082DC                        494 _uart_read:
      0082DC 90 96            [ 1]  495 	ldw	y, sp
      0082DE 72 A2 00 09      [ 2]  496 	subw	y, #9
      0082E2 52 FF            [ 2]  497 	sub	sp, #255
      0082E4 52 05            [ 2]  498 	sub	sp, #5
                                    499 ;	main.c: 107: char buffer[256]={0};
      0082E6 0F 01            [ 1]  500 	clr	(0x01, sp)
      0082E8 0F 02            [ 1]  501 	clr	(0x02, sp)
      0082EA 0F 03            [ 1]  502 	clr	(0x03, sp)
      0082EC 0F 04            [ 1]  503 	clr	(0x04, sp)
      0082EE 0F 05            [ 1]  504 	clr	(0x05, sp)
      0082F0 0F 06            [ 1]  505 	clr	(0x06, sp)
      0082F2 0F 07            [ 1]  506 	clr	(0x07, sp)
      0082F4 0F 08            [ 1]  507 	clr	(0x08, sp)
      0082F6 0F 09            [ 1]  508 	clr	(0x09, sp)
      0082F8 0F 0A            [ 1]  509 	clr	(0x0a, sp)
      0082FA 0F 0B            [ 1]  510 	clr	(0x0b, sp)
      0082FC 0F 0C            [ 1]  511 	clr	(0x0c, sp)
      0082FE 0F 0D            [ 1]  512 	clr	(0x0d, sp)
      008300 0F 0E            [ 1]  513 	clr	(0x0e, sp)
      008302 0F 0F            [ 1]  514 	clr	(0x0f, sp)
      008304 0F 10            [ 1]  515 	clr	(0x10, sp)
      008306 0F 11            [ 1]  516 	clr	(0x11, sp)
      008308 0F 12            [ 1]  517 	clr	(0x12, sp)
      00830A 0F 13            [ 1]  518 	clr	(0x13, sp)
      00830C 0F 14            [ 1]  519 	clr	(0x14, sp)
      00830E 0F 15            [ 1]  520 	clr	(0x15, sp)
      008310 0F 16            [ 1]  521 	clr	(0x16, sp)
      008312 0F 17            [ 1]  522 	clr	(0x17, sp)
      008314 0F 18            [ 1]  523 	clr	(0x18, sp)
      008316 0F 19            [ 1]  524 	clr	(0x19, sp)
      008318 0F 1A            [ 1]  525 	clr	(0x1a, sp)
      00831A 0F 1B            [ 1]  526 	clr	(0x1b, sp)
      00831C 0F 1C            [ 1]  527 	clr	(0x1c, sp)
      00831E 0F 1D            [ 1]  528 	clr	(0x1d, sp)
      008320 0F 1E            [ 1]  529 	clr	(0x1e, sp)
      008322 0F 1F            [ 1]  530 	clr	(0x1f, sp)
      008324 0F 20            [ 1]  531 	clr	(0x20, sp)
      008326 0F 21            [ 1]  532 	clr	(0x21, sp)
      008328 0F 22            [ 1]  533 	clr	(0x22, sp)
      00832A 0F 23            [ 1]  534 	clr	(0x23, sp)
      00832C 0F 24            [ 1]  535 	clr	(0x24, sp)
      00832E 0F 25            [ 1]  536 	clr	(0x25, sp)
      008330 0F 26            [ 1]  537 	clr	(0x26, sp)
      008332 0F 27            [ 1]  538 	clr	(0x27, sp)
      008334 0F 28            [ 1]  539 	clr	(0x28, sp)
      008336 0F 29            [ 1]  540 	clr	(0x29, sp)
      008338 0F 2A            [ 1]  541 	clr	(0x2a, sp)
      00833A 0F 2B            [ 1]  542 	clr	(0x2b, sp)
      00833C 0F 2C            [ 1]  543 	clr	(0x2c, sp)
      00833E 0F 2D            [ 1]  544 	clr	(0x2d, sp)
      008340 0F 2E            [ 1]  545 	clr	(0x2e, sp)
      008342 0F 2F            [ 1]  546 	clr	(0x2f, sp)
      008344 0F 30            [ 1]  547 	clr	(0x30, sp)
      008346 0F 31            [ 1]  548 	clr	(0x31, sp)
      008348 0F 32            [ 1]  549 	clr	(0x32, sp)
      00834A 0F 33            [ 1]  550 	clr	(0x33, sp)
      00834C 0F 34            [ 1]  551 	clr	(0x34, sp)
      00834E 0F 35            [ 1]  552 	clr	(0x35, sp)
      008350 0F 36            [ 1]  553 	clr	(0x36, sp)
      008352 0F 37            [ 1]  554 	clr	(0x37, sp)
      008354 0F 38            [ 1]  555 	clr	(0x38, sp)
      008356 0F 39            [ 1]  556 	clr	(0x39, sp)
      008358 0F 3A            [ 1]  557 	clr	(0x3a, sp)
      00835A 0F 3B            [ 1]  558 	clr	(0x3b, sp)
      00835C 0F 3C            [ 1]  559 	clr	(0x3c, sp)
      00835E 0F 3D            [ 1]  560 	clr	(0x3d, sp)
      008360 0F 3E            [ 1]  561 	clr	(0x3e, sp)
      008362 0F 3F            [ 1]  562 	clr	(0x3f, sp)
      008364 0F 40            [ 1]  563 	clr	(0x40, sp)
      008366 0F 41            [ 1]  564 	clr	(0x41, sp)
      008368 0F 42            [ 1]  565 	clr	(0x42, sp)
      00836A 0F 43            [ 1]  566 	clr	(0x43, sp)
      00836C 0F 44            [ 1]  567 	clr	(0x44, sp)
      00836E 0F 45            [ 1]  568 	clr	(0x45, sp)
      008370 0F 46            [ 1]  569 	clr	(0x46, sp)
      008372 0F 47            [ 1]  570 	clr	(0x47, sp)
      008374 0F 48            [ 1]  571 	clr	(0x48, sp)
      008376 0F 49            [ 1]  572 	clr	(0x49, sp)
      008378 0F 4A            [ 1]  573 	clr	(0x4a, sp)
      00837A 0F 4B            [ 1]  574 	clr	(0x4b, sp)
      00837C 0F 4C            [ 1]  575 	clr	(0x4c, sp)
      00837E 0F 4D            [ 1]  576 	clr	(0x4d, sp)
      008380 0F 4E            [ 1]  577 	clr	(0x4e, sp)
      008382 0F 4F            [ 1]  578 	clr	(0x4f, sp)
      008384 0F 50            [ 1]  579 	clr	(0x50, sp)
      008386 0F 51            [ 1]  580 	clr	(0x51, sp)
      008388 0F 52            [ 1]  581 	clr	(0x52, sp)
      00838A 0F 53            [ 1]  582 	clr	(0x53, sp)
      00838C 0F 54            [ 1]  583 	clr	(0x54, sp)
      00838E 0F 55            [ 1]  584 	clr	(0x55, sp)
      008390 0F 56            [ 1]  585 	clr	(0x56, sp)
      008392 0F 57            [ 1]  586 	clr	(0x57, sp)
      008394 0F 58            [ 1]  587 	clr	(0x58, sp)
      008396 0F 59            [ 1]  588 	clr	(0x59, sp)
      008398 0F 5A            [ 1]  589 	clr	(0x5a, sp)
      00839A 0F 5B            [ 1]  590 	clr	(0x5b, sp)
      00839C 0F 5C            [ 1]  591 	clr	(0x5c, sp)
      00839E 0F 5D            [ 1]  592 	clr	(0x5d, sp)
      0083A0 0F 5E            [ 1]  593 	clr	(0x5e, sp)
      0083A2 0F 5F            [ 1]  594 	clr	(0x5f, sp)
      0083A4 0F 60            [ 1]  595 	clr	(0x60, sp)
      0083A6 0F 61            [ 1]  596 	clr	(0x61, sp)
      0083A8 0F 62            [ 1]  597 	clr	(0x62, sp)
      0083AA 0F 63            [ 1]  598 	clr	(0x63, sp)
      0083AC 0F 64            [ 1]  599 	clr	(0x64, sp)
      0083AE 0F 65            [ 1]  600 	clr	(0x65, sp)
      0083B0 0F 66            [ 1]  601 	clr	(0x66, sp)
      0083B2 0F 67            [ 1]  602 	clr	(0x67, sp)
      0083B4 0F 68            [ 1]  603 	clr	(0x68, sp)
      0083B6 0F 69            [ 1]  604 	clr	(0x69, sp)
      0083B8 0F 6A            [ 1]  605 	clr	(0x6a, sp)
      0083BA 0F 6B            [ 1]  606 	clr	(0x6b, sp)
      0083BC 0F 6C            [ 1]  607 	clr	(0x6c, sp)
      0083BE 0F 6D            [ 1]  608 	clr	(0x6d, sp)
      0083C0 0F 6E            [ 1]  609 	clr	(0x6e, sp)
      0083C2 0F 6F            [ 1]  610 	clr	(0x6f, sp)
      0083C4 0F 70            [ 1]  611 	clr	(0x70, sp)
      0083C6 0F 71            [ 1]  612 	clr	(0x71, sp)
      0083C8 0F 72            [ 1]  613 	clr	(0x72, sp)
      0083CA 0F 73            [ 1]  614 	clr	(0x73, sp)
      0083CC 0F 74            [ 1]  615 	clr	(0x74, sp)
      0083CE 0F 75            [ 1]  616 	clr	(0x75, sp)
      0083D0 0F 76            [ 1]  617 	clr	(0x76, sp)
      0083D2 0F 77            [ 1]  618 	clr	(0x77, sp)
      0083D4 0F 78            [ 1]  619 	clr	(0x78, sp)
      0083D6 0F 79            [ 1]  620 	clr	(0x79, sp)
      0083D8 0F 7A            [ 1]  621 	clr	(0x7a, sp)
      0083DA 0F 7B            [ 1]  622 	clr	(0x7b, sp)
      0083DC 0F 7C            [ 1]  623 	clr	(0x7c, sp)
      0083DE 0F 7D            [ 1]  624 	clr	(0x7d, sp)
      0083E0 0F 7E            [ 1]  625 	clr	(0x7e, sp)
      0083E2 0F 7F            [ 1]  626 	clr	(0x7f, sp)
      0083E4 0F 80            [ 1]  627 	clr	(0x80, sp)
      0083E6 0F 81            [ 1]  628 	clr	(0x81, sp)
      0083E8 0F 82            [ 1]  629 	clr	(0x82, sp)
      0083EA 0F 83            [ 1]  630 	clr	(0x83, sp)
      0083EC 0F 84            [ 1]  631 	clr	(0x84, sp)
      0083EE 0F 85            [ 1]  632 	clr	(0x85, sp)
      0083F0 0F 86            [ 1]  633 	clr	(0x86, sp)
      0083F2 0F 87            [ 1]  634 	clr	(0x87, sp)
      0083F4 0F 88            [ 1]  635 	clr	(0x88, sp)
      0083F6 0F 89            [ 1]  636 	clr	(0x89, sp)
      0083F8 0F 8A            [ 1]  637 	clr	(0x8a, sp)
      0083FA 0F 8B            [ 1]  638 	clr	(0x8b, sp)
      0083FC 0F 8C            [ 1]  639 	clr	(0x8c, sp)
      0083FE 0F 8D            [ 1]  640 	clr	(0x8d, sp)
      008400 0F 8E            [ 1]  641 	clr	(0x8e, sp)
      008402 0F 8F            [ 1]  642 	clr	(0x8f, sp)
      008404 0F 90            [ 1]  643 	clr	(0x90, sp)
      008406 0F 91            [ 1]  644 	clr	(0x91, sp)
      008408 0F 92            [ 1]  645 	clr	(0x92, sp)
      00840A 0F 93            [ 1]  646 	clr	(0x93, sp)
      00840C 0F 94            [ 1]  647 	clr	(0x94, sp)
      00840E 0F 95            [ 1]  648 	clr	(0x95, sp)
      008410 0F 96            [ 1]  649 	clr	(0x96, sp)
      008412 0F 97            [ 1]  650 	clr	(0x97, sp)
      008414 0F 98            [ 1]  651 	clr	(0x98, sp)
      008416 0F 99            [ 1]  652 	clr	(0x99, sp)
      008418 0F 9A            [ 1]  653 	clr	(0x9a, sp)
      00841A 0F 9B            [ 1]  654 	clr	(0x9b, sp)
      00841C 0F 9C            [ 1]  655 	clr	(0x9c, sp)
      00841E 0F 9D            [ 1]  656 	clr	(0x9d, sp)
      008420 0F 9E            [ 1]  657 	clr	(0x9e, sp)
      008422 0F 9F            [ 1]  658 	clr	(0x9f, sp)
      008424 0F A0            [ 1]  659 	clr	(0xa0, sp)
      008426 0F A1            [ 1]  660 	clr	(0xa1, sp)
      008428 0F A2            [ 1]  661 	clr	(0xa2, sp)
      00842A 0F A3            [ 1]  662 	clr	(0xa3, sp)
      00842C 0F A4            [ 1]  663 	clr	(0xa4, sp)
      00842E 0F A5            [ 1]  664 	clr	(0xa5, sp)
      008430 0F A6            [ 1]  665 	clr	(0xa6, sp)
      008432 0F A7            [ 1]  666 	clr	(0xa7, sp)
      008434 0F A8            [ 1]  667 	clr	(0xa8, sp)
      008436 0F A9            [ 1]  668 	clr	(0xa9, sp)
      008438 0F AA            [ 1]  669 	clr	(0xaa, sp)
      00843A 0F AB            [ 1]  670 	clr	(0xab, sp)
      00843C 0F AC            [ 1]  671 	clr	(0xac, sp)
      00843E 0F AD            [ 1]  672 	clr	(0xad, sp)
      008440 0F AE            [ 1]  673 	clr	(0xae, sp)
      008442 0F AF            [ 1]  674 	clr	(0xaf, sp)
      008444 0F B0            [ 1]  675 	clr	(0xb0, sp)
      008446 0F B1            [ 1]  676 	clr	(0xb1, sp)
      008448 0F B2            [ 1]  677 	clr	(0xb2, sp)
      00844A 0F B3            [ 1]  678 	clr	(0xb3, sp)
      00844C 0F B4            [ 1]  679 	clr	(0xb4, sp)
      00844E 0F B5            [ 1]  680 	clr	(0xb5, sp)
      008450 0F B6            [ 1]  681 	clr	(0xb6, sp)
      008452 0F B7            [ 1]  682 	clr	(0xb7, sp)
      008454 0F B8            [ 1]  683 	clr	(0xb8, sp)
      008456 0F B9            [ 1]  684 	clr	(0xb9, sp)
      008458 0F BA            [ 1]  685 	clr	(0xba, sp)
      00845A 0F BB            [ 1]  686 	clr	(0xbb, sp)
      00845C 0F BC            [ 1]  687 	clr	(0xbc, sp)
      00845E 0F BD            [ 1]  688 	clr	(0xbd, sp)
      008460 0F BE            [ 1]  689 	clr	(0xbe, sp)
      008462 0F BF            [ 1]  690 	clr	(0xbf, sp)
      008464 0F C0            [ 1]  691 	clr	(0xc0, sp)
      008466 0F C1            [ 1]  692 	clr	(0xc1, sp)
      008468 0F C2            [ 1]  693 	clr	(0xc2, sp)
      00846A 0F C3            [ 1]  694 	clr	(0xc3, sp)
      00846C 0F C4            [ 1]  695 	clr	(0xc4, sp)
      00846E 0F C5            [ 1]  696 	clr	(0xc5, sp)
      008470 0F C6            [ 1]  697 	clr	(0xc6, sp)
      008472 0F C7            [ 1]  698 	clr	(0xc7, sp)
      008474 0F C8            [ 1]  699 	clr	(0xc8, sp)
      008476 0F C9            [ 1]  700 	clr	(0xc9, sp)
      008478 0F CA            [ 1]  701 	clr	(0xca, sp)
      00847A 0F CB            [ 1]  702 	clr	(0xcb, sp)
      00847C 0F CC            [ 1]  703 	clr	(0xcc, sp)
      00847E 0F CD            [ 1]  704 	clr	(0xcd, sp)
      008480 0F CE            [ 1]  705 	clr	(0xce, sp)
      008482 0F CF            [ 1]  706 	clr	(0xcf, sp)
      008484 0F D0            [ 1]  707 	clr	(0xd0, sp)
      008486 0F D1            [ 1]  708 	clr	(0xd1, sp)
      008488 0F D2            [ 1]  709 	clr	(0xd2, sp)
      00848A 0F D3            [ 1]  710 	clr	(0xd3, sp)
      00848C 0F D4            [ 1]  711 	clr	(0xd4, sp)
      00848E 0F D5            [ 1]  712 	clr	(0xd5, sp)
      008490 0F D6            [ 1]  713 	clr	(0xd6, sp)
      008492 0F D7            [ 1]  714 	clr	(0xd7, sp)
      008494 0F D8            [ 1]  715 	clr	(0xd8, sp)
      008496 0F D9            [ 1]  716 	clr	(0xd9, sp)
      008498 0F DA            [ 1]  717 	clr	(0xda, sp)
      00849A 0F DB            [ 1]  718 	clr	(0xdb, sp)
      00849C 0F DC            [ 1]  719 	clr	(0xdc, sp)
      00849E 0F DD            [ 1]  720 	clr	(0xdd, sp)
      0084A0 0F DE            [ 1]  721 	clr	(0xde, sp)
      0084A2 0F DF            [ 1]  722 	clr	(0xdf, sp)
      0084A4 0F E0            [ 1]  723 	clr	(0xe0, sp)
      0084A6 0F E1            [ 1]  724 	clr	(0xe1, sp)
      0084A8 0F E2            [ 1]  725 	clr	(0xe2, sp)
      0084AA 0F E3            [ 1]  726 	clr	(0xe3, sp)
      0084AC 0F E4            [ 1]  727 	clr	(0xe4, sp)
      0084AE 0F E5            [ 1]  728 	clr	(0xe5, sp)
      0084B0 0F E6            [ 1]  729 	clr	(0xe6, sp)
      0084B2 0F E7            [ 1]  730 	clr	(0xe7, sp)
      0084B4 0F E8            [ 1]  731 	clr	(0xe8, sp)
      0084B6 0F E9            [ 1]  732 	clr	(0xe9, sp)
      0084B8 0F EA            [ 1]  733 	clr	(0xea, sp)
      0084BA 0F EB            [ 1]  734 	clr	(0xeb, sp)
      0084BC 0F EC            [ 1]  735 	clr	(0xec, sp)
      0084BE 0F ED            [ 1]  736 	clr	(0xed, sp)
      0084C0 0F EE            [ 1]  737 	clr	(0xee, sp)
      0084C2 0F EF            [ 1]  738 	clr	(0xef, sp)
      0084C4 0F F0            [ 1]  739 	clr	(0xf0, sp)
      0084C6 0F F1            [ 1]  740 	clr	(0xf1, sp)
      0084C8 0F F2            [ 1]  741 	clr	(0xf2, sp)
      0084CA 0F F3            [ 1]  742 	clr	(0xf3, sp)
      0084CC 0F F4            [ 1]  743 	clr	(0xf4, sp)
      0084CE 0F F5            [ 1]  744 	clr	(0xf5, sp)
      0084D0 0F F6            [ 1]  745 	clr	(0xf6, sp)
      0084D2 0F F7            [ 1]  746 	clr	(0xf7, sp)
      0084D4 0F F8            [ 1]  747 	clr	(0xf8, sp)
      0084D6 0F F9            [ 1]  748 	clr	(0xf9, sp)
      0084D8 0F FA            [ 1]  749 	clr	(0xfa, sp)
      0084DA 0F FB            [ 1]  750 	clr	(0xfb, sp)
      0084DC 0F FC            [ 1]  751 	clr	(0xfc, sp)
      0084DE 0F FD            [ 1]  752 	clr	(0xfd, sp)
      0084E0 0F FE            [ 1]  753 	clr	(0xfe, sp)
      0084E2 0F FF            [ 1]  754 	clr	(0xff, sp)
      0084E4 90 6F 05         [ 1]  755 	clr	(0x5, y)
                                    756 ;	main.c: 108: int i = 0;
      0084E7 5F               [ 1]  757 	clrw	x
      0084E8 90 EF 06         [ 2]  758 	ldw	(0x6, y), x
                                    759 ;	main.c: 109: while(i<5)
      0084EB 5F               [ 1]  760 	clrw	x
      0084EC 90 EF 08         [ 2]  761 	ldw	(0x8, y), x
      0084EF                        762 00108$:
      0084EF 93               [ 1]  763 	ldw	x, y
      0084F0 EE 08            [ 2]  764 	ldw	x, (0x8, x)
      0084F2 A3 00 05         [ 2]  765 	cpw	x, #0x0005
      0084F5 2E 68            [ 1]  766 	jrsge	00110$
                                    767 ;	main.c: 112: if(UART1_SR & UART_SR_RXNE)
      0084F7 C6 52 30         [ 1]  768 	ld	a, 0x5230
      0084FA A5 20            [ 1]  769 	bcp	a, #0x20
      0084FC 27 37            [ 1]  770 	jreq	00121$
                                    771 ;	main.c: 116: buffer[i] = UART_RX();
      0084FE 93               [ 1]  772 	ldw	x, y
      0084FF EE 08            [ 2]  773 	ldw	x, (0x8, x)
      008501 89               [ 2]  774 	pushw	x
      008502 96               [ 1]  775 	ldw	x, sp
      008503 1C 00 03         [ 2]  776 	addw	x, #3
      008506 72 FB 01         [ 2]  777 	addw	x, (1, sp)
      008509 5B 02            [ 2]  778 	addw	sp, #2
      00850B 89               [ 2]  779 	pushw	x
      00850C 90 89            [ 2]  780 	pushw	y
      00850E CD 80 E8         [ 4]  781 	call	_UART_RX
      008511 90 85            [ 2]  782 	popw	y
      008513 85               [ 2]  783 	popw	x
      008514 F7               [ 1]  784 	ld	(x), a
                                    785 ;	main.c: 120: if(buffer[i] == '\r\n' || buffer[i] == '\0')
      008515 A1 0D            [ 1]  786 	cp	a, #0x0d
      008517 27 03            [ 1]  787 	jreq	00101$
      008519 F6               [ 1]  788 	ld	a, (x)
      00851A 26 04            [ 1]  789 	jrne	00102$
      00851C                        790 00101$:
                                    791 ;	main.c: 123: return 1;
      00851C 5F               [ 1]  792 	clrw	x
      00851D 5C               [ 1]  793 	incw	x
      00851E 20 40            [ 2]  794 	jra	00114$
                                    795 ;	main.c: 124: break;
      008520                        796 00102$:
                                    797 ;	main.c: 126: i++;
      008520 93               [ 1]  798 	ldw	x, y
      008521 EE 08            [ 2]  799 	ldw	x, (0x8, x)
      008523 5C               [ 1]  800 	incw	x
      008524 90 EF 08         [ 2]  801 	ldw	(0x8, y), x
      008527 90 E6 08         [ 1]  802 	ld	a, (0x8, y)
      00852A 90 E7 06         [ 1]  803 	ld	(0x6, y), a
      00852D 90 E6 09         [ 1]  804 	ld	a, (0x9, y)
      008530 90 E7 07         [ 1]  805 	ld	(0x7, y), a
      008533 20 BA            [ 2]  806 	jra	00108$
                                    807 ;	main.c: 131: for(int g = 0;g < i; g++)
      008535                        808 00121$:
      008535 5F               [ 1]  809 	clrw	x
      008536 90 EF 08         [ 2]  810 	ldw	(0x8, y), x
      008539                        811 00112$:
      008539 93               [ 1]  812 	ldw	x, y
      00853A EE 08            [ 2]  813 	ldw	x, (0x8, x)
      00853C 90 E3 06         [ 1]  814 	cpw	x, (0x6, y)
      00853F 2E 1E            [ 1]  815 	jrsge	00110$
                                    816 ;	main.c: 132: UART_TX(buffer[g]);
      008541 93               [ 1]  817 	ldw	x, y
      008542 EE 08            [ 2]  818 	ldw	x, (0x8, x)
      008544 89               [ 2]  819 	pushw	x
      008545 96               [ 1]  820 	ldw	x, sp
      008546 1C 00 03         [ 2]  821 	addw	x, #3
      008549 72 FB 01         [ 2]  822 	addw	x, (1, sp)
      00854C 5B 02            [ 2]  823 	addw	sp, #2
      00854E F6               [ 1]  824 	ld	a, (x)
      00854F 90 89            [ 2]  825 	pushw	y
      008551 CD 80 DF         [ 4]  826 	call	_UART_TX
      008554 90 85            [ 2]  827 	popw	y
                                    828 ;	main.c: 131: for(int g = 0;g < i; g++)
      008556 93               [ 1]  829 	ldw	x, y
      008557 EE 08            [ 2]  830 	ldw	x, (0x8, x)
      008559 5C               [ 1]  831 	incw	x
      00855A 90 EF 08         [ 2]  832 	ldw	(0x8, y), x
      00855D 20 DA            [ 2]  833 	jra	00112$
                                    834 ;	main.c: 134: break;
      00855F                        835 00110$:
                                    836 ;	main.c: 138: return 0;
      00855F 5F               [ 1]  837 	clrw	x
      008560                        838 00114$:
                                    839 ;	main.c: 139: }
      008560 5B FF            [ 2]  840 	addw	sp, #255
      008562 5B 05            [ 2]  841 	addw	sp, #5
      008564 81               [ 4]  842 	ret
                                    843 ;	main.c: 141: int main(void)
                                    844 ;	-----------------------------------------
                                    845 ;	 function main
                                    846 ;	-----------------------------------------
      008565                        847 _main:
                                    848 ;	main.c: 143: uart_init();
      008565 CD 82 BB         [ 4]  849 	call	_uart_init
                                    850 ;	main.c: 144: uart_write("ECHO START\n");
      008568 AE 80 9B         [ 2]  851 	ldw	x, #(___str_13+0)
      00856B CD 80 F1         [ 4]  852 	call	_uart_write
                                    853 ;	main.c: 145: while(uart_read()<1);
      00856E                        854 00101$:
      00856E CD 82 DC         [ 4]  855 	call	_uart_read
      008571 A3 00 01         [ 2]  856 	cpw	x, #0x0001
      008574 2F F8            [ 1]  857 	jrslt	00101$
                                    858 ;	main.c: 146: uart_write("ECHO end\n");
      008576 AE 80 A7         [ 2]  859 	ldw	x, #(___str_14+0)
      008579 CD 80 F1         [ 4]  860 	call	_uart_write
                                    861 ;	main.c: 147: return 0;
      00857C 5F               [ 1]  862 	clrw	x
                                    863 ;	main.c: 148: }
      00857D 81               [ 4]  864 	ret
                                    865 	.area CODE
                                    866 	.area CONST
                                    867 	.area CONST
      00802D                        868 ___str_0:
      00802D 55 41 52 54 5F 52 45   869 	.ascii "UART_REGS >.<"
             47 53 20 3E 2E 3C
      00803A 0A                     870 	.db 0x0a
      00803B 00                     871 	.db 0x00
                                    872 	.area CODE
                                    873 	.area CONST
      00803C                        874 ___str_1:
      00803C 0A                     875 	.db 0x0a
      00803D 53 52 20 2D 3E 20      876 	.ascii "SR -> "
      008043 00                     877 	.db 0x00
                                    878 	.area CODE
                                    879 	.area CONST
      008044                        880 ___str_2:
      008044 20 3C 2D               881 	.ascii " <-"
      008047 0A                     882 	.db 0x0a
      008048 00                     883 	.db 0x00
                                    884 	.area CODE
                                    885 	.area CONST
      008049                        886 ___str_3:
      008049 44 52 20 2D 3E 20      887 	.ascii "DR -> "
      00804F 00                     888 	.db 0x00
                                    889 	.area CODE
                                    890 	.area CONST
      008050                        891 ___str_4:
      008050 42 52 52 31 20 2D 3E   892 	.ascii "BRR1 -> "
             20
      008058 00                     893 	.db 0x00
                                    894 	.area CODE
                                    895 	.area CONST
      008059                        896 ___str_5:
      008059 42 52 52 32 20 2D 3E   897 	.ascii "BRR2 -> "
             20
      008061 00                     898 	.db 0x00
                                    899 	.area CODE
                                    900 	.area CONST
      008062                        901 ___str_6:
      008062 43 52 31 20 2D 3E 20   902 	.ascii "CR1 -> "
      008069 00                     903 	.db 0x00
                                    904 	.area CODE
                                    905 	.area CONST
      00806A                        906 ___str_7:
      00806A 43 52 32 20 2D 3E 20   907 	.ascii "CR2 -> "
      008071 00                     908 	.db 0x00
                                    909 	.area CODE
                                    910 	.area CONST
      008072                        911 ___str_8:
      008072 43 52 33 20 2D 3E 20   912 	.ascii "CR3 -> "
      008079 00                     913 	.db 0x00
                                    914 	.area CODE
                                    915 	.area CONST
      00807A                        916 ___str_9:
      00807A 43 52 34 20 2D 3E 20   917 	.ascii "CR4 -> "
      008081 00                     918 	.db 0x00
                                    919 	.area CODE
                                    920 	.area CONST
      008082                        921 ___str_10:
      008082 43 52 35 20 2D 3E 20   922 	.ascii "CR5 -> "
      008089 00                     923 	.db 0x00
                                    924 	.area CODE
                                    925 	.area CONST
      00808A                        926 ___str_11:
      00808A 47 54 52 20 2D 3E 20   927 	.ascii "GTR -> "
      008091 00                     928 	.db 0x00
                                    929 	.area CODE
                                    930 	.area CONST
      008092                        931 ___str_12:
      008092 50 53 43 52 20 2D 3E   932 	.ascii "PSCR -> "
             20
      00809A 00                     933 	.db 0x00
                                    934 	.area CODE
                                    935 	.area CONST
      00809B                        936 ___str_13:
      00809B 45 43 48 4F 20 53 54   937 	.ascii "ECHO START"
             41 52 54
      0080A5 0A                     938 	.db 0x0a
      0080A6 00                     939 	.db 0x00
                                    940 	.area CODE
                                    941 	.area CONST
      0080A7                        942 ___str_14:
      0080A7 45 43 48 4F 20 65 6E   943 	.ascii "ECHO end"
             64
      0080AF 0A                     944 	.db 0x0a
      0080B0 00                     945 	.db 0x00
                                    946 	.area CODE
                                    947 	.area INITIALIZER
                                    948 	.area CABS (ABS)
