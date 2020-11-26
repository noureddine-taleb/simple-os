#include <drivers/screen.h>

void _start(void)
{
	char msg1[] = "Hello world!\n"; // this is important since it puts data on the stack and not in .data sec
	char msg2[] = "Goodbye world!\n";

	clear();

	printf(msg1);
	for (int i=0;; i++) {
		i % 2 ? printf(msg1) : printf(msg2);
	}
	
}
