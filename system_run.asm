
        ORG     $0200

START   LDX     #$00        ; Initialize X to 0
        LDY     #$00        ; Initialize Y to 0
        
INPUT   LDA     #$FF        ; Load decimal delimiter
        JSR     INPUTNUM    ; Read decimal number
        STA     NUMBER      ; Save the input number
        
        LDA     NUMBER      ; Load the input number
        JSR     CONVERT     ; Call the CONVERT subroutine
        
        LDA     NUMERATOR   ; Load the numerator
        STA     $F0         ; Store it at memory location $F0
        
        LDA     DENOMINATOR ; Load the denominator
        STA     $F1         ; Store it at memory location $F1
        
        BRK                 ; End program

CONVERT LDX     #2          ; Initialize X to 2
        LDA     #-1         ; Initialize accumulator to -1
        STA     TEMP        ; Store it in TEMP
        
LOOP    ASL     A           ; Shift A left to multiply by 2
        DEX                 ; Decrement X
        
        BNE     LOOP        ; Loop until X is 0
        
        CLC                 ; Clear carry flag
        ADC     TEMP        ; Add TEMP to accumulator
        TAX                 ; Transfer accumulator to X
        
        LDA     #10         ; Load 10 into accumulator for division
        JSR     DIVIDE      ; Call the DIVIDE subroutine
        
        STA     NUMERATOR   ; Store the result in NUMERATOR
        
        LDX     #2          ; Initialize X to 2
        
LOOP2   ASL     A           ; Shift A left to multiply by 2
        DEX                 ; Decrement X
        
        BNE     LOOP2       ; Loop until X is 0
        
        CLC                 ; Clear carry flag
        ADC     TEMP        ; Add TEMP to accumulator
        TAX                 ; Transfer accumulator to X
        
        LDA     #10         ; Load 10 into accumulator for division
        JSR     DIVIDE      ; Call the DIVIDE subroutine
        
        STA     DENOMINATOR ; Store the result in DENOMINATOR
        
        RTS                 ; Return from subroutine

DIVIDE  SEC                 ; Set carry flag
        SBC     $00         ; Subtract memory location $00
        TAY                 ; Transfer accumulator to Y
        LDA     $00         ; Load memory location $00
        BEQ     done        ; If A is zero, division is complete
        
        INY                 ; Increment Y
        BNE     DIVIDE      ; Loop until A is zero

done    RTS                 ; Return from subroutine

INPUTNUM
        TYA                 ; Save Y to A
        LDA     $01         ; Load memory location $01
        STA     $00         ; Store in memory location $00
        LDA     #$FF        ; Load delimiter
        STA     $01         ; Store in memory location $01
        TYA                 ; Retrieve Y from A
        RTS                 ; Return from subroutine

NUMBER  DS  1
NUMERATOR DS  1
DENOMINATOR DS  1
TEMP    DS  1

        ORG $FFFA
        DW START
