
    .org $0200

start:
    ; Load the base side length of the pentagon into register A
    LDA #$04 ; assuming the side length is 4 units
    
    ; Calculate the area of the base pentagon
    ; Area = (5/4) * side length squared * cot(180/5)
    ; cot(180/5) = -0.7265
    
    ASL ; Multiply the side length by 2 to make it 8
    ASL
    ASL
    ASL
    CLC
    ADC #$08 ; Add 8 to get the final side length squared value
    
    LDA #$0D ; Load the cot(180/5) value
    SEC
    SBC #$13 ; Subtract 19 to make it negative
    
    STA $00 ; Store the negative cot value
    
    ADC #$00 ; Add the base side length squared
    TAX ; Transfer the result to X
    
    ; Calculate the area by multiplying by 5/4
    LDA $00 ; Load the negative cot value
    CLC
    ADC $00
    ADC $00 ; Multiply by 3/2
    
    CLC
    ADC $00
    ADC $00 ; Multiply by 5/4
    
    TAX ; Store the result in X
    
    ; Calculate the area of the lateral sides of the pentagonal prism
    LDA $00 ; Load the negative cot value
    SEC
    SBC $00
    ASL ; Multiply by 2
    ASL
    
    ; Add the base area and the lateral area to get the total area of the prism
    CLC
    ADC X
    
    ; Print the result
    JSR print
    JSR newline
    
    ; Stop the program
    BRK

print:
    ; Print the number in register X to the console
    LDX #$00
loop:
    LDA $1000, X
    BEQ done
    JSR $FFD2
    INX
    JMP loop
done:
    RTS

newline:
    ; Print a newline character to the console
    LDA #$0D
    JSR $FFD2
    LDA #$0A
    JSR $FFD2
    RTS

    .org $FC00
    .block 256
input:  .byte 0
output: .byte 0
