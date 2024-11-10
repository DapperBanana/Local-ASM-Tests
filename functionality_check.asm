
.data
data_dict: .byte 10, 20, 30, 25, 35 ; Sample data points
chart_char: .byte '*', 0 ; Character to represent the data points

.code
start:
    ldx #0 ; Initialize index
loop:
    lda data_dict, x ; Load data point
    sec
    sbc #20 ; Subtract offset to fit within screen
    sta $200, x ; Store data point in screen memory
    inx ; Increment index
    cpx #5 ; Check if end of data
    bne loop ; If not, repeat loop

    ldx #0 ; Initialize index
print_loop:
    lda $200, x ; Load data point from screen memory
    cmp #0 ; Check for end of data
    beq end_print ; If end, exit loop

    lda chart_char ; Load character to represent data point
    sta $0400, x ; Store character in screen memory

    inx ; Increment index
    jmp print_loop ; Repeat loop

end_print:
    brk ; End program

.org $0200
.screen: .block 256 ; Define screen memory
