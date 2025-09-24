
    .org $0200        ; start at memory address $0200

start:
    lda #$1E          ; load the decimal number 30 into accumulator
    sta number        ; store it in a memory location
    jsr decimalToBinary ; call the subroutine to convert it to binary

end:
    jmp end           ; infinite loop

decimalToBinary:
    lda number        ; load the decimal number into accumulator
    ldx #$08          ; initialize the loop counter to 8 bits
loop:
    asl               ; shift the accumulator left to get the next bit
    bcc zero          ; if no carry (bit 0), skip setting the bit
    ora #$01          ; set the least significant bit to 1
zero:
    dex               ; decrement the loop counter
    bne loop          ; continue the loop until all bits are processed
    rts               ; return from subroutine

number: .byte $00      ; memory location to store the decimal number

    .end
