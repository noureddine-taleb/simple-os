#define VRAM 0xb8000
#define MAX_COLS 80
#define MAX_ROWS 25
#define WHITE_ON_BLACK 0x0f

// io ports :)
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void printf(const char msg[]);
void putc(char c);
void clear(void);
void print_char(char c, char attr, char col, char row);
short get_screen_off(char col, char row);
short get_cursor(void);
void set_cursor(short off);
int calc_row(short off);
void adjust_scroll(short *off);
