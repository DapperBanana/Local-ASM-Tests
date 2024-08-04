
; 6502 Assembly program to check if a year is a leap year

    .org $2000    ; Start address

start:
    lda year      ; Load the value of the year into the accumulator
    cmp #$04      ; Check if the year is divisible by 4
    bne not_leap  ; If not, skip the leap year check
    cmp #$64      ; Check if the year is divisible by 100
    beq not_leap  ; If it is, skip the leap year check
    cmp #$0C      ; Check if the year is divisible by 400
    bne not_leap  ; If not, skip the leap year check

is_leap:
    lda #$01      ; If all conditions are met, the year is a leap year
    sta result    ; Store the result in the result variable
    jmp end       ; End the program

not_leap:
    lda #$00      ; If the year is not a leap year, store 0 in the result variable
    sta result
    jmp end       ; End the program

end:
    rts           ; Return from subroutine

year:
    .byte $1A     ; The year value to be checked

result:
    .byte $00     ; Variable to store the result (1 if leap year, 0 if not)

    .end          ; End of program
