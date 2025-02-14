
        .org $0800

num           .ds 1            ; Number to check
num_digits    .ds 1            ; Number of digits in the number
sum_digits    .ds 1            ; Sum of the digits
temp          .ds 1            ; Temporary variable

        .org $1000

start:
        ldx #0                 ; Initialize digit counter
        ldy #0                 ; Initialize sum of digits
loop:
        lda num, x             ; Load the next digit
        cmp #$00                ; Check if end of number reached
        beq end                ; If end of number, exit loop
        clc                     ; Clear carry flag
        adc sum_digits         ; Add digit to sum
        sta sum_digits
        inx                    ; Move to next digit
        bne loop               ; Continue loop

end:
        lda sum_digits
        cmp num
        beq is_perfect         ; If sum of digits equals input number, then it is a perfect digital invariant
        jmp not_perfect

is_perfect:
        lda #$01
        sta temp
        rts

not_perfect:
        lda #$00
        sta temp
        rts

        .end
