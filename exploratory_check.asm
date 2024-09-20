
; Define constants
pentagon_side equ 5   ; Side length of the pentagon
prism_height equ 10   ; Height of the prism

; Define variables
area_result equ $ff    ; Variable to store the calculated area

start:
    lda pentagon_side
    jsr multiply      ; Calculate the area of the pentagon
    sta area_result

    lda prism_height
    jsr multiply      ; Multiply the area of the pentagon by the height of the prism
    sta area_result

    ; Display the result
    lda area_result
    ; Output the result here (print it or store it in memory)

    ; End program
    rts

multiply:
    ldx #0          ; Clear X register
loop:
    clc
    adcmp #$00
    bcs skip_sub       ; Skip subtraction if accumulator is less than divisor
    sbc pentagon_side   ; Subtract the divisor from the accumulator
    inx
    bcc loop        ; Repeat loop if carry flag is not set

    skip_sub:
    lda area_result     ; Load the result so far
    sta area_result     ; Store the current result
    rts
