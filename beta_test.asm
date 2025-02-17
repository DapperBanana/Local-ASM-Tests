

        .org $1000

start   lda #<src_string
        sta $4000
        lda #>src_string
        sta $4001

        lda #$00
        sta $4002

loop    lda ($4002),y
        beq end
        cmp #"A"
        bcs not_upper
        cmp #"Z"
        bcc not_upper
        sec
        sbc #"A"-#"a"
        sta ($4002),y

not_upper cmp #"a"
        bcs not_space
        cmp #"z"
        bcc not_space
        sec
        sbc #"a"+#"A"
        sta ($4002),y

not_space iny
        bne loop
        jmp loop

end     lda #$00
        sta ($4002),y

        lda $4000
        jsr output_char

        lda $4001
        jsr output_char

        lda #$0d
        jsr output_char

        lda $4000
        clc
        adc #$0003
        sta $4000

        lda $4001
        clc
        adc #$0003
        sta $4001

        jmp loop

output_char lda #$02
        jsr $ffd2
        rts

src_string .asciiz "Hello, WORLD!"
        
        .end
