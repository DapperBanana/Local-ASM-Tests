
LDA #0 ; Initialize counter to 0
LDX #0 ; Initialize length of the string to 0

LOOP:
    LDA input_ptr,X ; Load character at index X of the input string
    BEQ END_LOOP ; Break if end of string is reached
    
    CMP #'<'
    BEQ CHECK_TAG_START
    CMP #'>'
    BEQ CHECK_TAG_END

    INX
    JMP LOOP

CHECK_TAG_START:
    BEQ ERROR ; Check if start tag is empty
    INC counter

    INX
    JMP LOOP

CHECK_TAG_END:
    DEC counter

    INX
    JMP LOOP

END_LOOP:
    BEQ VALID_XML ; Check if counter is 0 at the end
    JMP INVALID_XML

VALID_XML:
    ; Print "This is a valid XML document"
    RTS

INVALID_XML:
    ; Print "This is not a valid XML document"
    RTS

ERROR:
    ; Print "Invalid XML document format"
    RTS
