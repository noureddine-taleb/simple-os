[ org 0x7c00 ]

KERNEL_OF equ 0x1000 ; location to load the kernel to
KERNEL_SECT_NO equ 7 ; number of sectors kernel have

mov bp, 8000
mov sp, bp

; 1st stage: load kernel
call load_kernel

; 2nd stange: switch to 32bit pm
mov bx, MSG_SWITCH_TO_PM
call print

call switch_pm

exit:
	jmp $

; libs
;3rd stage: execute our kernel
%include 'lib/print.S'
%include 'lib/disk.S'
%include 'lib/pm/gdt.S'
%include 'lib/pm/pm_switch.S'
%include 'lib/pm/pm_print.S'

[bits 16]
MSG_LOAD_KERNEL: db 'Loading the kernel...',0
MSG_SWITCH_TO_PM: db 'Switching to 32 bit protected mode...',0
MSG_RUN_KERNEL: db 'calling the loaded kernel',0

load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print
	mov al, KERNEL_SECT_NO ; just in case we have more sectors on our kernel
	mov bx, KERNEL_OF
	call disk_load
	ret


[bits 32]
start_pm:
	mov ebx, MSG_RUN_KERNEL
	call pm_print
	call KERNEL_OF
	jmp exit ; just in case our kernel exit (it shouldn't :) btw)


times 510-($-$$) db 0
dw 0xaa55
