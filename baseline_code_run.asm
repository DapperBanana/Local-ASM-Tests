
; Program to calculate the area of a trapezoid
; Height = 8, Base1 = 5, Base2 = 10
; Area = ((Base1 + Base2) * Height) / 2
;
START
    LDA #5      ; Load Base1 into Accumulator
    CLC         ; Clear Carry Flag
    ADC #10     ; Add Base2 to Accumulator
    STA BASESUM ; Store the sum of Base1 and Base2 in memory
    
    LDA #8      ; Load Height into Accumulator
    STA HEIGHT  ; Store Height in memory
    
    LDA BASESUM ; Load the sum of Base1 and Base2 into Accumulator
    CLC         ; Clear Carry Flag
    ADC HEIGHT  ; Add Height to Accumulator
    ASL         ; Multiply by 2
    LSR         ; Divide by 2
    STA TEMP    ; Store the result in temporary memory
    
    JSR PRINT   ; Call the print subroutine to display the result
    
    JMP $       ; End of program

PRINT
    LDA TEMP    ; Load the result into Accumulator
    STA $FB     ; Store low byte of result in memory
    LDA #$00
    STA $FB+1   ; Store high byte of result in memory
    
    LDA #$01
    STA $FC     ; Store low byte of address in memory
    LDA #$02
    STA $FD     ; Store high byte of address in memory
    
    LDX #$00
    LDY #$02
    
    LDY $FC     ; Load low byte
    LDA ($FB),Y ; Print result low byte
    JSR $FFD2   ; Call KERNAL routine
    
    LDY $FD     ; Load high byte
    LDA ($FB),Y ; Print result high byte
    JSR $FFD2   ; Call KERNAL routine
    
    RTS         ; Return from subroutine

BASESUM .BYTE 0
HEIGHT  .BYTE 0
TEMP    .WORD 0
