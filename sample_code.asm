
        .org $0200

START   LDX #$00      ; Initialize X register
LOOP    JSR RAND      ; Call random number generator subroutine
        AND #$3F      ; Mask out all but the lower 6 bits
        CMP #$1A      ; Compare with 'Z'
        BPL IS_NUMBER  ; Branch if greater or equal to 'Z'
        ORA #$30      ; Convert value to ASCII number
        JMP STORE     ; Jump to store the character
IS_NUMBER 
        ADD #$41      ; Convert to ASCII letter
STORE   STA RESULT,X  ; Store character in result array
        INX           ; Increment X register
        CPX #$08      ; Have we generated 8 characters?
        BNE LOOP      ; If not, repeat loop
        RTS           ; Return from subroutine

RAND    LDA $D019     ; Read timer low byte
        AND #$FF       ; Clear upper 8 bits
        RTI           ; Return from interrupt

RESULT  .block $08     ; Array to store password

        .end
