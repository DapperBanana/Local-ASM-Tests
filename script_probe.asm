
.data
data_dict:
    .byte 3, 5, 7, 2, 9
    end_data_dict:

.code
start:
    ldx #0      ; initialize index for data_dict
    lda data_dict, x
    beq end_loop  ; exit loop if fetched byte is 0
loop:
    lda data_dict, x   ; load value from data_dict
    jsr draw_bar       ; draw bar based on value
    inx
    bne loop         ; repeat until end of data_dict
end_loop:
    rts

draw_bar:
    sta $2000  ; start position of bar chart
    ldx #0
loop:
    lda #$00  ; draw blank space
    sta $2001, x
    dex
    bpl loop
    lda #$A0  ; draw bar
    sta $2001, x
    lda #$20  ; delay for visualization
    sta $2001
    rts
