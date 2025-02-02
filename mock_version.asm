
    .org $1000
    
data_dic:
    .byte $05, $08, $03, $0A, $04  ; data values to be displayed
    
    lda #$00           ; set index to zero
loop:
    ldx #$00           ; set x position to zero
    lda data_dic, x    ; load data value at current index
    sta $D000          ; output the data as a bar
    
next_data:
    inx                ; increment index
    bne loop           ; loop back if not zero
    
end:
    jmp end            ; infinite loop
