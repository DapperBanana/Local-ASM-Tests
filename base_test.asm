
; 6502 Assembly program to check if a given string is a valid IPv4 address

START   LDX #0          ; Initialize index register X to 0
        LDA STRING,X    ; Load first character of the string
        BEQ END         ; Branch to END if end of string is reached
IS_DIGIT CMP #$30       ; Compare character to ASCII '0' (digit)
        BCC NOT_VALID   ; Branch if less than '0' (not a digit)
        CMP #$39        ; Compare character to ASCII '9' (digit)
        BCS NOT_VALID   ; Branch if greater than '9' (not a digit)
        INX             ; Increment index register X
        CPX #4          ; Check if 4 digits have been checked
        BEQ VALID_IP    ; Branch to VALID_IP if 4 digits have been checked
        JMP START       ; Jump back to START to continue checking next character
NOT_VALID
        LDA #$00        ; Load 0 into accumulator (invalid IP)
        STA RESULT      ; Store result in memory location RESULT
        JMP END         ; Jump to END
VALID_IP
        LDA #$01        ; Load 1 into accumulator (valid IP)
        STA RESULT      ; Store result in memory location RESULT
END     BRK             ; Break program execution

STRING  .ASC "192.168.1.1"  ; Define input string to check
RESULT  .BYTE 0            ; Define memory location to store result
