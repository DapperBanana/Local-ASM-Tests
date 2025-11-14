
START:
    LDX #0              ; Initialize index to 0
    LDA NUM             ; Load the number to be checked
CHECK_LOOP:
    STA TEMP            ; Store the number in a temporary variable
    LSR                 ; Shift right one bit to get the last digit
    BEQ END_LOOP        ; If number is zero, end loop
    AND #$0F            ; Mask out all but last digit
    CMP TEMP            ; Compare digit with original number
    BNE NOT_INVARIANT   ; Branch if not invariant
    INX                 ; Increment index
    JMP CHECK_LOOP      ; Continue loop
NOT_INVARIANT:
    LDA #0              ; Load 0 into accumulator to indicate not invariant
    STA RESULT
    JMP END_PROGRAM     ; Jump to end program
END_LOOP:
    LDA #1              ; Load 1 into accumulator to indicate invariant
    STA RESULT
END_PROGRAM:
    RTS                 ; Return from subroutine

NUM     .BYTE $42        ; Number to be checked
TEMP    .BYTE 0          ; Temporary variable
RESULT  .BYTE 0          ; Result variable
