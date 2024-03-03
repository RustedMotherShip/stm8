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
                                     12 	.globl _uart_write_char
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
      008007 CD 81 4E         [ 4]   57 	call	___sdcc_external_startup
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
      008021 D6 80 74         [ 1]   73 	ld	a, (s_INITIALIZER - 1, x)
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
      008004 CC 80 E3         [ 2]   87 	jp	_main
                                     88 ;	return from main will return to caller
                                     89 ;--------------------------------------------------------
                                     90 ; code
                                     91 ;--------------------------------------------------------
                                     92 	.area CODE
                                     93 ;	main.c: 5: void delay(unsigned long count) {
                                     94 ;	-----------------------------------------
                                     95 ;	 function delay
                                     96 ;	-----------------------------------------
      008075                         97 _delay:
      008075 52 08            [ 2]   98 	sub	sp, #8
                                     99 ;	main.c: 6: while (count--)
      008077 16 0D            [ 2]  100 	ldw	y, (0x0d, sp)
      008079 17 07            [ 2]  101 	ldw	(0x07, sp), y
      00807B 1E 0B            [ 2]  102 	ldw	x, (0x0b, sp)
      00807D                        103 00101$:
      00807D 1F 01            [ 2]  104 	ldw	(0x01, sp), x
      00807F 7B 07            [ 1]  105 	ld	a, (0x07, sp)
      008081 6B 03            [ 1]  106 	ld	(0x03, sp), a
      008083 7B 08            [ 1]  107 	ld	a, (0x08, sp)
      008085 16 07            [ 2]  108 	ldw	y, (0x07, sp)
      008087 72 A2 00 01      [ 2]  109 	subw	y, #0x0001
      00808B 17 07            [ 2]  110 	ldw	(0x07, sp), y
      00808D 24 01            [ 1]  111 	jrnc	00117$
      00808F 5A               [ 2]  112 	decw	x
      008090                        113 00117$:
      008090 4D               [ 1]  114 	tnz	a
      008091 26 08            [ 1]  115 	jrne	00118$
      008093 16 02            [ 2]  116 	ldw	y, (0x02, sp)
      008095 26 04            [ 1]  117 	jrne	00118$
      008097 0D 01            [ 1]  118 	tnz	(0x01, sp)
      008099 27 03            [ 1]  119 	jreq	00104$
      00809B                        120 00118$:
                                    121 ;	main.c: 7: nop();
      00809B 9D               [ 1]  122 	nop
      00809C 20 DF            [ 2]  123 	jra	00101$
      00809E                        124 00104$:
                                    125 ;	main.c: 8: }
      00809E 1E 09            [ 2]  126 	ldw	x, (9, sp)
      0080A0 5B 0E            [ 2]  127 	addw	sp, #14
      0080A2 FC               [ 2]  128 	jp	(x)
                                    129 ;	main.c: 10: int uart_write_line(const char *str) {
                                    130 ;	-----------------------------------------
                                    131 ;	 function uart_write_line
                                    132 ;	-----------------------------------------
      0080A3                        133 _uart_write_line:
      0080A3 52 05            [ 2]  134 	sub	sp, #5
      0080A5 1F 03            [ 2]  135 	ldw	(0x03, sp), x
                                    136 ;	main.c: 12: for(i = 0; i < strlen(str); i++) {
      0080A7 0F 05            [ 1]  137 	clr	(0x05, sp)
      0080A9                        138 00106$:
      0080A9 1E 03            [ 2]  139 	ldw	x, (0x03, sp)
      0080AB CD 81 50         [ 4]  140 	call	_strlen
      0080AE 1F 01            [ 2]  141 	ldw	(0x01, sp), x
      0080B0 5F               [ 1]  142 	clrw	x
      0080B1 7B 05            [ 1]  143 	ld	a, (0x05, sp)
      0080B3 97               [ 1]  144 	ld	xl, a
      0080B4 13 01            [ 2]  145 	cpw	x, (0x01, sp)
      0080B6 24 14            [ 1]  146 	jrnc	00104$
                                    147 ;	main.c: 13: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0080B8                        148 00101$:
      0080B8 C6 52 30         [ 1]  149 	ld	a, 0x5230
      0080BB 2A FB            [ 1]  150 	jrpl	00101$
                                    151 ;	main.c: 14: UART1_DR = str[i];
      0080BD 5F               [ 1]  152 	clrw	x
      0080BE 7B 05            [ 1]  153 	ld	a, (0x05, sp)
      0080C0 97               [ 1]  154 	ld	xl, a
      0080C1 72 FB 03         [ 2]  155 	addw	x, (0x03, sp)
      0080C4 F6               [ 1]  156 	ld	a, (x)
      0080C5 C7 52 31         [ 1]  157 	ld	0x5231, a
                                    158 ;	main.c: 12: for(i = 0; i < strlen(str); i++) {
      0080C8 0C 05            [ 1]  159 	inc	(0x05, sp)
      0080CA 20 DD            [ 2]  160 	jra	00106$
      0080CC                        161 00104$:
                                    162 ;	main.c: 16: return(i); // Bytes sent
      0080CC 7B 05            [ 1]  163 	ld	a, (0x05, sp)
      0080CE 5F               [ 1]  164 	clrw	x
      0080CF 97               [ 1]  165 	ld	xl, a
                                    166 ;	main.c: 17: }
      0080D0 5B 05            [ 2]  167 	addw	sp, #5
      0080D2 81               [ 4]  168 	ret
                                    169 ;	main.c: 19: void uart_write_char(char str_char) {
                                    170 ;	-----------------------------------------
                                    171 ;	 function uart_write_char
                                    172 ;	-----------------------------------------
      0080D3                        173 _uart_write_char:
      0080D3 88               [ 1]  174 	push	a
      0080D4 6B 01            [ 1]  175 	ld	(0x01, sp), a
                                    176 ;	main.c: 20: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      0080D6                        177 00101$:
      0080D6 C6 52 30         [ 1]  178 	ld	a, 0x5230
      0080D9 2A FB            [ 1]  179 	jrpl	00101$
                                    180 ;	main.c: 21: UART1_DR = str_char;
      0080DB AE 52 31         [ 2]  181 	ldw	x, #0x5231
      0080DE 7B 01            [ 1]  182 	ld	a, (0x01, sp)
      0080E0 F7               [ 1]  183 	ld	(x), a
                                    184 ;	main.c: 22: }
      0080E1 84               [ 1]  185 	pop	a
      0080E2 81               [ 4]  186 	ret
                                    187 ;	main.c: 25: int main(void)
                                    188 ;	-----------------------------------------
                                    189 ;	 function main
                                    190 ;	-----------------------------------------
      0080E3                        191 _main:
      0080E3 88               [ 1]  192 	push	a
                                    193 ;	main.c: 28: CLK_CKDIVR = 0;
      0080E4 35 00 50 C6      [ 1]  194 	mov	0x50c6+0, #0x00
                                    195 ;	main.c: 31: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      0080E8 72 16 52 35      [ 1]  196 	bset	0x5235, #3
                                    197 ;	main.c: 33: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0080EC C6 52 36         [ 1]  198 	ld	a, 0x5236
      0080EF A4 CF            [ 1]  199 	and	a, #0xcf
      0080F1 C7 52 36         [ 1]  200 	ld	0x5236, a
                                    201 ;	main.c: 35: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0080F4 35 03 52 33      [ 1]  202 	mov	0x5233+0, #0x03
      0080F8 35 68 52 32      [ 1]  203 	mov	0x5232+0, #0x68
                                    204 ;	main.c: 38: I2C_CR1 = 0x01;  // включаем подключение к шине
      0080FC 35 01 52 10      [ 1]  205 	mov	0x5210+0, #0x01
                                    206 ;	main.c: 39: I2C_FREQR = 0x01;  
      008100 35 01 52 12      [ 1]  207 	mov	0x5212+0, #0x01
                                    208 ;	main.c: 40: I2C_CCRL = 0x50;  // Загружаем нижние 8 бит делителя для получения 100 кГц
      008104 35 50 52 1B      [ 1]  209 	mov	0x521b+0, #0x50
                                    210 ;	main.c: 41: I2C_CCRH = 0x00;  // Обнуляем верхние биты делителя
      008108 35 00 52 1C      [ 1]  211 	mov	0x521c+0, #0x00
                                    212 ;	main.c: 44: while(1) {
      00810C                        213 00103$:
                                    214 ;	main.c: 45: uart_write_line("Start Scanning\n");
      00810C AE 80 2D         [ 2]  215 	ldw	x, #(___str_0+0)
      00810F CD 80 A3         [ 4]  216 	call	_uart_write_line
                                    217 ;	main.c: 47: for(char addr = 0x00; addr < 0xFF;addr++)
      008112 0F 01            [ 1]  218 	clr	(0x01, sp)
      008114                        219 00106$:
      008114 7B 01            [ 1]  220 	ld	a, (0x01, sp)
      008116 A1 FF            [ 1]  221 	cp	a, #0xff
      008118 24 F2            [ 1]  222 	jrnc	00103$
                                    223 ;	main.c: 50: uart_write_line("_______Start______\n");
      00811A AE 80 3D         [ 2]  224 	ldw	x, #(___str_1+0)
      00811D CD 80 A3         [ 4]  225 	call	_uart_write_line
                                    226 ;	main.c: 51: uart_write_line("Dev -> ");
      008120 AE 80 51         [ 2]  227 	ldw	x, #(___str_2+0)
      008123 CD 80 A3         [ 4]  228 	call	_uart_write_line
                                    229 ;	main.c: 52: uart_write_char(addr);
      008126 7B 01            [ 1]  230 	ld	a, (0x01, sp)
      008128 CD 80 D3         [ 4]  231 	call	_uart_write_char
                                    232 ;	main.c: 53: uart_write_line(" <-Dev\n");
      00812B AE 80 59         [ 2]  233 	ldw	x, #(___str_3+0)
      00812E CD 80 A3         [ 4]  234 	call	_uart_write_line
                                    235 ;	main.c: 56: I2C_DR = addr;
      008131 AE 52 16         [ 2]  236 	ldw	x, #0x5216
      008134 7B 01            [ 1]  237 	ld	a, (0x01, sp)
      008136 F7               [ 1]  238 	ld	(x), a
                                    239 ;	main.c: 61: uart_write_line("_______Stop_______\n");
      008137 AE 80 61         [ 2]  240 	ldw	x, #(___str_4+0)
      00813A CD 80 A3         [ 4]  241 	call	_uart_write_line
                                    242 ;	main.c: 62: delay(2000000L);
      00813D 4B 80            [ 1]  243 	push	#0x80
      00813F 4B 84            [ 1]  244 	push	#0x84
      008141 4B 1E            [ 1]  245 	push	#0x1e
      008143 4B 00            [ 1]  246 	push	#0x00
      008145 CD 80 75         [ 4]  247 	call	_delay
                                    248 ;	main.c: 47: for(char addr = 0x00; addr < 0xFF;addr++)
      008148 0C 01            [ 1]  249 	inc	(0x01, sp)
      00814A 20 C8            [ 2]  250 	jra	00106$
                                    251 ;	main.c: 67: }
      00814C 84               [ 1]  252 	pop	a
      00814D 81               [ 4]  253 	ret
                                    254 	.area CODE
                                    255 	.area CONST
                                    256 	.area CONST
      00802D                        257 ___str_0:
      00802D 53 74 61 72 74 20 53   258 	.ascii "Start Scanning"
             63 61 6E 6E 69 6E 67
      00803B 0A                     259 	.db 0x0a
      00803C 00                     260 	.db 0x00
                                    261 	.area CODE
                                    262 	.area CONST
      00803D                        263 ___str_1:
      00803D 5F 5F 5F 5F 5F 5F 5F   264 	.ascii "_______Start______"
             53 74 61 72 74 5F 5F
             5F 5F 5F 5F
      00804F 0A                     265 	.db 0x0a
      008050 00                     266 	.db 0x00
                                    267 	.area CODE
                                    268 	.area CONST
      008051                        269 ___str_2:
      008051 44 65 76 20 2D 3E 20   270 	.ascii "Dev -> "
      008058 00                     271 	.db 0x00
                                    272 	.area CODE
                                    273 	.area CONST
      008059                        274 ___str_3:
      008059 20 3C 2D 44 65 76      275 	.ascii " <-Dev"
      00805F 0A                     276 	.db 0x0a
      008060 00                     277 	.db 0x00
                                    278 	.area CODE
                                    279 	.area CONST
      008061                        280 ___str_4:
      008061 5F 5F 5F 5F 5F 5F 5F   281 	.ascii "_______Stop_______"
             53 74 6F 70 5F 5F 5F
             5F 5F 5F 5F
      008073 0A                     282 	.db 0x0a
      008074 00                     283 	.db 0x00
                                    284 	.area CODE
                                    285 	.area INITIALIZER
                                    286 	.area CABS (ABS)
