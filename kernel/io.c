#include <kernel/io.h>

unsigned char inb(unsigned short port)
{
	unsigned char r;
	__asm__("in %%dx, %%al" :"=a" (r) :"d" (port));
	return r;
}

void outb(unsigned short port, unsigned char data)
{
	__asm__("out %%al, %%dx" : :"d"(port), "a"(data));
}

unsigned short inw(unsigned short port)
{
	unsigned short r;
	__asm__("in %%dx, %%ax" :"=a" (r) :"d" (port));
	return r;
}

void outw(unsigned short port, unsigned short data)
{
	__asm__("out %%ax, %%dx" : :"d"(port), "a"(data));
}


