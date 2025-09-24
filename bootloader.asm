org 7C00h
bits 16

start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax

	mov sp, 7C00h 
	
	mov si, booting_msn
	call printf

	call disk_load

printf:
	pusha
	.looping:
		lodsb				; AL <- [SI], SI++
		cmp al, 0		  	; se AL for igual a Zero
		je .printf_end			; se for verdadeiro, ele salta para o FIM
		mov ah, 0Eh			; função teletype
		int 10h				; chamando impressão
		jmp .looping
	.printf_end:
		popa
		ret

disk_load:
	mov si, disk_load_msn
	call printf

	mov ah, 02h
	mov al, 10				; núm. setores
	mov ch, 0
	mov dh, 0
	mov cl, 2
	mov dl, 80h
	mov bx, 0000h
	mov es, bx
	xor bx, bx
	int 13h     

        jc .disk_error
	jmp 1000h:0000h

	.disk_error:
		mov si, disk_error_msn
		call printf
		jmp $

;; MENSAGENS DE CARREGAMENTO DO BOOTLOADER
disk_load_msn:
	db '[DISCO]: Carregando o Disco. Aguarde ...', 0Dh, 0Ah, 0 
booting_msn:
	db '[BOOT]: Meu primeiro Bootloader. Ola, Kernel!', 0Dh, 0Ah, 0

;; MENSAGENS DE ERRO DO BOOTLOADER
disk_error_msn:
	db '[DISCO]: Houve um error ao carregar o Disco. Kernel nao foi encontrado', 0Dh, 0Ah, 0

times 510 - ($ - $$) db 0
dw 0xAA55
