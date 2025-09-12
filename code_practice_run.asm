
; Area of Parallelogram Program

    .org $0200        ; Define program start address

    lda $0300         ; Load base of parallelogram from memory location $0300
    sta $00           ; Store base in zero page
    lda $0301         ; Load height of parallelogram from memory location $0301
    sta $01           ; Store height in zero page

    ldx $00           ; Load base from zero page into X register
    ldy $01           ; Load height from zero page into Y register

    ; Calculate area of parallelogram (base * height)
    lda $00           ; Load base
    beq end           ; Check if base is zero and skip calculation if true
    mul $01           ; Multiply base by height
    bcc skipCorrect   ; Check for overflow
    inx               ; Increment X register to store second byte of result
skipCorrect:
    sta $02           ; Store low byte of area in memory location $02
    stx $03           ; Store high byte of area in memory location $03

end:
    rts               ; Return from subroutine

    .end              ; End of program
