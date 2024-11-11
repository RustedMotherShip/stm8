                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
                                     20 ;--------------------------------------------------------
                                     21 ; Stack segment in internal ram
                                     22 ;--------------------------------------------------------
                                     23 	.area SSEG
      0080D7                         24 __start__stack:
      0080D7                         25 	.ds	1
                                     26 
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 
                                     32 ; default segment ordering for linker
                                     33 	.area HOME
                                     34 	.area GSINIT
                                     35 	.area GSFINAL
                                     36 	.area CONST
                                     37 	.area INITIALIZER
                                     38 	.area CODE
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; interrupt vector
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
      008000                         44 __interrupt_vect:
      008000 82 00 80 07             45 	int s_GSINIT ; reset
                                     46 ;--------------------------------------------------------
                                     47 ; global & static initialisations
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area GSINIT
                                     51 	.area GSFINAL
                                     52 	.area GSINIT
      008007 CD 80 D5         [ 4]   53 	call	___sdcc_external_startup
      00800A 4D               [ 1]   54 	tnz	a
      00800B 27 03            [ 1]   55 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   56 	jp	__sdcc_program_startup
      008010                         57 __sdcc_init_data:
                                     58 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   59 	ldw x, #l_DATA
      008013 27 07            [ 1]   60 	jreq	00002$
      008015                         61 00001$:
      008015 72 4F 00 00      [ 1]   62 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   63 	decw x
      00801A 26 F9            [ 1]   64 	jrne	00001$
      00801C                         65 00002$:
      00801C AE 00 00         [ 2]   66 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   67 	jreq	00004$
      008021                         68 00003$:
      008021 D6 80 2C         [ 1]   69 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   70 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   71 	decw	x
      008028 26 F7            [ 1]   72 	jrne	00003$
      00802A                         73 00004$:
                                     74 ; stm8_genXINIT() end
                                     75 	.area GSFINAL
      00802A CC 80 04         [ 2]   76 	jp	__sdcc_program_startup
                                     77 ;--------------------------------------------------------
                                     78 ; Home
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area HOME
      008004                         82 __sdcc_program_startup:
      008004 CC 80 CE         [ 2]   83 	jp	_main
                                     84 ;	return from main will return to caller
                                     85 ;--------------------------------------------------------
                                     86 ; code
                                     87 ;--------------------------------------------------------
                                     88 	.area CODE
                                     89 ;	main.c: 2: int main(void)
                                     90 ;	-----------------------------------------
                                     91 ;	 function main
                                     92 ;	-----------------------------------------
      0080CE                         93 _main:
                                     94 ;	main.c: 5: CLK_CKDIVR = 0;
      0080CE 35 00 50 C6      [ 1]   95 	mov	0x50c6+0, #0x00
                                     96 ;	main.c: 7: while(1) {
      0080D2                         97 00102$:
      0080D2 20 FE            [ 2]   98 	jra	00102$
                                     99 ;	main.c: 10: }
      0080D4 81               [ 4]  100 	ret
                                    101 	.area CODE
                                    102 	.area CONST
                                    103 	.area INITIALIZER
                                    104 	.area CABS (ABS)
