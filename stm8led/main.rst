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
                                     12 	.globl _delay
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; Stack segment in internal ram
                                     23 ;--------------------------------------------------------
                                     24 	.area SSEG
      000001                         25 __start__stack:
      000001                         26 	.ds	1
                                     27 
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; interrupt vector
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
      008000                         45 __interrupt_vect:
      008000 82 00 80 07             46 	int s_GSINIT ; reset
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
      008007 CD 80 88         [ 4]   54 	call	___sdcc_external_startup
      00800A 4D               [ 1]   55 	tnz	a
      00800B 27 03            [ 1]   56 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   57 	jp	__sdcc_program_startup
      008010                         58 __sdcc_init_data:
                                     59 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   60 	ldw x, #l_DATA
      008013 27 07            [ 1]   61 	jreq	00002$
      008015                         62 00001$:
      008015 72 4F 00 00      [ 1]   63 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   64 	decw x
      00801A 26 F9            [ 1]   65 	jrne	00001$
      00801C                         66 00002$:
      00801C AE 00 00         [ 2]   67 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   68 	jreq	00004$
      008021                         69 00003$:
      008021 D6 80 2C         [ 1]   70 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   71 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   72 	decw	x
      008028 26 F7            [ 1]   73 	jrne	00003$
      00802A                         74 00004$:
                                     75 ; stm8_genXINIT() end
                                     76 	.area GSFINAL
      00802A CC 80 04         [ 2]   77 	jp	__sdcc_program_startup
                                     78 ;--------------------------------------------------------
                                     79 ; Home
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area HOME
      008004                         83 __sdcc_program_startup:
      008004 CC 80 5B         [ 2]   84 	jp	_main
                                     85 ;	return from main will return to caller
                                     86 ;--------------------------------------------------------
                                     87 ; code
                                     88 ;--------------------------------------------------------
                                     89 	.area CODE
                                     90 ;	main.c: 16: void delay(unsigned long count) {
                                     91 ;	-----------------------------------------
                                     92 ;	 function delay
                                     93 ;	-----------------------------------------
      00802D                         94 _delay:
      00802D 52 08            [ 2]   95 	sub	sp, #8
                                     96 ;	main.c: 17: while (count--)
      00802F 16 0D            [ 2]   97 	ldw	y, (0x0d, sp)
      008031 17 07            [ 2]   98 	ldw	(0x07, sp), y
      008033 1E 0B            [ 2]   99 	ldw	x, (0x0b, sp)
      008035                        100 00101$:
      008035 1F 01            [ 2]  101 	ldw	(0x01, sp), x
      008037 7B 07            [ 1]  102 	ld	a, (0x07, sp)
      008039 6B 03            [ 1]  103 	ld	(0x03, sp), a
      00803B 7B 08            [ 1]  104 	ld	a, (0x08, sp)
      00803D 16 07            [ 2]  105 	ldw	y, (0x07, sp)
      00803F 72 A2 00 01      [ 2]  106 	subw	y, #0x0001
      008043 17 07            [ 2]  107 	ldw	(0x07, sp), y
      008045 24 01            [ 1]  108 	jrnc	00117$
      008047 5A               [ 2]  109 	decw	x
      008048                        110 00117$:
      008048 4D               [ 1]  111 	tnz	a
      008049 26 08            [ 1]  112 	jrne	00118$
      00804B 16 02            [ 2]  113 	ldw	y, (0x02, sp)
      00804D 26 04            [ 1]  114 	jrne	00118$
      00804F 0D 01            [ 1]  115 	tnz	(0x01, sp)
      008051 27 03            [ 1]  116 	jreq	00104$
      008053                        117 00118$:
                                    118 ;	main.c: 18: nop();
      008053 9D               [ 1]  119 	nop
      008054 20 DF            [ 2]  120 	jra	00101$
      008056                        121 00104$:
                                    122 ;	main.c: 19: }
      008056 1E 09            [ 2]  123 	ldw	x, (9, sp)
      008058 5B 0E            [ 2]  124 	addw	sp, #14
      00805A FC               [ 2]  125 	jp	(x)
                                    126 ;	main.c: 21: int main(void)
                                    127 ;	-----------------------------------------
                                    128 ;	 function main
                                    129 ;	-----------------------------------------
      00805B                        130 _main:
                                    131 ;	main.c: 24: CLK_CKDIVR = 0;
      00805B 35 00 50 C6      [ 1]  132 	mov	0x50c6+0, #0x00
                                    133 ;	main.c: 28: PORT(LED_PORT, DDR)  |= LED_PIN; // i.e. PB_DDR |= (1 << 5);
      00805F 72 16 50 11      [ 1]  134 	bset	0x5011, #3
                                    135 ;	main.c: 30: PORT(LED_PORT, CR1)  |= LED_PIN; // i.e. PB_CR1 |= (1 << 5);
      008063 72 16 50 12      [ 1]  136 	bset	0x5012, #3
                                    137 ;	main.c: 32: while(1) {
      008067                        138 00102$:
                                    139 ;	main.c: 34: PORT(LED_PORT, ODR) |= LED_PIN; // PB_ODR |= (1 << 5);
      008067 72 16 50 0F      [ 1]  140 	bset	0x500f, #3
                                    141 ;	main.c: 35: delay(100000L);
      00806B 4B A0            [ 1]  142 	push	#0xa0
      00806D 4B 86            [ 1]  143 	push	#0x86
      00806F 4B 01            [ 1]  144 	push	#0x01
      008071 4B 00            [ 1]  145 	push	#0x00
      008073 CD 80 2D         [ 4]  146 	call	_delay
                                    147 ;	main.c: 37: PORT(LED_PORT, ODR) &= ~LED_PIN; // PB_ODR &= ~(1 << 5);
      008076 72 17 50 0F      [ 1]  148 	bres	0x500f, #3
                                    149 ;	main.c: 38: delay(300000L);
      00807A 4B E0            [ 1]  150 	push	#0xe0
      00807C 4B 93            [ 1]  151 	push	#0x93
      00807E 4B 04            [ 1]  152 	push	#0x04
      008080 4B 00            [ 1]  153 	push	#0x00
      008082 CD 80 2D         [ 4]  154 	call	_delay
      008085 20 E0            [ 2]  155 	jra	00102$
                                    156 ;	main.c: 40: }
      008087 81               [ 4]  157 	ret
                                    158 	.area CODE
                                    159 	.area CONST
                                    160 	.area INITIALIZER
                                    161 	.area CABS (ABS)
