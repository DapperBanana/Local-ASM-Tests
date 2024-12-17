
        .org $0200

start   LDX #$00        ; Initialize sum to 0
        LDY #$00        ; Initialize count to 0

readLoop
        LDA ($20),Y     ; Load a byte from input buffer
        BEQ done        ; If end of file, exit loop
        CMP #','        ; Check if the byte is a comma
        BEQ nextValue   ; If yes, move to next value
        STA $40,X       ; Store byte in value buffer
        INX             ; Increment index
        JMP readLoop

nextValue
        LDA $40,X       ; Load a byte from value buffer
        STA $50,Y       ; Store byte in value buffer to be converted to number
        INY             ; Increment index
        LDA #$00        ; Initialize accumulator
convertLoop
        STA $70         ; Clear lower byte
        LDA $50,Y       ; Load byte to be converted
        SEC             ; Clear the carry flag
        SBC #$30        ; Subtract ASCII '0'
        TAX             ; Transfer result to X register
        LDA $70         ; Load lower byte
        ASL             ; Shift left
        ROL $70         ; Rotate left
        ORA $70         ; OR with lower byte
        STA $70         ; Store result
        DEY             ; Decrement index
        BPL convertLoop

        LDA $70         ; Load converted value
        CLC             ; Clear carry
        ADC $60         ; Add to sum
        STA $60         ; Store sum
        INC $61         ; Increment count
        JMP readLoop

done    CPY #$00        ; Check if there are any values
        BEQ endProgram  ; If not, exit program

        LDA $60         ; Load sum
        LSR             ; Shift right to divide by 2
        STA $60         ; Store result

endProgram
        RTS

inputBuffer .ds $40       ; Input buffer for reading file
valueBuffer .ds $20       ; Buffer for storing values
numberBuffer .ds $20      ; Buffer for storing converted numbers
sum         .ds $02       ; Variable for storing sum
count       .ds $01       ; Variable for storing count

        .end start
