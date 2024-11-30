
    LDA #0         ; Initialize maximum length
    STA MAX_LENGTH
    
    LDX #0         ; Initialize starting index
LOOP:
    LDA STRING,X   ; Load current character
    BEQ END_LOOP   ; If end of string, exit loop
    
    JSR FIND_PALINDROME ; Find palindrome starting from current index
    
    INX            ; Move to next character
    JMP LOOP       ; Continue loop
    
END_LOOP:
    RTS            ; Return
    
FIND_PALINDROME:
    STX CUR_INDEX   ; Save starting index in CUR_INDEX
    LDA #1          ; Initialize length of palindrome
    STA PAL_LENGTH
    
CHECK_PALINDROME:
    LDX PAL_LENGTH  ; Load current length
    CPX MAX_LENGTH  ; Compare with max length
    BCC NOT_LONGEST ; If not longer, skip
    
    LDX PAL_LENGTH  ; Load current length
    STX MAX_LENGTH  ; Update max length
    
    LDX PAL_LENGTH  ; Load current length
    LDA PALINDROME,X ; Update max palindrome
    STA MAX_INDEX
    
NOT_LONGEST:
    LDX PAL_LENGTH  ; Load current length
    CMP CUR_INDEX   ; Compare current index
    BCC PALINDROME_FOUND ; If at end of string, exit
    
    LDX CUR_INDEX   ; Load current index
    LDA STRING,X    ; Load current character
    STA COMPARE_CHAR
    DEY             ; Decrement length
    
    LDX PAL_LENGTH  ; Load current length
    LDX PALINDROME,X ; Load character from palindrome
    CMP COMPARE_CHAR ; Compare with current character
    BEQ CONTINUE ; If equal, continue checking
    
    ; Not a palindrome, reset length
    LDX #0
    STX PAL_LENGTH
    
    ; Move to next character
    INC CUR_INDEX
    
    RTS
    
CONTINUE:
    ; Move to next character
    INC CUR_INDEX
    DEY
    
    ; Continue checking palindrome
    JMP CHECK_PALINDROME
    
PALINDROME_FOUND:
    ; Found palindrome, print result
    LDX MAX_LENGTH
    LDX MAX_INDEX
    JMP PRINT_RESULT
    
PRINT_RESULT:
    ; Print longest palindromic substring
    RTS
    
STRING:
    .BYTE 'a','b','b','a','b','b','c',0
MAX_LENGTH:
    .BYTE 0
CUR_INDEX:
    .BYTE 0
PAL_LENGTH:
    .BYTE 0
PALINDROME:
    .BYTE 0
MAX_INDEX:
    .BYTE 0
COMPARE_CHAR:
    .BYTE 0
