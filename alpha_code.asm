
    .org $1000

start:
    LDX #$00        ; Initialize index to 0
    LDY #$00        ; Initialize index for output buffer to 0
    
loop:
    LDA input,X     ; Load next character from input buffer
    CMP #$41        ; Compare with ascii value for 'A'
    BCC notLetter   ; If less than 'A', skip to next character
    CMP #$5A        ; Compare with ascii value for 'Z'
    BCS notLetter   ; If greater than 'Z', skip to next character
    STA output,Y   ; Store letter in output buffer
    INY             ; Increment output buffer index

notLetter:
    INX             ; Increment input buffer index
    LDA input,X     ; Load next character from input buffer
    CMP #$00        ; Check if end of string
    BEQ done        ; If end of string, we are finished
    BNE loop        ; Else, continue processing characters
    
done:
    STA output,Y   ; Store null terminator in output buffer
    RTS

input:
    .asciiz "Hello, World! This is a test."

output:
    .ds $100        ; Reserve space for output buffer
