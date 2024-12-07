
        .org $0600

START:

    LDX #$00           ; Load X register with 0
    LDY #$00           ; Load Y register with 0

READ_LOOP:
    LDA $C000,X        ; Load next byte from file into accumulator
    CMP #$0D           ; Check if byte is newline character 
    BEQ DONE           ; If newline character, exit loop
    CMP #','            ; Check if byte is comma delimiter
    BEQ PRINT_NEXT     ; If comma delimiter, print next value
    JSR $FFD2          ; Print character in accumulator
    INX                ; Increment X register
    BNE READ_LOOP      ; Continue reading file
    
PRINT_NEXT:
    LDA #','           ; Load comma delimiter into accumulator
    JSR $FFD2          ; Print comma
    INX                ; Increment X register
    BRA READ_LOOP      ; Continue reading file

DONE:
    BRK                ; Exit program

    .org $FFFA
    .word START        ; Set reset vector to start of program
