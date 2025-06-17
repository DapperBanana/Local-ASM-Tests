
START:
    LDX #10        ; Initialize X register to number (e.g. 100)
    STX number
    
    LDA #0         ; Initialize Y register to 0
    STA result
    
LOOP:
    LDA number
    CMP #0         ; Check if number is zero
    BEQ END
    
    CLC
    LDA result
    ADC #1
    STA temp
    
SQUARE_ROOT_LOOP:
    LDA temp
    SEC
    SBC number     ; Subtract number from temp
    BCS SQUARE_ROOT_LOOP
    
    INC result
    DEY
    BNE SQUARE_ROOT_LOOP
    
    STX number     ; Store the square root of the number
    
END:
    NOP            ; End of the program

number: .BYTE 0
result: .BYTE 0
temp: .BYTE 0
