#include <kernel/string.h>

void memcpy(char *dst, char *src, long len) {
	for (int i=0; i < len; i++) {
		dst[i] = src[i];
	}
}
