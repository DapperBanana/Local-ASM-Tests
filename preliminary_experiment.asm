
    .section .text
    .globl _start

_start:
    lda #3      ; edge length of the tetrahedron
    jsr cube    ; calculate the cube of the edge length
    tax          ; save the result in X register
    
    lda #0
    sta result  ; clear the result variable
    
    lda #6      ; constant multiplier
    clc
loop:
    adc result   ; add the result to itself
    dex
    bne loop     ; repeat until X equals 0
    
    asl         ; multiply the result by 2
    tax         ; save the result in X register
    
    lda result  ; load the result
    ldx #4
    jsr div     ; divide the result by 4
    sta result  ; save the result
    
    lda #result ; load the result to print
    jsr print   ; print the result
    
    jmp end     ; end the program

cube:
    mul a       ; multiply A register with itself
    rts         ; return from subroutine

div:
    clc
div_loop:
    cmp #0
    bcc div_end
    sbc y
    inc result
    bcs div_loop
div_end:
    rts

print:
    tax         ; transfer A to X
    ldy #3
print_loop:
    ldx result  ; load the result
    and #0x0F   ; extract the digit
    ora #0x30   ; convert the digit to ASCII
    jsr putchar ; print the digit
    lda result  ; shift right one decimal place
    lsr
    sta result
    dey
    bne print_loop
    rts

putchar:
    jsr $ffd2   ; KERNAL routine to print a character
    rts

.result: .res 1

end:
    lda #0
    jsr $FFD2   ; exit the program
