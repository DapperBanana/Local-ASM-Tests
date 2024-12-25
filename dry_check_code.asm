
    .text

start:
    lda $2000  ; Load the memory address of the string into A register
    sta $2005  ; Store the address into memory location 2005
    ldx #0     ; Initialize X register to 0 (counter for character count)

count_loop:
    lda ($2005),y  ; Load the next character of the string into the A register
    beq end_loop   ; If end of string is reached, exit loop
    cmp $2000      ; Compare the current character with the start of the string
    bne update_count  ; If character is not the start of the string, update the count
    jmp next_char    ; Jump to the next character

update_count:
    inx             ; Increment the X register (character count)
    lda $3000,x     ; Load the current count of the character into A register
    clc
    adc #1          ; Increment the count of the character
    sta $3000,x     ; Store the updated count back in memory
    jmp next_char   ; Jump to the next character

next_char:
    iny             ; Increment Y register (increment address of string)
    lda ($2005),y   ; Load next character into A register
    jmp count_loop  ; Continue counting characters

end_loop:
    rts             ; Return from subroutine

    .data
string: .asciiz "HELLO, WORLD!"  ; Input string
char_count: .ds 256               ; Array to store character counts
