
; Generate a simple line chart from a dictionary of data

.org $0200
start:
    LDX #0          ; Initialize X register to index data
loop:
    LDA data,X      ; Load data point
    STA $D0200,X    ; Store data point in memory as chart
    INX             ; Increment index
    CPX #data_end   ; Compare index with end of data
    BNE loop        ; Branch if not at end

    ; Load register values for line drawing
    LDA #0          ; Load black color
    STA $D020F      ; Set color for drawing
    LDA #8          ; Set line width
    STA $D0218      ; Set width for drawing

    ; Draw line chart
    LDX #0          ; Reset X value for chart drawing
draw_loop:
    LDA $D0200,X    ; Load data point
    STA $0400       ; Set Y-coordinate for line
    STA $0402
    INX             ; Increment X value
    LDA $D0200,X    ; Load next data point
    STA $0401       ; Set next Y-coordinate for line
    STA $0403
    JSR $D012       ; Call Kernal subroutine to draw line
    CPX #data_end   ; Check if end of data
    BNE draw_loop   ; Branch if not at end

    BRK             ; Exit program

data:
    .byte 32, 40, 50, 60, 45, 30, 20, 18, 35, 42 ; Sample data points
data_end:

.end start
