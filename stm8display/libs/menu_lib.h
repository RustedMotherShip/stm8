#ifndef _MENU_LIB_H
#define _MENU_LIB_H

//static uint8_t *word_menu[] = {&ttf_eng_m[0],&ttf_eng_e[0],&ttf_eng_n[0],&ttf_eng_u[0]};

#define menu 0
#define color 4
#define segment 7
#define settings 5

#define red 1
#define green 2
#define blue 3

#define first 4
#define second 5

#define sens 6
#define vers 7

struct params_
{
	union
	{
		uint8_t all;
		struct {
			uint8_t current_item;
			uint8_t paragraph_item;

			uint8_t current_red;
			uint8_t current_green;
			uint8_t current_blue;
			uint8_t current_first:4;
			uint8_t current_second:4;
			uint8_t current_sens;
			uint8_t current_vers;
		};
	};
	
} typedef params_t;

params_t params_value;

#endif