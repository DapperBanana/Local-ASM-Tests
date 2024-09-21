
XML_STRING .ASC " <bookstore><book><title>Assembly Programming</title><author>John Doe</author></book></bookstore> "

; Check if the XML document is valid
    LDX #0                    ; Initialize index register
PARSE_LOOP:
    LDA XML_STRING, X         ; Load character from string
    BEQ DONE                  ; End of string reached
    CMP #'<'
    BNE ERROR                ; Invalid character
    INX                       ; Increment index
    JMP PARSE_LOOP

ERROR:
    ; Invalid XML syntax
    JMP INVALID

DONE:
    ; Valid XML syntax
    JMP VALID
    
INVALID:
    ; Invalid XML document
    BRK                      ; Break execution

VALID:
    ; Valid XML document
    BRK                      ; Break execution
