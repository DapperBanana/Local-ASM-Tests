
    ; Input string
    STRING .BYTE "HELLO WORLD THIS IS A TEST PROGRAM HELLO WORLD",0

    ; Buffer to store the word being counted
    BUFFER .BLKB 20

    ; Output array to store the counts of each word
    COUNTS .BLKW 10

    ; Initialize counters
    LDX #0
LOOP:
    ; Initialize new word counter
    LDA #0
    STA COUNTS,X

    ; Get a word from the input string
GET_WORD:
    LDA STRING,X
    BEQ END_STRING
    
    ; Check for whitespace or end of string
    CMP #' '   
    BEQ SKIP_SPACE

    ; Add character to buffer
    STA BUFFER,X
    INX
    JMP GET_WORD

SKIP_SPACE:
    ; Null terminate buffer
    STA BUFFER,X
    LDA #0
    STA BUFFER,X

    ; Increase word count for buffer
    LDX #0
COMPARE_WORD:
    LDA BUFFER,X
    BEQ INCREMENT_COUNT
    CMP BUFFER,X
    BNE CHECK_NEXT_WORD
    INX
    JMP COMPARE_WORD

INCREMENT_COUNT:
    LDA COUNTS,X
    CLC
    ADC #1
    STA COUNTS,X
    JMP CHECK_NEXT_WORD

CHECK_NEXT_WORD:
    INX
    CPX #10
    BEQ END_STRING
    JMP COMPARE_WORD
    
END_STRING:
    ; Output results
    LDA #'A'
    JSR $FFD2

    LDX #0
OUTPUT_COUNTS:
    LDA COUNTS,X
    BEQ END_OUTPUT
    JSR $FFD2
    INX
    JMP OUTPUT_COUNTS

END_OUTPUT:
    BRK

    ; Data section
    .ORG $C000
    .WORD BUFFER
    .WORD COUNTS
