/*
**  .d88b.   .d88b.  .d8888b  
** d88P"88b d88""88b 88K      
** 888  888 888  888 "Y8888b. 
** Y88b 888 Y88..88P      X88 
**  "Y88888  "Y88P"   88888P' 
**      888                   
** Y8b d88P                   
**  "Y88P"                    
*/
global loader                           ; the entry symbol for ELF

MAGIC_NUMBER equ 0x1BADB002             ; define the magic number constant
FLAGS equ 0x0                           ; multiboot flags
CHECKSUM equ -MAGIC_NUMBER              ; calculate the checksum
                                        ; (magic number + checksum + flags should equal 0)

section .text:                          ; start of the text (code) section
align 4                                 ; the code must be 4 byte aligned
  dd MAGIC_NUMBER                       ; write the magic number to the machine code,
  dd FLAGS                              ; the flags,
  dd CHECKSUM                           ; and the checksum

loader:                                 ; the loader label (defined as entry point in linker script)
  mov eax, 0xCAFEBABE                   ; place the number 0xCAFEBABE in the register eax
.loop:
  jmp .loop                             ; loop forever