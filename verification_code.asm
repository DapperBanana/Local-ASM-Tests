
    .org $1000

validJWT:
    LDA #$00          ; Initialize index to 0
    STA index
    
loop:
    LDA message, X    ; Load next character of the string
    CMP #$00          ; Check for end of string
    BEQ end
    
    CMP #$2E          ; Check for '.'
    BEQ dot
    
    CMP #$5F          ; Check for '_'
    BEQ validChar
    
    CMP #$2D          ; Check for '-'
    BEQ validChar
    
    CMP #$41          ; Check for uppercase letter
    BCC invalidChar
    CMP #$5A
    BCS validChar
    
    CMP #$61          ; Check for lowercase letter
    BCC invalidChar
    CMP #$7A
    BCS validChar
    
    CMP #$30          ; Check for digit
    BCC invalidChar
    CMP #$39
    BCS validChar
    
    JMP invalidChar
    
validChar:
    INX               ; Move to next character in the string
    JMP loop
    
dot:
    ; Do something if '.' is encountered
    INX               ; Move to next character in the string
    JMP loop
    
invalidChar:
    ; Do something if an invalid character is encountered
    JMP end
    
end:
    RTS
    
message:
    .asciiz "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
    
index:
    .byte $00
