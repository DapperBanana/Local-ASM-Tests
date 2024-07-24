
    ; Generate a random alphanumeric password
    ;
    ; Inputs: None
    ; Outputs: Password stored in memory at $0300-$0309

    .org $0200 ; Start of program

generate_password:
    ldx #0              ; Initialize index register to 0

loop:
    lda #$41            ; Load ASCII 'A' (65) into the accumulator
    jsr randomize       ; Call subroutine to generate random number
    sta $0300, x        ; Store the random character in memory at $0300-$0309
    inx                 ; Increment index register
    cpx #10             ; Check if we have generated 10 characters
    bne loop            ; If not, repeat loop

    rts

randomize:
    lda $C0             ; Load the current value of the CIA timer into the accumulator
    asl                 ; Shift left to discard lower bits
    rol                 ; Rotate left to set carry flag
    clc                 ; Clear carry flag
    adc #$EF            ; Add $EF to the accumulator
    ror                 ; Rotate right to get 0-255 range
    ror                 ; Another rotate right for better randomness
    ror                 ; Another rotate right for better randomness
    rts

    .org $0300 ; Location to store generated password
