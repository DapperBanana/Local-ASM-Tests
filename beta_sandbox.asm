
START:
    LDX #0          ; Initialize index for first string
    LDY #0          ; Initialize index for second string
    LDA $1000,X     ; Load first character of first string
    CMP #0          ; Check if end of string
    BEQ END         ; If end of string, exit program

LOOP:
    STA CURR_CHAR   ; Store current character
    LDA $2000,Y     ; Load first character of second string
    CMP #0          ; Check if end of string
    BEQ END         ; If end of string, exit program

    CMP CURR_CHAR   ; Compare characters
    BEQ MATCH       ; If characters match, store in array and move to next character

    INY             ; Move to next character in second string
    JMP LOOP        ; Repeat for next character
  
MATCH:
    STA RESULT,X    ; Store matching character in result array
    INX             ; Move to next index in result array
    INY             ; Move to next character in second string
    JMP LOOP        ; Repeat for next character

END:
    RTS             ; End program

CURR_CHAR: .BYTE 0   ; Current character
RESULT: .BYTE 0       ; Result array

    .ORG $FFFC      ; Set program start address
    .WORD START     ; Start program at START
