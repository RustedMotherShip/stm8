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
                                     12 	.globl _uart_write_int
                                     13 	.globl _uart_write_line
                                     14 	.globl _delay
                                     15 	.globl _strlen
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; Stack segment in internal ram
                                     26 ;--------------------------------------------------------
                                     27 	.area SSEG
      000001                         28 __start__stack:
      000001                         29 	.ds	1
                                     30 
                                     31 ;--------------------------------------------------------
                                     32 ; absolute external ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DABS (ABS)
                                     35 
                                     36 ; default segment ordering for linker
                                     37 	.area HOME
                                     38 	.area GSINIT
                                     39 	.area GSFINAL
                                     40 	.area CONST
                                     41 	.area INITIALIZER
                                     42 	.area CODE
                                     43 
                                     44 ;--------------------------------------------------------
                                     45 ; interrupt vector
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
      008000                         48 __interrupt_vect:
      008000 82 00 80 07             49 	int s_GSINIT ; reset
                                     50 ;--------------------------------------------------------
                                     51 ; global & static initialisations
                                     52 ;--------------------------------------------------------
                                     53 	.area HOME
                                     54 	.area GSINIT
                                     55 	.area GSFINAL
                                     56 	.area GSINIT
      008007 CD 81 47         [ 4]   57 	call	___sdcc_external_startup
      00800A 4D               [ 1]   58 	tnz	a
      00800B 27 03            [ 1]   59 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   60 	jp	__sdcc_program_startup
      008010                         61 __sdcc_init_data:
                                     62 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   63 	ldw x, #l_DATA
      008013 27 07            [ 1]   64 	jreq	00002$
      008015                         65 00001$:
      008015 72 4F 00 00      [ 1]   66 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   67 	decw x
      00801A 26 F9            [ 1]   68 	jrne	00001$
      00801C                         69 00002$:
      00801C AE 00 00         [ 2]   70 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   71 	jreq	00004$
      008021                         72 00003$:
      008021 D6 80 77         [ 1]   73 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   74 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   75 	decw	x
      008028 26 F7            [ 1]   76 	jrne	00003$
      00802A                         77 00004$:
                                     78 ; stm8_genXINIT() end
                                     79 	.area GSFINAL
      00802A CC 80 04         [ 2]   80 	jp	__sdcc_program_startup
                                     81 ;--------------------------------------------------------
                                     82 ; Home
                                     83 ;--------------------------------------------------------
                                     84 	.area HOME
                                     85 	.area HOME
      008004                         86 __sdcc_program_startup:
      008004 CC 80 E6         [ 2]   87 	jp	_main
                                     88 ;	return from main will return to caller
                                     89 ;--------------------------------------------------------
                                     90 ; code
                                     91 ;--------------------------------------------------------
                                     92 	.area CODE
                                     93 ;	main.c: 5: void delay(unsigned long count) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function delay
                                     96 ;	-----------------------------------------
      008078                         97 _delay:
      008078 52 08            [ 2]   98 	sub	sp, #8
                                     99 ;	main.c: 6: while (count--)
      00807A 16 0D            [ 2]  100 	ldw	y, (0x0d, sp)
      00807C 17 07            [ 2]  101 	ldw	(0x07, sp), y
      00807E 1E 0B            [ 2]  102 	ldw	x, (0x0b, sp)
      008080                        103 00101$:
      008080 1F 01            [ 2]  104 	ldw	(0x01, sp), x
      008082 7B 07            [ 1]  105 	ld	a, (0x07, sp)
      008084 6B 03            [ 1]  106 	ld	(0x03, sp), a
      008086 7B 08            [ 1]  107 	ld	a, (0x08, sp)
      008088 16 07            [ 2]  108 	ldw	y, (0x07, sp)
      00808A 72 A2 00 01      [ 2]  109 	subw	y, #0x0001
      00808E 17 07            [ 2]  110 	ldw	(0x07, sp), y
      008090 24 01            [ 1]  111 	jrnc	00117$
      008092 5A               [ 2]  112 	decw	x
      008093                        113 00117$:
      008093 4D               [ 1]  114 	tnz	a
      008094 26 08            [ 1]  115 	jrne	00118$
      008096 16 02            [ 2]  116 	ldw	y, (0x02, sp)
      008098 26 04            [ 1]  117 	jrne	00118$
      00809A 0D 01            [ 1]  118 	tnz	(0x01, sp)
      00809C 27 03            [ 1]  119 	jreq	00104$
      00809E                        120 00118$:
                                    121 ;	main.c: 7: nop();
      00809E 9D               [ 1]  122 	nop
      00809F 20 DF            [ 2]  123 	jra	00101$
      0080A1                        124 00104$:
                                    125 ;	main.c: 8: }
      0080A1 1E 09            [ 2]  126 	ldw	x, (9, sp)
      0080A3 5B 0E            [ 2]  127 	addw	sp, #14
      0080A5 FC               [ 2]  128 	jp	(x)
                                    129 ;	main.c: 10: int uart_write_line(const char *str) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function uart_write_line
                                    132 ;	-----------------------------------------
      0080A6                        133 _uart_write_line:
      0080A6 52 05            [ 2]  134 	sub	sp, #5
      0080A8 1F 03            [ 2]  135 	ldw	(0x03, sp), x
                                    136 ;	main.c: 12: for(i = 0; i < strlen(str); i++) {
      0080AA 0F 05            [ 1]  137 	clr	(0x05, sp)
      0080AC                        138 00106$:
      0080AC 1E 03            [ 2]  139 	ldw	x, (0x03, sp)
      0080AE CD 81 49         [ 4]  140 	call	_strlen
      0080B1 1F 01            [ 2]  141 	ldw	(0x01, sp), x
      0080B3 5F               [ 1]  142 	clrw	x
      0080B4 7B 05            [ 1]  143 	ld	a, (0x05, sp)
      0080B6 97               [ 1]  144 	ld	xl, a
      0080B7 13 01            [ 2]  145 	cpw	x, (0x01, sp)
      0080B9 24 14            [ 1]  146 	jrnc	00104$
                                    147 ;	main.c: 13: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0080BB                        148 00101$:
      0080BB C6 52 30         [ 1]  149 	ld	a, 0x5230
      0080BE 2A FB            [ 1]  150 	jrpl	00101$
                                    151 ;	main.c: 14: UART1_DR = str[i];
      0080C0 5F               [ 1]  152 	clrw	x
      0080C1 7B 05            [ 1]  153 	ld	a, (0x05, sp)
      0080C3 97               [ 1]  154 	ld	xl, a
      0080C4 72 FB 03         [ 2]  155 	addw	x, (0x03, sp)
      0080C7 F6               [ 1]  156 	ld	a, (x)
      0080C8 C7 52 31         [ 1]  157 	ld	0x5231, a
                                    158 ;	main.c: 12: for(i = 0; i < strlen(str); i++) {
      0080CB 0C 05            [ 1]  159 	inc	(0x05, sp)
      0080CD 20 DD            [ 2]  160 	jra	00106$
      0080CF                        161 00104$:
                                    162 ;	main.c: 16: return(i); // Bytes sent
      0080CF 7B 05            [ 1]  163 	ld	a, (0x05, sp)
      0080D1 5F               [ 1]  164 	clrw	x
      0080D2 97               [ 1]  165 	ld	xl, a
                                    166 ;	main.c: 17: }
      0080D3 5B 05            [ 2]  167 	addw	sp, #5
      0080D5 81               [ 4]  168 	ret
                                    169 ;	main.c: 19: void uart_write_int(uint8_t rx_int) {
                                    170 ;	-----------------------------------------
                                    171 ;	 function uart_write_int
                                    172 ;	-----------------------------------------
      0080D6                        173 _uart_write_int:
      0080D6 88               [ 1]  174 	push	a
      0080D7 6B 01            [ 1]  175 	ld	(0x01, sp), a
                                    176 ;	main.c: 20: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0080D9                        177 00101$:
      0080D9 C6 52 30         [ 1]  178 	ld	a, 0x5230
      0080DC 2A FB            [ 1]  179 	jrpl	00101$
                                    180 ;	main.c: 21: UART1_DR = rx_int;
      0080DE AE 52 31         [ 2]  181 	ldw	x, #0x5231
      0080E1 7B 01            [ 1]  182 	ld	a, (0x01, sp)
      0080E3 F7               [ 1]  183 	ld	(x), a
                                    184 ;	main.c: 22: }
      0080E4 84               [ 1]  185 	pop	a
      0080E5 81               [ 4]  186 	ret
                                    187 ;	main.c: 25: int main(void)
                                    188 ;	-----------------------------------------
                                    189 ;	 function main
                                    190 ;	-----------------------------------------
      0080E6                        191 _main:
      0080E6 88               [ 1]  192 	push	a
                                    193 ;	main.c: 28: CLK_CKDIVR = 0;
      0080E7 35 00 50 C6      [ 1]  194 	mov	0x50c6+0, #0x00
                                    195 ;	main.c: 31: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0080EB 72 16 52 35      [ 1]  196 	bset	0x5235, #3
                                    197 ;	main.c: 33: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0080EF C6 52 36         [ 1]  198 	ld	a, 0x5236
      0080F2 A4 CF            [ 1]  199 	and	a, #0xcf
      0080F4 C7 52 36         [ 1]  200 	ld	0x5236, a
                                    201 ;	main.c: 35: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0080F7 35 03 52 33      [ 1]  202 	mov	0x5233+0, #0x03
      0080FB 35 68 52 32      [ 1]  203 	mov	0x5232+0, #0x68
                                    204 ;	main.c: 38: I2C_CR1 = 0x01;  // включаем подключение к шине
      0080FF 35 01 52 10      [ 1]  205 	mov	0x5210+0, #0x01
                                    206 ;	main.c: 39: I2C_FREQR = 0x01;  
      008103 35 01 52 12      [ 1]  207 	mov	0x5212+0, #0x01
                                    208 ;	main.c: 40: I2C_CCRL = 0x50;  // Загружаем нижние 8 бит делителя для получения 100 кГц
      008107 35 50 52 1B      [ 1]  209 	mov	0x521b+0, #0x50
                                    210 ;	main.c: 41: I2C_CCRH = 0x00;  // Обнуляем верхние биты делителя
      00810B 35 00 52 1C      [ 1]  211 	mov	0x521c+0, #0x00
                                    212 ;	main.c: 45: uart_write_line("Start Scanning\n");
      00810F AE 80 2D         [ 2]  213 	ldw	x, #(___str_0+0)
      008112 CD 80 A6         [ 4]  214 	call	_uart_write_line
                                    215 ;	main.c: 47: for(char addr = 0x00; addr < 0xFF;addr++)
      008115 0F 01            [ 1]  216 	clr	(0x01, sp)
      008117                        217 00103$:
      008117 7B 01            [ 1]  218 	ld	a, (0x01, sp)
      008119 A1 FF            [ 1]  219 	cp	a, #0xff
      00811B 24 27            [ 1]  220 	jrnc	00101$
                                    221 ;	main.c: 50: uart_write_line("_______Start______\n");
      00811D AE 80 3D         [ 2]  222 	ldw	x, #(___str_1+0)
      008120 CD 80 A6         [ 4]  223 	call	_uart_write_line
                                    224 ;	main.c: 51: uart_write_line("Dev ->  ");
      008123 AE 80 51         [ 2]  225 	ldw	x, #(___str_2+0)
      008126 CD 80 A6         [ 4]  226 	call	_uart_write_line
                                    227 ;	main.c: 52: uart_write_int(addr);
      008129 7B 01            [ 1]  228 	ld	a, (0x01, sp)
      00812B CD 80 D6         [ 4]  229 	call	_uart_write_int
                                    230 ;	main.c: 53: uart_write_line("  <- Dev\n");
      00812E AE 80 5A         [ 2]  231 	ldw	x, #(___str_3+0)
      008131 CD 80 A6         [ 4]  232 	call	_uart_write_line
                                    233 ;	main.c: 56: I2C_DR = addr;
      008134 AE 52 16         [ 2]  234 	ldw	x, #0x5216
      008137 7B 01            [ 1]  235 	ld	a, (0x01, sp)
      008139 F7               [ 1]  236 	ld	(x), a
                                    237 ;	main.c: 61: uart_write_line("_______Stop_______\n");
      00813A AE 80 64         [ 2]  238 	ldw	x, #(___str_4+0)
      00813D CD 80 A6         [ 4]  239 	call	_uart_write_line
                                    240 ;	main.c: 47: for(char addr = 0x00; addr < 0xFF;addr++)
      008140 0C 01            [ 1]  241 	inc	(0x01, sp)
      008142 20 D3            [ 2]  242 	jra	00103$
      008144                        243 00101$:
                                    244 ;	main.c: 67: return 0;
      008144 5F               [ 1]  245 	clrw	x
                                    246 ;	main.c: 68: }
      008145 84               [ 1]  247 	pop	a
      008146 81               [ 4]  248 	ret
                                    249 	.area CODE
                                    250 	.area CONST
                                    251 	.area CONST
      00802D                        252 ___str_0:
      00802D 53 74 61 72 74 20 53   253 	.ascii "Start Scanning"
             63 61 6E 6E 69 6E 67
      00803B 0A                     254 	.db 0x0a
      00803C 00                     255 	.db 0x00
                                    256 	.area CODE
                                    257 	.area CONST
      00803D                        258 ___str_1:
      00803D 5F 5F 5F 5F 5F 5F 5F   259 	.ascii "_______Start______"
             53 74 61 72 74 5F 5F
             5F 5F 5F 5F
      00804F 0A                     260 	.db 0x0a
      008050 00                     261 	.db 0x00
                                    262 	.area CODE
                                    263 	.area CONST
      008051                        264 ___str_2:
      008051 44 65 76 20 2D 3E 20   265 	.ascii "Dev ->  "
             20
      008059 00                     266 	.db 0x00
                                    267 	.area CODE
                                    268 	.area CONST
      00805A                        269 ___str_3:
      00805A 20 20 3C 2D 20 44 65   270 	.ascii "  <- Dev"
             76
      008062 0A                     271 	.db 0x0a
      008063 00                     272 	.db 0x00
                                    273 	.area CODE
                                    274 	.area CONST
      008064                        275 ___str_4:
      008064 5F 5F 5F 5F 5F 5F 5F   276 	.ascii "_______Stop_______"
             53 74 6F 70 5F 5F 5F
             5F 5F 5F 5F
      008076 0A                     277 	.db 0x0a
      008077 00                     278 	.db 0x00
                                    279 	.area CODE
                                    280 	.area INITIALIZER
                                    281 	.area CABS (ABS)
