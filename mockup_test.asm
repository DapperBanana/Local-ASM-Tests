
; Constants
DQUOTE = $22
SGT = $3E

.buffer = $0200
.ptr = $0202
.n = $0204

; Entry point
START:
    LDX #buffer
    STX ptr
    
; Loop through the input string
NEXT_CHAR:
    LDA (ptr),X
    BEQ END_OF_STRING
    CMP DQUOTE
    BEQ END_OF_STRING
    CMP SGT
    BEQ END_OF_DTD
    INX
    BNE NEXT_CHAR

; Check if the DTD is present
END_OF_DTD:
    LDA #0
    STA n
    INX
    LDA (ptr),X
    CMP SGT
    BEQ VALID_XML_WITH_DTD
    INX
    STA n
    LDA (ptr),X
    CMP SGT
    BEQ VALID_XML_WITH_DTD
    INX
    STA n
    LDA (ptr),X
    CMP SGT
    BEQ VALID_XML_WITH_DTD
    INX
    NOP ; Continue checking the whole DTD
    JMP NEXT_CHAR

; Valid XML file with DTD
VALID_XML_WITH_SD:
    JMP DONE

; Invalid XML file
END_OF_STRING:
    JMP DONE

; Done
DONE:
    BRK
