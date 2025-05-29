
        .org $0600

start   lda #<textFile
        sta $fb
        lda #>textFile
        sta $fc

        ldx #0
        ldy #0

findWord
        lda ($fb),y
        cmp #<findWord          ; check if current byte matches first letter of word
        bne nextByte

        lda ($fb),y
        bne nextByte

        lda #>findWord
        sec
        sbc #<findWord
        tay

checkWord
        lda ($fb),y
        cmp #<replaceWord        ; check if current byte matches next letter of word
        bne nextByte

        iny
        lda ($fb),y              ; check if whole word has been matched
        cmp #>replaceWord
        beq replaceWord

        lda #>findWord
        clc
        adc #<findWord
        ldy #0
        bne checkWord

nextByte
        iny
        cpy #$ff
        bne findWord

replaceWord
        lda #<replaceWord
        sta ($fb),y
        iny
        lda #>replaceWord
        sta ($fb),y

        lda #0
        sta ($fb),y

        lda $fb
        clc
        adc #1
        sta $fb
        bne findWord

textFile
        .byte "Hello world, this is a sample program to test the find and replace functionality.",0
findWord
        .byte "test",0
replaceWord
        .byte "example",0
