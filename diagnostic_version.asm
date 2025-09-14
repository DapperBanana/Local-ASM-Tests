
        .org    $0200      ; Start address of program

list    .byte   2, 4, 6, 8, 10, 0 ; List of numbers (0 marks end of list)
result  .byte   0, 0, 0, 0, 0, 0   ; Array to store squared values

start   lda     #$00        ; Load accumulator with 0
        ldx     #$00        ; Load index register with 0

loop    lda     list, x     ; Load next number from list
        beq     end         ; If end of list, exit loop
        sta     $FF         ; Store current number in temp memory
        jsr     square      ; Call subroutine to calculate square
        sta     result, x   ; Store squared value in result array
        inx                 ; Increment index
        bne     loop        ; Continue loop

end     rts                 ; Return from subroutine

square  lda     $FF         ; Load current number from temp memory
        clc                 ; Clear carry flag
        adc     $FF         ; Add current number to accumulator (sqare)
        tax                 ; Transfer accumulator to index register
        lda     $FF         ; Load current number from temp memory again
        adc     $FF         ; Add current number to accumulator again (subtract 1)
        tax                 ; Transfer accumulator to index register
        lda     $FF         ; Load current number from temp memory again
        adc     $FF         ; Add final number to accumulator (subtract 1)
        rts                 ; Return from subroutine
