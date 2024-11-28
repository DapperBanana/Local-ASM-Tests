
; PROGRAM TO FIND LONGEST COMMON SUBSEQUENCE OF TWO STRINGS

; INPUT:
; - Pointers to the two strings in memory
; OUTPUT:
; - Length of the longest common subsequence
; - The longest common subsequence itself

; Define some constants
BUFFER_SIZE = $80
STR1_OFFSET = $10
STR2_OFFSET = $20
RESULT_OFFSET = $30

; Load pointers to the two strings
    LDA STR1_OFFSET
    STA STR1_PTR
    LDA STR2_OFFSET
    STA STR2_PTR

; Initialize buffer for storing results
    LDX RESULT_OFFSET
    LDA #0
    STX 0,X
    INX
    STX 0,X

; Initialize variables
    LDA #0
    STA MAX_LEN
    STA CURR_LEN
    STA CURR_OFFSET

; Loop through each character of the first string
LOOP1:
    LDX STR1_PTR
    LDY CURR_OFFSET
    LDA 0,X
    STA CHAR1
    BEQ END1

    ; Loop through each character of the second string
    LDX STR2_PTR
LOOP2:
    LDA 0,X
    BEQ END2
    CMP CHAR1
    BEQ MATCH
    DEY
    BNE LOOP2
    LDA STR2_PTR
    INY
    STA STR2_PTR
    JMP LOOP2

; Found a match
MATCH:
    INY
    LDX STR2_PTR
    DEC STR2_PTR
    LDA CURR_LEN
    CLC
    ADC #1
    STA CURR_LEN
    STA 0,X
    CMP MAX_LEN
    BCC NOT_MAX
    STA MAX_LEN
    LDX CURR_OFFSET
    STX MAX_OFFSET
NOT_MAX:
    LDA STR2_PTR
    LDX CURR_OFFSET
    STX 0,X
    STA CURR_OFFSET

    ; Update pointers and loop
    LDA STR2_PTR
    INY
    STA STR2_PTR
    JMP LOOP2

END2:
    LDS STR1_PTR
    INY
    STA STR1_PTR
    JMP LOOP1

END1:
    ; Output the result
    LDX STR1_PTR
    LDY MAX_OFFSET
    STX RESULT_OFFSET
    STY RESULT_OFFSET+1

    ; Halt the program

; Variables
    .ds 2 MAX_LEN
    .ds 2 MAX_OFFSET
    .ds 1 CURR_LEN
    .ds 1 CURR_OFFSET
    .ds 1 CHAR1
    .ds 1 STR1_PTR
    .ds 1 STR2_PTR

; Test strings
    .byte "ABCD",0
    .byte "AC",0
    .ds BUFFER_SIZE - 6 ; Fill up with zeros

; End of program
    .end
