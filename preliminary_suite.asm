
; Valid JSON Web Token (JWT) checker program

    .org $600    ; Start address of the program
    
start:
    LDA #$00     ; Initialize index pointer
    STA index
    
check_token:
    LDA token, X   ; Load character from token string
    CMP #'{'
    BEQ check_header
    
continue:
    INX         ; Move to the next character
    JMP check_token     ; Continue checking
    
check_header:
    INX         ; Skip header
    LDA token, X
    CMP #'"'       ; Check if header starts with "
    BEQ read_header
    JMP invalid_token
    
read_header:
    INX         ; Skip "
    
read_header_char:
    LDA token, X   ; Load character
    CMP #'"'       ; Check if end of header reached
    BEQ check_payload
    
    INX         ; Move to next character
    JMP read_header_char
    
check_payload:
    LDA token, X
    CMP #'.'       ; Check if payload starts
    BEQ read_payload
    JMP invalid_token
    
read_payload:
    INX         ; Skip .
    
read_payload_char:
    LDA token, X   ; Load character
    CMP #'.'       ; Check if end of payload reached
    BEQ check_signature
    
    INX         ; Move to next character
    JMP read_payload_char
    
check_signature:
    INX         ; Skip .
    LDA token, X
    CMP #'"'       ; Check if signature starts with "
    BEQ read_signature
    JMP invalid_token
    
read_signature:
    INX         ; Skip "
    
read_signature_char:
    LDA token, X   ; Load character
    CMP #'"'       ; Check if end of signature reached
    BEQ valid_token
    
    INX         ; Move to next character
    JMP read_signature_char
    
valid_token:
    LDA #1       ; Set result to true
    STA result
    JMP end_program
    
invalid_token:
    LDA #0       ; Set result to false
    
end_program:
    BRK       ; End program execution
    
    .org $700    ; Start of data section
    
index:
    .byte $00    ; Index pointer
    
result:
    .byte $00    ; Result of token validation
    
token:
    .byte "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.sig"
    
    .end      ; End of the program
