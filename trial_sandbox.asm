
ORG $0200     ; Program starts at memory location $0200

START
    LDX #0         ; Initialize X register to 0 (for index)
    LDY #0         ; Initialize Y register to 0 (for sum)
    LDA #0         ; Initialize accumulator to 0
    STX INDEX      ; Store index in memory location INDEX
    STY SUM        ; Store sum in memory location SUM

LOOP
    LDA LIST,X    ; Load element from list into accumulator
    CLC            ; Clear carry flag
    ADC SUM        ; Add accumulator to sum
    STA SUM        ; Store sum back in memory location SUM
    INX            ; Increment index
    CPX #NUM_VALUES  ; Compare index with number of values in list
    BNE LOOP       ; If not done, loop back

    LDA SUM        ; Load sum into accumulator
    LSR            ; Divide sum by 2 (since we are using byte, divide by 2 is just shift right)
    STA AVERAGE    ; Store average in memory location AVERAGE

DONE
    BRK            ; Break and halt program

INDEX EQU $FD     ; Memory location for index
SUM   EQU $FE     ; Memory location for sum
AVERAGE EQU $FF   ; Memory location for average

LIST  .BYTE  10, 20, 30, 40, 50    ; List of values
NUM_VALUES   = 5                   ; Number of values in the list

    .END         ; End of program
