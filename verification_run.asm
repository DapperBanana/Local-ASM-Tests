
; Program to encrypt and decrypt text using the Caesar cipher

.org $0200

START:
    LDX #0      ; initialize index
    LDA MESSAGE,X   ; load character from message
    BEQ END         ; check for end of string
    
ENCRYPT:
    CMP #$41    ; check if character is uppercase
    BCC LOWER   ; branch if character is lowercase
    CMP #$5B    ; check if character is within uppercase range
    BCS NEXT    ; branch to next character if not uppercase
    SEC
    SBC #$41    ; subtract 'A' to get 0-25 range
    LDA #$04    ; set shift amount
    SBC #$00    ; subtract shift amount
    AND #$1F    ; set overflow flag
    ADC #$41    ; add back 'A' to get ASCII value
    STA MESSAGE,X   ; store encrypted character
    JMP NEXT
    
LOWER:
    CMP #$61    ; check if character is lowercase
    BCC NEXT    ; branch to next character if not lowercase
    CMP #$7B    ; check if character is within lowercase range
    BCS NEXT    ; branch to next character if not lowercase
    SEC
    SBC #$61    ; subtract 'a' to get 0-25 range
    LDA #$04    ; set shift amount
    SBC #$00    ; subtract shift amount
    AND #$1F    ; set overflow flag
    ADC #$61    ; add back 'a' to get ASCII value
    STA MESSAGE,X   ; store encrypted character
    JMP NEXT
    
NEXT:
    INX         ; increment index
    LDA MESSAGE,X   ; load next character
    BEQ END         ; check for end of string
    JMP ENCRYPT     ; encrypt next character

END:
    BRK         ; end program
    
MESSAGE:
    .asciiz "HELLO, WORLD!"   ; input message
    
    .org $FFFA
    .word START   ; start address

