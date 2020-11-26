; this routine is used to bootstrap the os
; @sector_no(al) number of sectors to load
; @pointer(bx)   memory address to fill
[bits 16]
disk_msg: db 'warning: disk error ',0
disk_load:
	pusha
	mov dl, 0x0 ; disk 0 (already set by the bios we will reset it just in case)
	mov ch, 0x0 ; cylinder 0
	mov dh, 0x0 ; head 0
	mov cl, 0x2 ; sector 2 ( the count start from 1 not 0)	
	mov ah, 0x2 ; 'read'
	int 0x13
	jc disk_err
	popa
	ret	

	disk_err:
		mov bx, disk_msg
		call print
		jmp disk_halt
	
	disk_halt:
		jmp $


