
    .text
    .org $2000

start:
    lda #<file_data
    sta $fb
    lda #>file_data
    sta $fc
    
    lda #08
    sta $ff
    
    jsr openfile

readloop:
    jsr readchar
    beq endloop
    
    cmp #',' ; check for comma delimiter
    beq record_end
    
    ; analyze data here
    
    jmp readloop

record_end:
    ; end of record, analyze data here
    jmp readloop

endloop:
    jsr closefile
    rts

openfile:
    lda #$ff
    jsr $ffd5
    rts

readchar:
    lda #$00
    jsr $ffc6
    rts

closefile:
    jsr $ffc9
    rts

file_data:
    .db "example.csv", 0

    .end
