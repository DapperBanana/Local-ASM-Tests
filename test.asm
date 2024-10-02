
; Check if string at $1000-$1014 is an anagram of string at $2000-$2014

START:
    LDX #0         ; Initialize index
CHECK_LOOP:
    LDA $1000,X    ; Load character from first string
    CMP $2000,X    ; Compare with character from second string
    BEQ NEXT_CHAR  ; If equal, go to next character
    JMP NOT_ANAGRAM ; If not equal, strings are not anagrams

NEXT_CHAR:
    INX            ; Increment index
    CPX #15        ; Check if end of string reached
    BNE CHECK_LOOP ; If not, go to next character

    ; If program reaches here, then strings are anagrams
    ; Add code here to handle the anagram case

NOT_ANAGRAM:
    ; Add code here to handle the case where strings are not anagrams

    ; End of program
    RTS

; Data section
    .ORG $1000
    .BYTE "STRING1" ; First string
    .ORG $2000
    .BYTE "STRING2" ; Second string
