
        .org $1000      ; Start address of the program

decimal_number  .byte $12     ; Decimal number to convert (change this value as needed)

fraction_numerator   .word 0  ; Initialize numerator
fraction_denominator .word 1  ; Initialize denominator

start:
    lda decimal_number      ; Load the decimal number
    clc                     ; Clear the carry flag
    ldx #0                  ; Initialize index register
loop:
    cmp #0                  ; Compare with zero
    bcc final_output        ; If less than zero, exit loop
    asl                     ; Multiply by 2
    inx                     ; Increment index
    bcc loop                ; Repeat loop

final_output:
    sta fraction_denominator   ; Store result in denominator
    ldy fraction_denominator
    lda #$00
    ldx #$01

loop2:
    lda fraction_numerator
    clc
    adc fraction_numerator
    bcc overflow
    dey
    adc fraction_denominator
    inx
    jmp loop2

overflow:
    lda x
    cmp #$1
    bne finish
    stx fraction_denominator
    lda #$ff
    sta fraction_numerator
    jmp finish

finish:
    
    ; End of program
    rts

    .end
