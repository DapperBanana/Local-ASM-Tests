
        ; Program to determine if a number is even or odd

        .org $0200

number  .byte $2A    ; Change this value to test different numbers

        lda number
        and #$01        ; Masking off all but the least significant bit
        beq is_even     ; Branch if bit is 0 (even number)
        
        ; Odd number
        ; Output 1 for odd
        lda #1
        jsr $ffd2       ; Output value in accumulator

        ; Infinite loop
end     jmp end

is_even:
        ; Even number
        ; Output 0 for even
        lda #0
        jsr $ffd2       ; Output value in accumulator

        ; Infinite loop
        jmp end
