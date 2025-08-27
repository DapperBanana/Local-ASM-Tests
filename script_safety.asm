
        .org $0200

print_string:
        lda (ptr),y
        beq .done
        jsr $ffd2
        iny
        jmp print_string

.done:
        rts

month_names:
        .text "January",0
        .text "February",0
        .text "March",0
        .text "April",0
        .text "May",0
        .text "June",0
        .text "July",0
        .text "August",0
        .text "September",0
        .text "October",0
        .text "November",0
        .text "December",0

days_in_month:
        .byte 31,28,31,30,31,30,31,31,30,31,30,31

calendar:
        ldx #0                  ; start with January
.loop:
        lda month_names,x
        jsr print_string
        jsr $ffd2               ; print newline
        lda days_in_month,x
        jsr $ffd0               ; print decimal value
        jsr $ffd2               ; print newline

        inx
        cpx #12
        bne .loop

        rts
        
ptr:
        .addr month_names

        .end
