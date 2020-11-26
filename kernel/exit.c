#include <kernel/exit.h>

void halt(void)
{
	__asm__("hlt"::);
}


