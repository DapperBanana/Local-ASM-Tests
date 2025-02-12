
ORG    $0000

START:
        LDX    #$00        ; Initialize index register
        LDA    $4000, X    ; Load the first character of the string into the accumulator
        
CHECK_START_TAG:
        CMP    #'<'        ; Compare the character with '<' (start of tag)
        BEQ    CHECK_END_TAG    ; If it is a start tag, check for end tag
        JMP    INVALID_XML    ; If not, the XML document is invalid
        
CHECK_END_TAG:
        INX                ; Increment the index register to move to the next character
        LDA    $4000, X    ; Load the next character of the string into the accumulator
        CMP    #'/'        ; Compare the character with '/' (end of tag)
        BEQ    END_OF_STRING    ; If it is an end tag, check for end of string
        JMP    CHECK_END_TAG    ; If not, continue checking for end tag
        
END_OF_STRING:
        INX                ; Increment the index register to move to the next character
        LDA    $4000, X    ; Load the next character of the string into the accumulator
        CMP    #$00        ; Compare the character with null terminator
        BEQ    VALID_XML    ; If it is a null terminator, the XML document is valid
        JMP    END_OF_STRING    ; If not, continue checking for end of string
        
VALID_XML:
        ; Valid XML document
        JMP    $FFF0        ; End program
        
INVALID_XML:
        ; Invalid XML document
        JMP    $FFF0        ; End program
        
        .ORG $4000
        .BYTE '','<','t','a','g','>','','<','/','t','a','g','>',''
