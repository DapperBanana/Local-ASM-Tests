
    ; Assume the string to check is stored in memory starting at address $2000
    ; The result will be stored in the Accumulator (A) - A=1 if valid email, A=0 if not valid
    
    LDA #$00 ; Initialize Accumulator to 0
    STA valid_email ; Store result
    
    LDX #$00 ; Initialize index to 0
    
check_email:
    LDA $2000,X ; Load next character from string
    CMP #0 ; Check for end of string
    BEQ end_check ; If end of string, exit loop
    
    CMP #'@' ; Check for '@' symbol
    BEQ check_domain ; If '@' found, move to domain part
    
    CMP #32 ; Check for space character
    BEQ not_valid ; If space found, not a valid email
    
    INX ; Increment index
    JMP check_email ; Continue checking characters in email
    
check_domain:
    LDX #$00 ; Reset index for domain part
    
check_domain_loop:
    LDA $2000,X ; Load next character from domain
    CMP #0 ; Check for end of string
    BEQ end_check ; If end of string, exit loop
    
    CMP #'.' ; Check for '.' symbol
    BEQ check_tld ; If '.' found, move to top-level domain part
    
    INX ; Increment index
    JMP check_domain_loop ; Continue checking characters in domain
    
check_tld:
    LDX #$00 ; Reset index for top-level domain part
    
check_tld_loop:
    LDA $2000,X ; Load next character from top-level domain
    CMP #0 ; Check for end of string
    BEQ set_valid ; If end of string, email is valid
    
    INX ; Increment index
    JMP check_tld_loop ; Continue checking characters in top-level domain
    
set_valid:
    LDA #1 ; Set Accumulator to 1 (valid email)
    STA valid_email ; Store result
    JMP end_check ; Exit check
    
not_valid:
    LDA #0 ; Set Accumulator to 0 (not valid email)
    STA valid_email ; Store result
    
end_check:
    RTS ; Return from subroutine
    
valid_email: .BYTE 0 ; Result of email check
    
    .ORG $2000 ; Start of email string
    .BYTE "example@email.com",0 ; Email to check
