; this routine incapsule instr to switch to 32 bit
; no return from this
[bits 16]
switch_pm:
	cli
	lgdt [gdt_descriptor] ; load the gdt
	mov eax, cr0
	or eax, 0x1  ; set the bit
	mov cr0, eax ; make the switch
	jmp CODE_SEG:init_pm ; this will flush the cpu pipeline

[bits 32]
init_pm:
	; setup segments registers
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; setup the stack (overwrite it)
	mov ebp, 0x90000
	mov esp, ebp

	call start_pm
	jmp $


