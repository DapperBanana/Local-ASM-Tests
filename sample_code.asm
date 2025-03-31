
    .org $0200

year    .byte $00  ; the year to be checked (e.g. 2022)
result  .byte $00  ; result of leap year check (0 = not leap year, 1 = leap year)

    lda year    ; load the year to be checked
    cmp #0       ; check if the year is zero
    beq done     ; if it is zero, exit program with result 0

    sec          ; set carry flag
    ldx #4       ; X register holds value 4
    jsr div      ; divide the year by 4
    bcs leap     ; if remainder is zero, the year is a leap year
    jmp done     ; otherwise, exit program with result 0

leap    lda year    ; load the year to be checked
        bne div      ; if the year is not zero, divide it by 100
        rts         ; if the year is zero, exit program with result 1

div     sbc #0      ; subtract 0 from the year
        rol         ; perform single left rotate on accumulator
        ror result  ; rotate left into result
        dex         ; decrement X register
        bne div      ; repeat division until X is zero
        rts         ; return from subroutine

done    rts         ; exit program with result
