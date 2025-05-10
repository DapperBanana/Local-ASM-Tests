
        .org $0200
start   lda #0          ; Initialize accumulator to 0
        sta sum         ; Store sum at memory location sum
        lda n           ; Load n from memory into accumulator
loop    cmp #0          ; Compare accumulator with 0
        beq end        ; Branch to end if n equals 0
        clc            ; Clear carry flag
        adc sum        ; Add sum to accumulator
        sta sum        ; Store result back in sum
        dex            ; Decrement n
        bne loop       ; Branch back to loop if n is not 0
end     nop            ; No operation, halt program
        rts            ; Return from subroutine

        .org $0300
n       .byte 10        ; Define n as 10
sum     .byte 0         ; Define sum as 0
