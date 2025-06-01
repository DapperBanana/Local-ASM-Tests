
.data
chart_data: .byte 10, 20, 30, 15, 25, 35, 40 ; Sample data points for the chart
chart_length: .byte 7 ; Length of the chart data
chart_width: .byte 40 ; Width of the chart

.text
main:
    lda #0 ; Initialize index
    sta $fe ; Store index in zero page location
    ldy #0 ; Initialize Y register
    
draw_chart:
    lda chart_data, y ; Load data point from chart data
    sta $ff ; Store data point in memory location for drawing
    
    ldx chart_width
draw_line:
    lda $ff ; Load data point from memory
    jsr draw_pixel ; Call subroutine to draw pixel
    
    dec y ; Decrement Y register
    lda chart_length ; Load chart length
    cmp y ; Compare with Y register
    bne draw_chart ; If not equal, draw next data point
    
    rts ; Return
    
draw_pixel:
    sta $d020 ; Write data point to screen memory
    rts ; Return
