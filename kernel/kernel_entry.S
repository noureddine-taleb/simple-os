[bits 64]
; this code serve as steer to the actual entry point
[extern _start] ; kernel entry point

call _start
jmp $
