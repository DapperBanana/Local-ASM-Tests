
.area equ $0200  ; Memory address to store the area
side equ $0201   ; Memory address to store the side length of the pentagon
height equ $0202 ; Memory address to store the height of the prism

; Set the side length of the pentagon and the height of the prism
    ldx #5       ; Load the number of sides of the pentagon
    sta side     ; Store the number of sides in memory
    ldx #$04     ; Load the height of the prism
    sta height   ; Store the height in memory

; Calculate the area of the pentagonal prism
    lda side     ; Load the side length of the pentagon
    jsr multiply ; Multiply the side length by 5
    lda height   ; Load the height of the prism
    jsr multiply ; Multiply the result by the height
    sta area     ; Store the final result in the memory address

; Halt the program
    jmp $FFFF    ; End of program

multiply
    clc
    adc #$00     ; Add the side length to the accumulator
    sta side
    lda side
    adc side
    sta side
    lda side
    adc side
    sta side
    rts
