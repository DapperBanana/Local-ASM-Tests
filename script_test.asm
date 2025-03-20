
START LDX #0         ; Initialize index for first string
LOOP1 LDA STR1,X     ; Load character from first string
     BEQ END1        ; If character is null, end of string reached
     JSR CHECK_CHAR  ; Call subroutine to check character
     INX             ; Increment index
     JMP LOOP1       ; Continue to next character

END1 LDX #0         ; Initialize index for second string
LOOP2 LDA STR2,X     ; Load character from second string
     BEQ END         ; If character is null, end of string reached
     JSR CHECK_CHAR  ; Call subroutine to check character
     INX             ; Increment index
     JMP LOOP2       ; Continue to next character
     
END BRK             ; End of program

CHECK_CHAR
     ; Check if character is in common between both strings
     STX INDEX        ; Store index in INDEX variable
     LDX #0           ; Initialize index for first string
CHECK_LOOP
     LDA COMMON,X     ; Load character from common characters
     BEQ ADD_CHAR     ; If character is null, add current character
     CMP STR1,X       ; Compare character with character from first string
     BEQ ADD_CHAR     ; If characters match, add current character
     INX              ; Increment index
     JMP CHECK_LOOP   ; Check next character
ADD_CHAR
     STA COMMON,X     ; Add current character to common characters
     STX INDEX        ; Store updated index
     RTS

INDEX .BYTE 0
COMMON .BYTE 0
STR1 .ASCII "hello"
STR2 .ASCII "world"
