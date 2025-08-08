
; Square root calculation using Newton-Raphson method

START LDA NUMBER      ; Load the number into accumulator
    STA INPUT        ; Store it in the input variable
    LDX #$00         ; Initialize X register to 0

LOOP LDY #$00          ; Initialize Y register to 0
    LDA INPUT         ; Load the input into accumulator
    SEC
    SBC X             ; Subtract the current value of X from the input
    BCC ENDLOOP       ; If result is negative, end the loop

    STA TEMP          ; Store the result in temporary variable
    LDA INPUT         ; Load the input into accumulator
    SEC
    SBC X             ; Subtract the current value of X from the input
    SBC TEMP          ; Subtract the temporary variable from the result
    BCS SKIP

    DEY               ; If borrow occurred, decrement Y
    CPY #$00          ; Check if Y is 0
    BEQ ROOT          ; If Y is 0, calculate square root

    BNE SKIP          ; If Y is not 0, continue with next iteration

SKIP INX               ; Increment X
    JMP LOOP          ; Continue the loop

ROOT LDX INPUT         ; Load the input into X register
    JMP END           ; Jump to the end of the program

END   ; Square root calculation complete

NUMBER .byte $25       ; Number for which square root is to be calculated
INPUT  .byte $00       ; Variable to store input number
TEMP   .byte $00       ; Temporary variable

