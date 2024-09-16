
        .org $0200

start   lda #0              ; Initialize sum to 0
        sta sum
        lda #10             ; Initialize counter to 10
        sta counter

loop    lda num, x          ; Load digit from number
        clc
        adc sum             ; Add digit to sum
        sta sum
        dex
        bne loop            ; Repeat for all digits

        lda sum
        cmp num             ; Compare sum with original number
        beq is_invariant    ; If equal, number is a perfect digital invariant

done    rts

is_invariant
        lda #$01            ; Set carry flag to indicate number is a perfect digital invariant
        jsr print_status
        rts

print_status
        ; Your code here to print the status of the number (perfect digital invariant or not)
        rts

num     .byte $03, $06, $09, $0C, $0F, $12, $15   ; Change these values to test different numbers

counter .byte 0
sum     .byte 0

        .end
