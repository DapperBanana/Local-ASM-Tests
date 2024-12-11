
ORG $1000   ; Start address

START:
    LDX #0   ; Initialize index for first character of string
    LDY #1   ; Initialize second index for comparison

LOOP:
    LDA STRING, X   ; Load first character into A register
    CMP STRING, Y   ; Compare with next character
    BEQ NOT_ISOGRAM ; Branch if characters are equal
    CPY #LENGTH     ; Check if end of string reached
    BEQ IS_ISOGRAM  ; Branch if end of string reached
    INX             ; Move to next character
    INY             ; Move to next comparison
    JMP LOOP        ; Repeat loop

IS_ISOGRAM:
    LDA #$01        ; Set flag to indicate isogram
    JMP DONE

NOT_ISOGRAM:
    LDA #$00        ; Set flag to indicate not isogram
    JMP DONE

DONE:
    BRK             ; End program

STRING:
    .ASCII "HELLO"     ; Input string to check for isogram
LENGTH = * - STRING    ; Calculate length of string

    END START   ; End of program
