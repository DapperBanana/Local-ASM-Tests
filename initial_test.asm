
START:
    LDX #0         ; Initialize index of string 1
    LDY #0         ; Initialize index of string 2
    LDZ #0         ; Initialize index of subsequence
    
LOOP:
    LDA STR1,X     ; Load character from string 1
    CMP #0          ; Check if end of string 1
    BEQ END_LOOP    ; If end of string 1, exit loop
    STA TMP1       ; Store current character in TMP1
    
    LDY #0         ; Reset index of string 2
    
INNER_LOOP:
    LDA STR2,Y     ; Load character from string 2
    CMP #0          ; Check if end of string 2
    BEQ CHECK_SUBSEQUENCE ; If end of string 2, check subsequence
    
    CMP TMP1       ; Compare characters
    BEQ MATCH      ; If characters match, execute the MATCH subroutine
    
    INY            ; Increment index of string 2
    JMP INNER_LOOP ; Repeat inner loop
    
MATCH:
    STA SUBSEQUENCE,Z ; Store matching character in subsequence
    INZ            ; Increment index of subsequence
    
    INX            ; Increment index of string 1
    JMP LOOP       ; Repeat main loop
    
CHECK_SUBSEQUENCE:
    LDA SUBSEQUENCE,X ; Load character from subsequence
    CMP #0          ; Check if end of subsequence
    BEQ PRINT_SUBSEQUENCE ; If end of subsequence, print subsequence
    
    INX            ; Increment index of subsequence
    JMP CHECK_SUBSEQUENCE ; Repeat check subsequence
    
PRINT_SUBSEQUENCE:
    LDA #0          ; Load null terminator
    STA SUBSEQUENCE,Z ; Ternimate subsequence string
    ; Print subsequence here
    
END_LOOP:
    RTS            ; Return from subroutine
    
; Define variables
STR1: .asciiz "ACBDE"
STR2: .asciiz "ADBCE"
SUBSEQUENCE: .ds 10
TMP1: .byte 0
