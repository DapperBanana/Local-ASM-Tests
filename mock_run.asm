
    .org $0200

start:
    lda #8                  ; Number of sides of the octagon
    sta sides
    lda #16                 ; Side length of the octagon
    sta side_length

    jsr calculate_area      ; Call the subroutine to calculate the area

    lda area
    ; The result will be in A, you can choose to store it in memory or display it in any way you like

end:
    jmp end                ; Infinite loop to stop the program

calculate_area:
    lda sides
    clc
    adc #$0000             ; Clear carry flag
    ldx #0
loop:
    clc
    lda sides
    lsr
    bcc skip
    lda side_length
    sta temp
    clc
    lda area
    adc temp
    sta area
skip:
    clc
    lda side_length
    adc temp
    sta side_length
    dex
    bne loop
    rts

sides:      .byte 0
side_length: .byte 0
temp:       .byte 0
area:       .byte 0

    .end
