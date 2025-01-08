
        .org $0200

start   lda #9          ; Load the number of sides of the nonagon
        sta sides
        lda #128        ; Load the length of one side of the nonagon
        sta sideLength
        lda sideLength
        clc
        adc #0          ; Add zero to the length
        sta perimeter    ; Calculate the perimeter of nonagon

        lda sides
        adc perimeter    ; Calculate the perimeter of nonagon
        sta totalPerimeter 

        lda totalPerimeter
        clc
        lsr             ; Divide the perimeter by 2
        lsr
        sta halfPerimeter

        lda halfPerimeter
        sec
        sbc sideLength  ; Calculate the apothem of the nonagon
        sta apothem

        lda halfPerimeter
        sec
        sbc apothem      ; Calculate the height of the nonagon
        sta height

        lda apothem
        clc
        adc height       ; Calculate the total area of nonagon
        adc height
        sta area

loop    jmp loop        ; Infinite loop

sides       .byte 0
sideLength  .byte 0
perimeter   .byte 0
totalPerimeter .byte 0
halfPerimeter  .byte 0
apothem     .byte 0
height      .byte 0
area        .byte 0

        .end
