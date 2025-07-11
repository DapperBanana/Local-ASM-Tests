
; Text-based Calendar Program

            .org $0200

start       lda #0
            sta $02      ; Initialize day
            sta $03      ; Initialize month
            sta $04      ; Initialize year

loop        jsr print_month
            jsr print_year
            jsr print_days
            jsr get_input
            jsr update_calendar
            jmp loop

print_month lda $03      ; Load month
            tax
            lda months,x
            jsr print_string
            rts

print_year  lda $04
            jsr print_decimal
            lda #","
            jsr print_char
            lda $05
            jsr print_decimal
            rts

print_days  lda $02
            jsr print_decimal
            lda #","
            jsr print_char
            lda days
            jsr print_string
            rts

get_input   lda #":"
            jsr print_char
            lda #">"
            jsr print_char
            lda #10
            jsr get_char
            sta $07
            lda $07
            cmp #10
            beq get_input
            jmp update_input

update_input
            lda $07
            cmp #13
            beq update_month
            cmp #44
            beq update_day
            cmp #46
            beq update_year
            jmp get_input

update_month
            lda $08
            sta $03
            jmp get_input

update_day   lda $08
            sta $02
            jmp get_input

update_year  lda $08
            sta $04
            jmp get_input

update_calendar
            lda $03
            clc
            adc $02
            sec
            sbc #12
            bpl not_reset_month
            lda #0
not_reset_month
            sta $02
            lda $02
            sec
            sbc #0
            bmi not_reset_year
            lda #31
not_reset_year
            sta $02
            lda $04
            clc
            adc $03
            sec
            sbc #12
            bpl not_reset_year
            lda #0
not_reset_year
            sta $03
            lda $03
            sec
            sbc #0
            bmi not_reset_year
            lda #99
not_reset_year
            sta $03
            rts

print_string
            sta $06
print_next  lda ($06),y
            beq print_end
            jsr print_char
            iny
            jmp print_next
print_end   rts

print_decimal
            ldx #0
            tay
            clc
print_digit lda digits,x
            cmp $00
            bcc print_digit_done
            jsr print_char
            inx
            dec $00
            bne print_digit
print_digit_done rts

print_char  sta $09
            jsr $ffd2
            rts

get_char    lda $09
            jsr $ffcf
            rts

months      .byte "January",0,"February",0,"March",0,"April",0,"May",0,"June",0,"July",0,"August",0,"September",0,"October",0,"November",0,"December",0
days        .byte "Sunday",0,"Monday",0,"Tuesday",0,"Wednesday",0,"Thursday",0,"Friday",0,"Saturday",0
digits      .byte "0","1","2","3","4","5","6","7","8","9"," "
