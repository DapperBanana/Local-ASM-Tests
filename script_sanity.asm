
; Define data dictionary
.data
data_dictionary:
    .byte 10, 20, 30, 40, 50

; Initialize variables
.chart_data = $e0 ; Start address of chart data
.chart_width = 5 ; Number of data points in chart

.code
main:
    LDX #0 ; Initialize X register for loop
    LDA data_dictionary, X ; Load data point
    STA chart_data, X ; Store data point
    INX ; Increment X
    CPX chart_width ; Check if end of chart
    BNE main ; If not end, continue loop

; Print chart
    LDX #0 ; Initialize X register
print_loop:
    LDA chart_data, X ; Load data point
    JSR print_chart_data ; Print data point
    INX ; Increment X
    CPX chart_width ; Check if end of chart
    BNE print_loop ; If not end, continue loop

    BRK ; End program

print_chart_data:
    LDY #$ff ; Set Y to max value
    STA $02 ; Set control register to point to data to print
    STY $01 ; Set Y register to number of data to print
    LDA #$06 ; Set print mode - print Y times
    JSR $ffd2 ; KERNAL routine for printing

    RTS
