
; Assuming a 3x3 matrix is stored in memory starting at address $2000
; The matrix elements are consecutive bytes, row-wise

LDX #0              ; Initialize row counter
LDA #$0             ; Initialize sum variable

CheckRows:
    LDX #0          ; Initialize column counter
    
CheckCols:
    LDA $2000, X    ; Load matrix element into accumulator
    CLC             ; Clear carry flag
    ADC $2003, X    ; Add next element in the same row
    ADC $2006, X    ; Add last element in the same row
    CMP #$15        ; Compare sum to magic number 15
    BNE NotMagic    ; Branch if not equal
    INX             ; Increment column counter
    CPX #3          ; Check if all columns have been summed
    BNE CheckCols   ; If not, continue summing
    
    DEX             ; Decrement column counter
    LDY #3          ; Initialize loop counter for checking columns in reverse
    
    CheckReverseCols:
        LDA $2000, Y    ; Load matrix element into accumulator
        CLC             ; Clear carry flag
        ADC $2003, Y    ; Add next element in the same row
        ADC $2006, Y    ; Add last element in the same row
        CMP #$15        ; Compare sum to magic number 15
        BNE NotMagic    ; Branch if not equal
        DEY             ; Decrement column counter
        CPY #$0         ; Check if all columns have been summed
        BNE CheckReverseCols ; If not, continue summing
    
    INX             ; Increment row counter
    CPX #3          ; Check if all rows have been checked
    BNE CheckRows   ; If not, check the next row
    
MagicTorus:
    ; Matrix is a magic torus
    ; Add your code here to handle the magic torus case
    ; For example, set a flag or print a message
    
NotMagic:
    ; Matrix is not a magic torus
    ; Add your code here to handle the not magic torus case
    ; For example, set a flag or print a message

