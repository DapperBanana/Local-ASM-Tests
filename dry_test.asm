
; Program to find the longest common subsequence of two strings

CSTRING1 .BYTE "STRING1"
CSTRING2 .BYTE "STRING2"

LDX #0 ; Initialize index for string 1
STX INDEX1

LDX #0 ; Initialize index for string 2
STX INDEX2

LDX #0 ; Initialize counter for common subsequence length
STX LCS_LENGTH

LOOP1:
    LDA CSTRING1, X ; Load character from string 1
    CMP #0 ; Check if end of string
    BEQ END ; If end of string, exit loop
    
    STX TEMP_INDEX1 ; Save current index for string 1 before comparing
    
    LDX #0 ; Reset index for string 2
    STX INDEX2

LOOP2:
    LDA CSTRING2, X ; Load character from string 2
    CMP #0 ; Check if end of string
    BEQ NEXT ; If end of string, go to next character in string 1
    
    STX TEMP_INDEX2 ; Save current index for string 2 before comparing
    
    CMP CSTRING1, TEMP_INDEX1 ; Compare characters
    BEQ MATCH ; If characters match, increment common subsequence length
    
    INX ; Increment index for string 2
    JMP LOOP2 ; Loop to next character in string 2
    
MATCH:
    INX ; Increment index for string 2
    LDY LCS_LENGTH ; Load common subsequence length
    INY ; Increment common subsequence length
    STY LCS_LENGTH ; Store updated common subsequence length
    
    JMP LOOP2

NEXT:
    LDX TEMP_INDEX1 ; Restore index for string 1
    INX ; Increment index for string 1
    STX INDEX1 ; Store updated index for string 1
    
    JMP LOOP1

END:
    BRK ; Exit program

INDEX1 .BYTE 0
INDEX2 .BYTE 0
TEMP_INDEX1 .BYTE 0
TEMP_INDEX2 .BYTE 0
LCS_LENGTH .BYTE 0

