
        .org $0200

start:
        lda #0
        sta $fb
        lda #1
        sta $fc
        lda #5
        sta $fd
        lda #10
        sta $fe
        lda #50
        sta $ff
        lda #100
        sta $100
        lda #500
        sta $101
        lda #1000
        sta $102

        lda #$00
        sta $01
        lda #$00
        sta $02

input_loop:
        jsr get_input
        sec
        sbc #$30
        lda #10
        sec
        sbc #$0a
        cmp #0
        bcc done_input
        
        asl
        asl
        tax
        ldx $01
        clc
        adc $01,x
        sta $01,x
        asl
        asl
        asl
        asl
        lsr
        asl
        asl
        tax
        ldx $02
        clc
        adc $01,x
        sta $01,x
        sec
        lda $01
        sbc #$3c
        bcc input_loop

done_input:
        lda $01
        sta $01
        lda $02
        sta $02

convert_numeral:
        lda $01
        sta $03
        lda $02
        sta $04

main_loop:
        lda #$00
        sta $05
        lda #$07
        sta $06

        lda $fb
        jsr divide
        asl
        asl
        tax
        lda $06,x
        clc
        adc #$03
        sta $06,x
        sec
        lda $03
        sbc $06
        bcs cont_loop

skip_loop:
        lda #0
        jsr output_numeral
        jmp next_digit

cont_loop:
        lda $06
        bne skip_loop

loop_done:
        jsr convert_rest
        jsr clear_output
        bne main_loop

output_numeral:
        sta $07
        ldx #$02
        lda $07,x
        beq clear
        lda $fd
        sta $fd
skip_hundreds:
        ldx #$02
        clc
convert:
        jsr divide
        bcs output

next_digit:
        cmp #$05
        bcs done
        lda $06
        beq skip_loop

output:
        lsr
        lsr
        tax
        lda $fb
        sei
        sbc $fd
        ldx $07
get_next:
        jsr fill
        tax
        lda $fc
        sec
        sbc $fe
        bcs check
        sec
        lda $07,x
        inc
        sta $07,x
        bcs get_next

check:
        ldx $07
        cmp #4
        ldx #$02
        beq skip_hundreds

fill:
        sta $07,x
        rts

done:
        inc $07
        db $00

clear:
        ldx $07
        cpx $05
        bmi done
        dec
        jsr clear_output

clear_output:
        lda #$30
        ldx $07
        clr:
        sta $07,x
        jsr clear
        dex
        cpx #$00
        bne clr
        rts

clear:
        lda #$20
        rts

get_input:
        lda #$01
        jsr input_number
        lda #$00
        rts

input_number:
        lda #$00
        sta $00

in_num:
        lda #$00
        tax
        jsr input_char
        sec
        sbc #$30
        cmp #$0a
        bcc exit
        sta $02
        inc $00
        jmp in_num

exit:
        lda #$00
        sta $03
        rts

divide:
        tay
        lda $03
        sec
        sbc $01,y
        bcs divide_sec
        lda $02
        sec
        sbc $00
divide_sec:
        and #$ff
        lsr
        lsr
        lsr
        lsr
        sta $03
        ror
        ror
        ror
        ror
        sta $02
        rts

convert_rest:
        lda $04
        bne read_next
        sta $04
        lda $03
read_next:
        sec
        sbc #$10
        bcc convert_rest

        ldx $03
        ldx #8
        cmp #$00
        bne get_digit

        ldx $04
get_digit:
        clc
        lda #$00
        adc $fd,x
        and #$ff
        sec
        sbc $03

        sta $03
        bcs get_digit

        rts

        .org $ffd2
        rts: rts
