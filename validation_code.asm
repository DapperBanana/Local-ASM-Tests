
; Program to convert temperature from Celsius to Fahrenheit
;
; Formula: Fahrenheit = Celsius * 9/5 + 32
;
; Input: Celsius temperature in memory location CTEMP (e.g. CTEMP = 25)
; Output: Fahrenheit temperature in memory location FTEMP

    .org $0600  ; Start address of program

CTEMP   .byte $00  ; Celsius temperature
FTEMP   .byte $00  ; Fahrenheit temperature

    LDA CTEMP      ; Load Celsius temperature into A register
    CLC            ; Clear carry flag
    ADC #$00       ; Add 0 to clear overflow flag
    STA FTEMP      ; Store result in FTEMP temporarily

    LDA CTEMP      ; Load Celsius temperature into A register
    LSR            ; Divide by 2
    LSR            ; Divide by 2
    LSR            ; Divide by 2 (Celsius temperature / 8)
    ADC FTEMP      ; Add temporary FTEMP to get (Celsius temperature * 9/8)
    ADC FTEMP      ; Add again to get (Celsius temperature * 9/4)
    ADC FTEMP      ; Add again to get (Celsius temperature * 9/2)
    ADC FTEMP      ; Add again to get (Celsius temperature * 9)
    ADC #$20       ; Add 32 to convert to Fahrenheit
    STA FTEMP      ; Store result in FTEMP

    ; Program ends here

    .end           ; End of program
