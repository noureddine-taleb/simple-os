[bits 16]
print:
	pusha
	mov ah, 0xe
	print_loop:
	mov al, [bx]
	cmp al, 0
	je print_exit
	int 0x10
	inc bx
	jmp print_loop
	print_exit:
	call print_nl ; new line
	popa
	ret

print_nl:
	pusha
	mov ah, 0xe
	mov al, 0xa ; \n
	int 0x10
	popa
	ret

putc:
	pusha
	mov ah, 0xe
	mov al, bl
	int 0x10
	popa
	ret	

print_hex:
	pusha
	mov dx,bx

	mov bx, '0'
	call putc
	mov bx, 'x'
	call putc
	mov bx, dx
	;mov cx, 0xf ; the mask	
	;mov ax, 12 ; the mask bits
	;
	;hex_loop:
	;	shl cx, al ; setup the mask
	;	and bx, cx ; apply the mask
	;	shr bx, al ; extract the unmasked portion
	;	call hex_to_ascci ; add the magic number
	;	call putc  ; print the ascii
	;	sub ax, 4  ; move the next digit
	;	
	;	mov bx, dx  ; clean up
	;	mov cx, 0xf ; init mask
	;	cmp ax, 0
	;	jge  hex_loop ; exit if we exhausted the range :)
	;	hex_exit:
	;		popa
	;		ret
	and bx, 0xf000
	shr bx, 12
	call hex_to_ascci
	call putc
	mov bx,dx
	
	and bx, 0x0f00
	shr bx, 8
	call hex_to_ascci
	call putc
	mov bx,dx
		
	and bx, 0x00f0
	shr bx, 4
	call hex_to_ascci
	call putc
	mov bx,dx
	
	and bx, 0x000f
	shr bx, 0
	call hex_to_ascci
	call putc
	mov bx,dx

	call print_nl

	popa
	ret

hex_to_ascci:
	cmp bx, 0x9
	jle bx_is_num
	jmp bx_is_alp

	bx_is_num:
		add bx, 0x30
		jmp endif

	bx_is_alp:	
		add bx, 0x37
		jmp endif

	endif:
		ret
