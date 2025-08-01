
ORG $1000

data_dict:
    .byte $02, $04, $06, $08, $0A, $0C, $0E, $10  ; Sample data points

chart_x_pos = $40  ; X position of the chart
chart_y_pos = $20  ; Y position of the chart
chart_width = 30    ; Width of the chart
chart_height = 10   ; Height of the chart

LDA #chart_x_pos
STA $D021   ; Set X position of the chart

LDA #chart_y_pos
STA $D020   ; Set Y position of the chart

LDA #chart_width
STA $D015   ; Set width of the chart

LDA #chart_height
STA $D017   ; Set height of the chart

LDX #0
LDY #0

draw_line:
    LDA data_dict, X
    STA $D800, Y  ; Set the Y position of the data point
    INY
    INX
    CPX #8     ; Check if we have reached the end of the data
    BNE draw_line

RTS

