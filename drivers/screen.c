#include <drivers/screen.h>
#include <kernel/io.h>
#include <kernel/string.h>

short pos = 0; // use this to store the cursor's position (deprecated in favor of io ports)

void printf(const char *msg)
{
	for (int i=0; msg[i] != 0; i++)
		putc(msg[i]);
}

void putc(char c)
{
	print_char(c, 0, -1, -1);
}

void print_char(char c, char attr, char col, char row)
{
	// TODO 2: handle scrolling
	char *vidmem = (char *)VRAM;
	short off;

	if (col >= MAX_COLS || row >= MAX_ROWS)
		return;

	if (col >= 0 && row >= 0)
		off = get_screen_off(col, row);

	else
		off = get_cursor();

	if (!attr)
		attr = WHITE_ON_BLACK;
	
	adjust_scroll(&off);

	if (c == '\n') {
		off = get_screen_off(MAX_COLS-1, calc_row(off));
	} else {
		vidmem[off] = c;
		vidmem[off+1] = attr;
	}

	off += 2;
	set_cursor(off);
}

int calc_row(short off)
{
	//off += (MAX_COLS - ((off/2) % MAX_COLS))*2-2;
	return (off+1)/2 / MAX_COLS;
}

short get_screen_off(char col, char row)
{
	return (col + row * MAX_COLS)*2;
}

short get_cursor(void)
{
	short off;

	outb(REG_SCREEN_CTRL, 14);
	off = inb(REG_SCREEN_DATA) << 8;

	outb(REG_SCREEN_CTRL, 15);
	off += inb(REG_SCREEN_DATA);

	return off*2;
}


void set_cursor(short off)
{
	off /= 2;
	outb(REG_SCREEN_CTRL, 14);
	outb(REG_SCREEN_DATA, (unsigned char)(off >> 8));
	
	outb(REG_SCREEN_CTRL, 15);
	outb(REG_SCREEN_DATA, (unsigned char)(off & 0x00ff));
}

void clear(void)
{
	set_cursor(0);
	for (int i=0; i < MAX_ROWS; i++) 
		for (int j=0; j < MAX_COLS; j++)
			putc(0x0);
	set_cursor(0);
}

void adjust_scroll(short *off)
{
	char *vram = (char *)VRAM;

	if (*off >= get_screen_off(MAX_COLS-1, MAX_ROWS-1)) {
		memcpy(vram, vram+(MAX_COLS*2), MAX_COLS*2*MAX_ROWS-MAX_COLS*2);// we gona cpy everything starting from the 2nd row 
		*off -= 2*MAX_COLS;

		// clear the last line
		char *ll = vram + get_screen_off(MAX_COLS-1, MAX_ROWS-1) - MAX_COLS*2 - 1;
		for (int i=0; i < MAX_COLS*2; i++)
			ll[i] = 0x0;
	}
}
