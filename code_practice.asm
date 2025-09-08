
.6502

    LDY #$00        ; Initialize Y register to zero
    LDA #$00        ; Initialize A register to zero
    STA $01         ; Initialize output to zero
    LDA #$0A        ; Load the number 10 (to be used for subtraction)
    STA $02         ; Store it in memory location $02
    LDX #$0D        ; Load the number 13 (number of Roman numerals we are dealing with)
    LDY #$00        ; Initialize Y register to zero (used for output)
    
    ROMAN_LOOP:
        LDA $00,Y   ; Load the current Roman numeral
        CMP #$49    ; Check if we are at the last Roman numeral "I" (ASCII value)
        BEQ ROMAN_I
        CMP #$44    ; Check if we are at the Roman numeral "D" (ASCII value)
        BEQ ROMAN_D
        CMP #$4C    ; Check if we are at the Roman numeral "L" (ASCII value)
        BEQ ROMAN_L
        CMP #$4D    ; Check if we are at the Roman numeral "M" (ASCII value)
        BEQ ROMAN_M
        CMP #$56    ; Check if we are at the Roman numeral "V" (ASCII value)
        BEQ ROMAN_V
        BRA INCREMENT
    
    ROMAN_I:
        LDA $00,Y   ; Load the current Roman numeral "I"
        CMP #$49    ; Compare with ASCII value of "I"
        BEQ ROMAN_I_COUNT
        CMP #$56    ; Compare with ASCII value of "V"
        BEQ ROMAN_IV
        CMP #$58    ; Compare with ASCII value of "X"
        BEQ ROMAN_IX
        INY         ; Increment Y register (to move to the next Roman numeral)
        BRA ROMAN_LOOP
    
    ROMAN_I_COUNT:
        LDA $02     ; Load the number 10
        CLC
        ADC $01     ; Add 10 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_IV:
        LDA $02     ; Load the number 10
        CLC
        ADC $01     ; Add 10 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_IX:
        LDA $02     ; Load the number 10
        CLC
        ADC $01     ; Add 10 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_V:
        LDA $02     ; Load the number 5
        CLC
        ADC $01     ; Add 5 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_X:
        LDA $02     ; Load the number 10
        CLC
        ADC $01     ; Add 10 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_L:
        LDA $02     ; Load the number 50
        CLC
        ADC $01     ; Add 50 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_C:
        LDA $02     ; Load the number 100
        CLC
        ADC $01     ; Add 100 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_D:
        LDA $02     ; Load the number 500
        CLC
        ADC $01     ; Add 500 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    ROMAN_M:
        LDA $02     ; Load the number 1000
        CLC
        ADC $01     ; Add 1000 to the current output
        STA $01     ; Store the result back in memory
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    INCREMENT:
        INY         ; Move to the next Roman numeral
        BRA ROMAN_LOOP
    
    .BYTE "MMMCDXLIX",0     ; Input Roman numeral (MMMCDXLIX)
