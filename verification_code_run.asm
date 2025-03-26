
        lda #0             ; clear accumulator
        sta result         ; initialize result to 0

        ldx #8             ; initialize loop counter for 8 bits
loop:
        asl number         ; shift left to prepare for next bit
        bcc noAdd          ; if carry flag is clear, no need to add 1
        inc result         ; add 1 to result if carry flag is set
noAdd:
        lda result         ; load result into accumulator
        asl                ; shift left to make room for next bit
        sta result         ; store back in result

        dex                ; decrement loop counter
        bne loop           ; loop until all 8 bits are converted

        rts                ; return from subroutine

result: .byte 0            ; result variable to store the binary number
number: .byte 123          ; decimal number to convert to binary
