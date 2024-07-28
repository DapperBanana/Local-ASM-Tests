
; Program to check if a given string is a valid ISBN number

    .org $0600

start
    LDX #0          ; Initialize index register
    LDY #0          ; Initialize accumulator to hold checksum
    
readLoop
    LDA buffer,X    ; Load next character from buffer
    BEQ endOfInput  ; Branch to end if null character found
    CMP #$30        ; Compare with ASCII '0'
    BCC invalidISBN ; Branch to invalid if character is not a digit
    CMP #$39        ; Compare with ASCII '9'
    BCS invalidISBN ; Branch to invalid if character is not a digit
    INX             ; Move to next character
    BNE readLoop    ; Repeat until end of input
    
checksumLoop
    LDA buffer,Y    ; Load next character from buffer
    BEQ endOfChecksum ; Branch to end if null character found in checksum
    ASL             ; Multiply checksum by 2
    ADC #0          ; Add character value to checksum
    INY             ; Move to next character
    BNE checksumLoop ; Repeat until end of checksum

endOfChecksum
    AND #$0F        ; Get last 4 bits of checksum
    BEQ validISBN   ; Branch to valid if checksum is 0
    BRA invalidISBN ; Branch to invalid if checksum is not 0

validISBN
    LDA #$01        ; Set result to 1 (valid)
    BRK

invalidISBN
    LDA #$00        ; Set result to 0 (invalid)
    BRK

endOfInput
    LDA #$00        ; Set result to 0 (invalid)
    BRK

buffer
    .byte "1234567890X",0 ; Test ISBN number and null terminator

    .end
