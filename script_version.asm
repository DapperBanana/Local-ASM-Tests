
    .org $0200   ; start program at address $0200
start:
    lda number   ; load the number into the accumulator
    jsr sqrt     ; call subroutine to calculate the square root of the number
    asl          ; multiply the result by 2 to get the square
    sta square   ; store the result in the square variable
    ldx square   ; load the square into the X register
    cmp number   ; compare the square to the original number
    beq perfect  ; if they are equal, jump to the perfect label
    jmp notPerfect ; otherwise, jump to the notPerfect label

perfect:
    lda #$01     ; load 1 into the accumulator to indicate that the number is a perfect square
    sta result   ; store the result in the result variable
    rts          ; return from subroutine

notPerfect:
    lda #$00     ; load 0 into the accumulator to indicate that the number is not a perfect square
    sta result   ; store the result in the result variable
    rts          ; return from subroutine

sqrt:
    lda #$00     ; clear accumulator
    sta sqrtVal  ; clear sqrt variable
loop:
    lda sqrtVal  ; load sqrt variable into accumulator
    clc          ; clear carry bit
    adc #$01     ; add 1 to accumulator
    sta sqrtVal  ; store accumulator in sqrt variable
    lda sqrtVal  ; load sqrt variable into accumulator
    cmp number   ; compare sqrt to number
    bcc loop     ; branch back to loop if sqrt is less than number
    rts          ; return from subroutine

number: .byte 36   ; the number to check for being a perfect square
square: .byte 0    ; variable to store calculated square
result: .byte 0    ; variable to store result of check
sqrtVal: .byte 0   ; variable to store square root

    .end         ; end of program
