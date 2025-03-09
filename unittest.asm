
        .org $1000

maze        .block
maze_width  .byte 8
maze_height .byte 8
maze_data   .block maze_width*maze_height
        .bend

solution    .block maze_width*maze_height

init:
        lda #0
        sta rnd_seed
        lda #maze_height
        sta y
next_row:
        lda #maze_width
        sta x
next_cell:
        jsr rand
        and #1
        sta maze_data,x,y
        dey
        bpl next_cell
        lda y
        cmp #0
        beq next_row
        lda x
        cmp #0
        beq next_row
        lda x
        dey
        jsr find_path
        lda solution,x,y
        jsr print_char
        dex
        dex
        bpl next_row

find_path:
        jsr rand
        asl
        asl
        asl
        asl
        asl
        asl
        asl
        asl
        jmp .skip
.loop:
        txa
        pha
        tya
        pha
        inc x
        jsr find_path
        pla
        tya
        pla
        pha
        inc y
        jsr find_path
        pla
        tax
        pla
        inc y
        jsr find_path
        pla
        inc x
        jsr find_path
        rts
.skip:
        cmp #120
        bcc .loop
        lda #0
        sta solution,x,y
        rts

print_char:
        tax
        tay
        lda #0
        jsr $FFD2  ; Print character at (X,Y)
        rts

rand_seed   .byte $AB ; Random seed
rand:
        lda rand_seed
        asl
        rol rand_seed
        adc #$1D
        sta rand_seed
        rts
