gdt_start:
	dq 0x0 ; the first segment descriptor is just 8 null bytes to raise int if *s is not set :)

;the 2nd sd
gdt_code:
	dw 0xffff ; the size of the segment 16bit
	dw 0x0    ; base: the starting address 20bit
	db 0x0	  ; base
	db 10011010b ; flags
	db 11001111b ; flags
	db 0x0 ; base

gdt_data:
	dw 0xffff ; the size of the segment 16bit
	dw 0x0    ; base: the starting address 20bit
	db 0x0	  ; base
	db 10010010b ; flags
	db 11001111b ; flags
	db 0x0 ; base

gdt_end:

gdt_descriptor:
	dw gdt_end-gdt_start-1 ; length
	dd gdt_start	       ; base

; some usefull var for sd offsets
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

	

