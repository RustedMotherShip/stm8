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
                                     12 	.globl _uart_write
                                     13 	.globl _delay
                                     14 	.globl _strlen
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; Stack segment in internal ram
                                     25 ;--------------------------------------------------------
                                     26 	.area SSEG
      000001                         27 __start__stack:
      000001                         28 	.ds	1
                                     29 
                                     30 ;--------------------------------------------------------
                                     31 ; absolute external ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area DABS (ABS)
                                     34 
                                     35 ; default segment ordering for linker
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area CONST
                                     40 	.area INITIALIZER
                                     41 	.area CODE
                                     42 
                                     43 ;--------------------------------------------------------
                                     44 ; interrupt vector
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
      008000                         47 __interrupt_vect:
      008000 82 00 80 07             48 	int s_GSINIT ; reset
                                     49 ;--------------------------------------------------------
                                     50 ; global & static initialisations
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area GSINIT
      008007 CD 80 C6         [ 4]   56 	call	___sdcc_external_startup
      00800A 4D               [ 1]   57 	tnz	a
      00800B 27 03            [ 1]   58 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   59 	jp	__sdcc_program_startup
      008010                         60 __sdcc_init_data:
                                     61 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   62 	ldw x, #l_DATA
      008013 27 07            [ 1]   63 	jreq	00002$
      008015                         64 00001$:
      008015 72 4F 00 00      [ 1]   65 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   66 	decw x
      00801A 26 F9            [ 1]   67 	jrne	00001$
      00801C                         68 00002$:
      00801C AE 00 00         [ 2]   69 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   70 	jreq	00004$
      008021                         71 00003$:
      008021 D6 80 3B         [ 1]   72 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   73 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   74 	decw	x
      008028 26 F7            [ 1]   75 	jrne	00003$
      00802A                         76 00004$:
                                     77 ; stm8_genXINIT() end
                                     78 	.area GSFINAL
      00802A CC 80 04         [ 2]   79 	jp	__sdcc_program_startup
                                     80 ;--------------------------------------------------------
                                     81 ; Home
                                     82 ;--------------------------------------------------------
                                     83 	.area HOME
                                     84 	.area HOME
      008004                         85 __sdcc_program_startup:
      008004 CC 80 9A         [ 2]   86 	jp	_main
                                     87 ;	return from main will return to caller
                                     88 ;--------------------------------------------------------
                                     89 ; code
                                     90 ;--------------------------------------------------------
                                     91 	.area CODE
                                     92 ;	main.c: 7: void delay(unsigned long count) {
                                     93 ;	-----------------------------------------
                                     94 ;	 function delay
                                     95 ;	-----------------------------------------
      00803C                         96 _delay:
      00803C 52 08            [ 2]   97 	sub	sp, #8
                                     98 ;	main.c: 8: while (count--)
      00803E 16 0D            [ 2]   99 	ldw	y, (0x0d, sp)
      008040 17 07            [ 2]  100 	ldw	(0x07, sp), y
      008042 1E 0B            [ 2]  101 	ldw	x, (0x0b, sp)
      008044                        102 00101$:
      008044 1F 01            [ 2]  103 	ldw	(0x01, sp), x
      008046 7B 07            [ 1]  104 	ld	a, (0x07, sp)
      008048 6B 03            [ 1]  105 	ld	(0x03, sp), a
      00804A 7B 08            [ 1]  106 	ld	a, (0x08, sp)
      00804C 16 07            [ 2]  107 	ldw	y, (0x07, sp)
      00804E 72 A2 00 01      [ 2]  108 	subw	y, #0x0001
      008052 17 07            [ 2]  109 	ldw	(0x07, sp), y
      008054 24 01            [ 1]  110 	jrnc	00117$
      008056 5A               [ 2]  111 	decw	x
      008057                        112 00117$:
      008057 4D               [ 1]  113 	tnz	a
      008058 26 08            [ 1]  114 	jrne	00118$
      00805A 16 02            [ 2]  115 	ldw	y, (0x02, sp)
      00805C 26 04            [ 1]  116 	jrne	00118$
      00805E 0D 01            [ 1]  117 	tnz	(0x01, sp)
      008060 27 03            [ 1]  118 	jreq	00104$
      008062                        119 00118$:
                                    120 ;	main.c: 9: nop();
      008062 9D               [ 1]  121 	nop
      008063 20 DF            [ 2]  122 	jra	00101$
      008065                        123 00104$:
                                    124 ;	main.c: 10: }
      008065 1E 09            [ 2]  125 	ldw	x, (9, sp)
      008067 5B 0E            [ 2]  126 	addw	sp, #14
      008069 FC               [ 2]  127 	jp	(x)
                                    128 ;	main.c: 12: int uart_write(const char *str) {
                                    129 ;	-----------------------------------------
                                    130 ;	 function uart_write
                                    131 ;	-----------------------------------------
      00806A                        132 _uart_write:
      00806A 52 05            [ 2]  133 	sub	sp, #5
      00806C 1F 03            [ 2]  134 	ldw	(0x03, sp), x
                                    135 ;	main.c: 14: for(i = 0; i < strlen(str); i++) {
      00806E 0F 05            [ 1]  136 	clr	(0x05, sp)
      008070                        137 00106$:
      008070 1E 03            [ 2]  138 	ldw	x, (0x03, sp)
      008072 CD 80 C8         [ 4]  139 	call	_strlen
      008075 1F 01            [ 2]  140 	ldw	(0x01, sp), x
      008077 5F               [ 1]  141 	clrw	x
      008078 7B 05            [ 1]  142 	ld	a, (0x05, sp)
      00807A 97               [ 1]  143 	ld	xl, a
      00807B 13 01            [ 2]  144 	cpw	x, (0x01, sp)
      00807D 24 14            [ 1]  145 	jrnc	00104$
                                    146 ;	main.c: 15: while(!(UART1_SR & UART_SR_TXE)); // !Transmit data register empty
      00807F                        147 00101$:
      00807F C6 52 30         [ 1]  148 	ld	a, 0x5230
      008082 2A FB            [ 1]  149 	jrpl	00101$
                                    150 ;	main.c: 16: UART1_DR = str[i];
      008084 5F               [ 1]  151 	clrw	x
      008085 7B 05            [ 1]  152 	ld	a, (0x05, sp)
      008087 97               [ 1]  153 	ld	xl, a
      008088 72 FB 03         [ 2]  154 	addw	x, (0x03, sp)
      00808B F6               [ 1]  155 	ld	a, (x)
      00808C C7 52 31         [ 1]  156 	ld	0x5231, a
                                    157 ;	main.c: 14: for(i = 0; i < strlen(str); i++) {
      00808F 0C 05            [ 1]  158 	inc	(0x05, sp)
      008091 20 DD            [ 2]  159 	jra	00106$
      008093                        160 00104$:
                                    161 ;	main.c: 18: return(i); // Bytes sent
      008093 7B 05            [ 1]  162 	ld	a, (0x05, sp)
      008095 5F               [ 1]  163 	clrw	x
      008096 97               [ 1]  164 	ld	xl, a
                                    165 ;	main.c: 19: }
      008097 5B 05            [ 2]  166 	addw	sp, #5
      008099 81               [ 4]  167 	ret
                                    168 ;	main.c: 21: int main(void)
                                    169 ;	-----------------------------------------
                                    170 ;	 function main
                                    171 ;	-----------------------------------------
      00809A                        172 _main:
                                    173 ;	main.c: 24: CLK_CKDIVR = 0;
      00809A 35 00 50 C6      [ 1]  174 	mov	0x50c6+0, #0x00
                                    175 ;	main.c: 27: UART1_CR2 |= UART_CR2_TEN; // Transmitter enable
      00809E 72 16 52 35      [ 1]  176 	bset	0x5235, #3
                                    177 ;	main.c: 29: UART1_CR3 &= ~(UART_CR3_STOP1 | UART_CR3_STOP2); // 1 stop bit
      0080A2 C6 52 36         [ 1]  178 	ld	a, 0x5236
      0080A5 A4 CF            [ 1]  179 	and	a, #0xcf
      0080A7 C7 52 36         [ 1]  180 	ld	0x5236, a
                                    181 ;	main.c: 31: UART1_BRR2 = 0x03; UART1_BRR1 = 0x68; // 0x0683 coded funky way (see ref manual)
      0080AA 35 03 52 33      [ 1]  182 	mov	0x5233+0, #0x03
      0080AE 35 68 52 32      [ 1]  183 	mov	0x5232+0, #0x68
                                    184 ;	main.c: 33: while(1) {
      0080B2                        185 00102$:
                                    186 ;	main.c: 34: uart_write("Hello World!\r\n");
      0080B2 AE 80 2D         [ 2]  187 	ldw	x, #(___str_0+0)
      0080B5 CD 80 6A         [ 4]  188 	call	_uart_write
                                    189 ;	main.c: 35: delay(400000L);
      0080B8 4B 80            [ 1]  190 	push	#0x80
      0080BA 4B 1A            [ 1]  191 	push	#0x1a
      0080BC 4B 06            [ 1]  192 	push	#0x06
      0080BE 4B 00            [ 1]  193 	push	#0x00
      0080C0 CD 80 3C         [ 4]  194 	call	_delay
      0080C3 20 ED            [ 2]  195 	jra	00102$
                                    196 ;	main.c: 37: }
      0080C5 81               [ 4]  197 	ret
                                    198 	.area CODE
                                    199 	.area CONST
                                    200 	.area CONST
      00802D                        201 ___str_0:
      00802D 48 65 6C 6C 6F 20 57   202 	.ascii "Hello World!"
             6F 72 6C 64 21
      008039 0D                     203 	.db 0x0d
      00803A 0A                     204 	.db 0x0a
      00803B 00                     205 	.db 0x00
                                    206 	.area CODE
                                    207 	.area INITIALIZER
                                    208 	.area CABS (ABS)
