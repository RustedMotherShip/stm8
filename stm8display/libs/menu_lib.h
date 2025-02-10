#ifndef _MENU_LIB_H
#define _MENU_LIB_H

//static uint8_t *word_menu[] = {&ttf_eng_m[0],&ttf_eng_e[0],&ttf_eng_n[0],&ttf_eng_u[0]};

#define menu 0
#define color 1
#define segment 2
#define settings 3

#define red 1
#define green 2
#define blue 3

#define first 4
#define second 5

#define sens 6
#define vers 7

uint8_t current_item = 0;
uint8_t paragraph_item = 0;

#endif