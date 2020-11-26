[bits 32]
; print routine for 32 bit protected mode
VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f
pm_print:
	pusha
	mov ecx, VIDEO_MEM
	mov ah, WHITE_ON_BLACK
	print_pm_loop:
	mov al, [ebx]
	cmp al, 0
	je print_pm_exit
	mov [ecx], ax 
	inc ebx
	add ecx, 0x2 
	jmp print_pm_loop
	print_pm_exit:
	popa
	ret
