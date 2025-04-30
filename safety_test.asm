
START:
    LDA #0         ; Initialize sum of numbers
    STA SUM
    LDA #0         ; Initialize count of numbers
    STA COUNT
    
LOOP:
    LDA NUMBERS,X  ; Load number from memory
    BEQ CALC_MEDIAN     ; Branch if end of list
    CLC
    ADC SUM         ; Add number to sum
    STA SUM
    INX             ; Increment index
    INX
    JMP LOOP        ; Continue loop
    
CALC_MEDIAN:
    LDA COUNT      ; Load count of numbers
    ASL            ; Multiply count by 2
    ASL
    TAX            ; Save count*2 in X
    LDX #0
    LDA #0
    STA TEMP
    LDA #0
    STA MEDIAN
    STA LOW
    STA HIGH

SORT:
    LDA NUMBERS,X  ; Load number from memory
    BEQ CALC_MEDIAN2     ; Branch if end of list
    STA TEMP
    LDA NUMBERS,X
    CMP TEMP
    BCC SORT
    JMP SUB_SORT
    
SUB_SORT:
    LDA TEMP
    STA HIGH
    LDA NUMBERS,X
    STA TEMP
    JMP SORT
    
CALC_MEDIAN2:
    LDA X
    DEY
    CPY #MEDIAN
    BNE CALC_MEDIAN2
    CLC
    ADC LOW; ADJUST FOR ARRAY
    ADC HIGH
    STA MEDIAN
    JMP DONE

DONE:
    BRK

SUM:
    .BYTE 0
COUNT:
    .BYTE 0
NUMBERS:
    .BYTE $03, $01, $05, $02, $04, $00 ; List of numbers (must end with a 0)
TEMP:
    .BYTE 0
MEDIAN:
    .BYTE $0
LOW:
    .BYTE $0
HIGH:
    .BYTE $0
