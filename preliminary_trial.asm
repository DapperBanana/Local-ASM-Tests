
; Calculate the area of a regular polygon in 6502 Assembly

.area        equ $0000  ; memory location to store the area result
.side_length equ $0002  ; memory location to store the side length of the polygon
.num_sides   equ $0004  ; memory location to store the number of sides of the polygon
.angle       equ $0006  ; memory location to store the interior angle of the polygon
.result      equ $0008  ; memory location to store intermediate results

start        lda side_length  ; load the side length
             sta result        ; store it in result
             lda num_sides     ; load the number of sides
             sta result+1      ; store it in result+1
             lda #360          ; load 360 degrees
             sec
             sbc angle         ; subtract the interior angle
             jsr div            ; divide 360 by the interior angle
             lda quotient      ; load the result of the division
             sta result+2      ; store it in result+2
             lda result        ; load the side length
             clc
             adc result        ; add the side length
             sta result        ; store the result
loop         lda result        ; load the result
             clc
             adc result+2      ; add the result of the division
             sta result        ; store the result
             dec result+1      ; decrement the number of sides
             bne loop          ; loop until all sides have been added
             lda result        ; load the final result
             sta area          ; store it in the area memory location
             rts

div          ldx #$00          ; initialize x register
             lda #$00          ; load the quotient
             sta quotient      ; store the quotient
div_loop     clc
             lda result        ; load the result
             cmp angle         ; compare to the angle
             bcc done_div      ; if less than, division is done
             clc
             sbc angle         ; subtract the angle
             inx               ; increment the quotient
             jmp div_loop      ; continue division loop
done_div     sta quotient      ; store the final quotient
             rts

