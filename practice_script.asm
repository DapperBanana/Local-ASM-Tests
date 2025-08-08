
        .org $1000
start:
        lda english_text,x
        beq end
        
        cmp #0
        beq end
        
        jsr translate
        
        sta $0200,y
        
        inx
        iny
        
        jmp start

translate:
        lda #$00
        tax
        
loop:
        lda table,x
        cmp english_text,x
        beq found
        
        inx
        inx
        inx
        inx
        
        cmp #$00
        bne loop
        
        lda #$01
        sta $d020
        lda #$00
        
found:
        lda table+1,x
        sta $d020
        lda table+2,x

        sta $d021
        
        tax
        ldx $d020
        rts

end:
        rts

english_text:
        .byte 'hello',0
        .byte 'world',0
        
table:
        .byte 'hello',0
        .byte 'world',0
        
        .byte 'hola',0
        .byte 'mundo',0
