
    .org $0200

start:
    lda #$00        ; Initialize variables
    sta year
    lda #$00
    sta reversed_year

    lda #<year_input ; Load low byte of year_input into ACC
    sta $FD         ; Store low byte into zero page memory
    lda #>year_input ; Load high byte of year_input into ACC
    sta $FE         ; Store high byte into zero page memory
    
    jsr reverse_year  ; Call subroutine to reverse the year
    
    lda year
    cmp reversed_year   ; Compare original year with reversed year
    beq is_palindrome   ; If equal, year is a palindrome
    jmp not_palindrome  ; If not equal, year is not a palindrome

is_palindrome:
    lda #$01        ; Set flag to 1 if year is a palindrome
    jmp end

not_palindrome:
    lda #$00        ; Set flag to 0 if year is not a palindrome

end:
    rts

reverse_year:
    lda #$00        ; Initialize variables
    sta reversed_year

loop:
    lda year
    lsr             ; Shift right to get the least significant digit
    bcc skip
    inc reversed_year   ; Increment reversed_year if carry bit is set
skip:
    lsr             ; Shift right again
    tax             ; Store last digit in X register
    lda reversed_year   ; Load reversed_year into ACC
    asl             ; Shift left to make room for new digit
    adc #$00        ; Add the last digit (in X register) to reversed_year
    sta reversed_year   ; Store the new reversed_year
    lda year
    ldx#$00
    bmi done
    jmp loop

done:
    rts

year_input:
    .word $2000    ; Enter the year to check here

year:
    .byte $00      ; Original year
reversed_year:
    .byte $00      ; Reversed year

    .end
