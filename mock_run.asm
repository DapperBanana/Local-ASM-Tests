
; Program to convert a decimal number to binary

        .org $0200       ; set program start address

start   lda #32         ; set bit counter to 32
        sta bit_counter

input   lda #13         ; input decimal number to convert
        sta decimal_num

convert lsr decimal_num ; shift right the decimal number
        bcc skip       ; if carry flag is clear, skip
        ora #128       ; if carry flag is set, set bit 7
skip    dec bit_counter ; decrement bit counter
        bne convert    ; if bit counter is not 0, continue converting

output  lda decimal_num ; output binary number
        sta $0200       ; store result in memory location $0200

end     jmp end         ; end of program loop forever

bit_counter .byte 0
decimal_num .byte 0

        .end            ; end of assembly program
