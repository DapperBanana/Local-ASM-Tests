
.area      = $10   ; area of the regular polygon
.side_len  = $11   ; length of one side of the polygon
.num_sides = $12   ; number of sides of the polygon

           .org $1000

start      lda #10    ; load number of sides (e.g. 6)
           sta $num_sides

           lda #5     ; load length of one side (e.g. 5)
           sta $side_len

           jsr calculate_area

           lda $area
           sta $8000    ; store result at memory address $8000

loop       jmp loop    ; infinite loop

calculate_area:
           lda $side_len  ; load length of one side
           sta $area      ; store the area in $area

           lda $num_sides ; load number of sides
           ldx $num_sides ; copy it to X register
           lda #1
           sec
loop1      sbc #1       ; decrement counter
           beq done      ; jump if counter is zero
           clc
           adc $area     ; add the area to itself
           sta $area
           jmp loop1

done       rts          ; return

           .end
