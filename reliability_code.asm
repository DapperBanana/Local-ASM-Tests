
ORG $1000

START:
    JSR INPUT_STRING ; Input a string from the user
    LDX #0           ; Initialize vowel count to 0
    LDY #0           ; Initialize index of current character to 0
    
COUNT_VOWELS:
    LDA (STRING),Y   ; Load the current character into A
    CMP #65          ; Compare A with 'A'
    BCC CONSONANT    ; Branch if current character is less than 'A'
    CMP #90          ; Compare A with 'Z'
    BCS CONSONANT    ; Branch if current character is greater than 'Z'
    
    CMP #65          ; Check if current character is 'A'
    BEQ VOWEL        ; Branch if current character is 'A'
    CMP #69          ; Check if current character is 'E'
    BEQ VOWEL        ; Branch if current character is 'E'
    CMP #73          ; Check if current character is 'I'
    BEQ VOWEL        ; Branch if current character is 'I'
    CMP #79          ; Check if current character is 'O'
    BEQ VOWEL        ; Branch if current character is 'O'
    CMP #85          ; Check if current character is 'U'
    BEQ VOWEL        ; Branch if current character is 'U'

CONSONANT:
    INY              ; Increment index of current character
    CPY #LENGTH      ; Compare index with length of string
    BCC COUNT_VOWELS ; Branch if not end of string
    
OUTPUT_RESULT:
    LDX #0           ; Load 0 into X
    LDA VOWEL_COUNT  ; Load vowel count into A
    STA (OUTPUT),X   ; Store vowel count at the output address
    
    JMP $FFD2        ; Jump to kernel routine to print result
    
VOWEL:
    INY              ; Increment index of current character
    INX              ; Increment vowel count
    CPY #LENGTH      ; Compare index with length of string
    BCC COUNT_VOWELS ; Branch if not end of string
    JMP OUTPUT_RESULT ; Jump to output result
    
; Input a string from the user
INPUT_STRING:
    LDX #0
    LDA #' '         ; Load space character into A
    STA (STRING),X   ; Store space character at the start of the string
    
READ_CHAR:
    JSR $FFCF        ; Call kernel routine to read character
    STA (INPUT),X    ; Store input character at the end of the string
    INX              ; Increment index
    CPX #LENGTH      ; Compare index with length of string
    BCC READ_CHAR    ; Branch if not end of input
    
    RTS              ; Return from subroutine
    
STRING:
    .BLKW 50         ; Space for input string
OUTPUT:
    .BLKW 1          ; Space for output result
INPUT:
    .BLKW 1          ; Space for input character
VOWEL_COUNT:
    .BYTE 0
LENGTH:
    .BYTE 0
    
    .END
