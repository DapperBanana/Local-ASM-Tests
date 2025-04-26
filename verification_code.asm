
; Check if two strings are anagrams
; Assume the strings are terminated with a zero byte

; Input:
; - Two strings in memory
; Output:
; - Carry flag set if anagrams, clear if not

START:
    LDX #0
    LDY #0
    CLC     ; Clear carry flag
    
LOOP1:
    LDA (STRING1), Y
    BEQ CHECK
    STA TEMP, X
    INY
    INX
    JMP LOOP1

CHECK:
    LDX #0
    LDY #0
    
LOOP2:
    LDA (STRING2), Y
    BEQ COMPARE
    STA TEMP2, X
    INY
    INX
    JMP LOOP2

COMPARE:
    CPX #0
    BNE NOT_ANAGRAM
    
; Compare characters
    LDX #0
COMPARE_LOOP:
    LDA TEMP, X
    CMP TEMP2, X
    BNE NOT_ANAGRAM
    INX
    CPX #0
    BNE COMPARE_LOOP
    
    SEC     ; Strings are anagrams
    RTS

NOT_ANAGRAM:
    CLC     ; Strings are not anagrams
    RTS

STRING1:
    .BYTE 'A','B','C','D',0
STRING2:
    .BYTE 'D','C','B','A',0
TEMP:
    .BYTE 0
TEMP2:
    .BYTE 0
