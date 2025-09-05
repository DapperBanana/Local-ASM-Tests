
        .org $1000

START   LDX #$00                ; Initialize index for start of substring
        LDY #$00                ; Initialize index for end of substring
        LDA #$00                ; Initialize length of longest palindromic substring
        LDY #$01

FIND    LDA INPUT, X            ; Load character at index X
        CMP #0                  ; Check for end of string
        BEQ END                ; If end of string, go to end
        STA TEMP                ; Store character in TEMP
        CLC                     ; Clear carry flag

CHECK   CMP INPUT, Y            ; Compare characters at indexes X and Y
        BEQ PALINDROME          ; If characters match, check next characters
        CMP #0                  ; If end of string, go to end
        BEQ END                ; If end of string, go to end
        INC Y                   ; Move Y to next character
        JMP CHECK               ; Check next characters

PALINDROME
        CMP #$00                ; Check for end of string
        BEQ END                ; If end of string, go to end
        DEC Y                   ; Move Y back to valid character
        SEC                     ; Set carry flag
        CMP TEMP                ; Compare characters at indexes X and Y
        BNE NEXT                ; If not matching, go to next substring
        INC X                   ; Move X to next character
        DEC Y                   ; Move Y back to valid character
        INC LENGTH              ; Increase length of palindromic substring
        JMP CHECK               ; Check next characters

NEXT    INC X                   ; Move X to next character
        LDA LENGTH              ; Load length of palindromic substring
        CMP LONGEST             ; Compare length with longest found so far
        BCC UPDATE              ; If longer, update longest palindromic substring
        LDA #$00                ; Reset length
        LDY X                   ; Move Y to next character
        JMP FIND                ; Find next substring

UPDATE  STA LONGEST            ; Update longest palindromic substring
        JMP FIND                ; Find next substring

END     BRK

INPUT   .asciiz "abcbade"
TEMP    .byte $00
LENGTH  .byte $00
LONGEST .byte $00

        .end
