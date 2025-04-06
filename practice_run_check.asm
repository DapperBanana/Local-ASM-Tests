
    .org $0600
start:
    LDX #0         ; Initialize counter for sum of digits
    LDY #0         ; Initialize sum of digits
    
inputLoop:
    JSR readNumber ; Read the next digit from input
    BCC endInput   ; Branch if end of input is reached
    
    CLC            ; Clear carry flag
    ADC Y          ; Add the current digit to sum
    STA Y          ; Store the new sum
    
    INX            ; Increment counter for number of digits processed
    BRA inputLoop  ; Continue processing input
    
endInput:
    ; Output the sum of digits
    LDA Y          ; Load the sum of digits
    JSR printNumber ; Display the sum of digits
    
    BRK

readNumber:
    LDA $3000,X   ; Read the next digit from input
    CMP #"0"      ; Check if it is a valid digit
    BCC endRead   ; Branch if end of input is reached
    CMP #"9"
    BCS endRead
    SEC           ; Set carry flag
    SBC #"0"      ; Convert digit character to number
    RTS
    
endRead:
    SEC           ; Set carry flag
    SBC #"0"      ; Convert digit character to number
    CLC           ; Clear carry flag
    RTS

printNumber:
    STA $4000     ; Display the sum of digits
    RTS
    
    .org $FFFC
    .word start   ; Start address
