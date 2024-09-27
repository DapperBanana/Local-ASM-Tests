
START:
    LDX #0          ; Initialize index for string 1
    LDY #0          ; Initialize index for string 2
    
FIND_NEXT_CHAR:
    LDA STR1,X      ; Load character from string 1
    BEQ END         ; If end of string 1, exit
    STA CHAR1       ; Store character from string 1
    
    LDA STR2,Y      ; Load character from string 2
    BEQ END         ; If end of string 2, exit
    STA CHAR2       ; Store character from string 2

    CMP CHAR1, CHAR2 ; Compare characters
    BEQ CHAR_MATCH   ; If characters match, increment both indexes
    
    LDA COUNT       ; Load current count
    STA MAX_COUNT   ; Store current count as max count
    
    JSR RESET_COUNT  ; Reset count
    
CHAR_MATCH:
    INX             ; Increment index for string 1
    INY             ; Increment index for string 2
    
    JSR INCREMENT_COUNT ; Increment count
    
    JMP FIND_NEXT_CHAR ; Continue to next characters

END:
    BRK             ; Exit program
    
RESET_COUNT:
    LDA #0
    STA COUNT
    RTS
    
INCREMENT_COUNT:
    LDA COUNT
    CLC
    ADC #1
    STA COUNT
    RTS

; Data Section
COUNT: .BYTE 0
MAX_COUNT: .BYTE 0
CHAR1: .BYTE 0
CHAR2: .BYTE 0
STR1: .BYTE "ABCD", 0  ; String 1
STR2: .BYTE "ACBD", 0  ; String 2
