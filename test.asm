
.org $0200

start:
    lda year     ; Load the year into the accumulator
    sta temp     ; Store the year in a temporary variable
    
    ldx #3       ; Set X register to 3 for the loop counter
    
check_loop:
    lda temp     ; Load the original year from the temporary variable
    lsr          ; Shift right the least significant digit to the carry flag
    sta temp     ; Store the updated year back in the temporary variable

    cmp year     ; Compare the original year with the updated year
    bne not_palindrome   ; Branch if not equal
    
    dex          ; Decrement the loop counter
    bpl check_loop      ; Branch if loop counter is still positive
    
    lda #$01     ; Load 1 into the accumulator to indicate that it is a palindrome year
    jmp end
    
not_palindrome:
    lda #$00     ; Load 0 into the accumulator to indicate that it is not a palindrome year

end:
    sta result   ; Store the result in the result variable
    rts

result: .byte 0
temp:   .byte 0

year:   .byte 1991   ; Change this year to the desired input year

