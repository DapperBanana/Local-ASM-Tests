
     .org $0600

start:
     lda #0
     sta $fb
     sta $fa
     
     jsr get_month
     jsr get_year
   
     ldx #1
     lda month,x
     sta $fc
     inx
     lda month,x
     sta $fd

     jsr print_calendar
     
     rts
     
get_month:
     lda #"Enter month (1-12): "
     jsr print_string
     jsr read_number
     sta $fb
     lda $fb
     cmp #12
     bcc get_month
     rts
     
get_year:
     lda #"Enter year: "
     jsr print_string
     jsr read_number
     sta $fa
     rts
     
print_calendar:
     lda $fc
     jsr print_month
     jsr print_days
     rts
     
print_month:
     lda $fc
     asl
     tay
     lda months,y
     jsr print_string
     lda #" "
     jsr print_string
     lda $fd
     jsr print_string
     lda #13
     jsr print_char
     rts
     
print_days:
     lda #"Su Mo Tu We Th Fr Sa"
     jsr print_string
     lda #13
     jsr print_char
     
     lda $fc
     asl
     tay
     lda start_days,y
     sta $fe
     
next_day:
     lda $fe
     jsr print_number
     lda #32
     jsr print_char
     lda start_days,y
     sec
     sbc #1
     sta $fe
     bne next_day
     
     lda #13
     jsr print_char
     rts
     
print_number:
     pha
     jsr div_10
     pla
     adc #"0"
     jsr print_char
     rts
     
div_10:
     sec
     sbc #10
     lsr
     tax
     pla
     jsr div_10
     rts
     
print_char:
     jsr $ffd2
     rts
     
print_string:
     ldy #0
char_loop:
     lda (string),y
     beq char_end
     jsr print_char
     iny
     bne char_loop
char_end:
     rts
     
read_number:
     lda #0
     sta $f8
     lda #10
     sta $f9
     
read_loop:
     jsr $ffd9
     cmp #13
     beq done_reading
     
     cmp #"0"
     bcc read_loop
     cmp #"9"
     bcs read_loop
     
     sec
     sbc #"0"
     tay
     
     lda $f8
     asl
     adc $f8
     sta $f8
     lda $f9
     asl
     adc $f9
     sta $f9
     
     jmp read_loop
     
done_reading:
     rts
     
string:
     .byte 0
     month:
     .byte "January"
     .byte "February"
     .byte "March"
     .byte "April"
     .byte "May"
     .byte "June"
     .byte "July"
     .byte "August"
     .byte "September"
     .byte "October"
     .byte "November"
     .byte "December"
     months:
     .byte 31,28,31,30,31,30,31,31,30,31,30,31
     start_days:
     .byte 0,3,3,6,1,4,6,2,5,0,3,5
     .end
