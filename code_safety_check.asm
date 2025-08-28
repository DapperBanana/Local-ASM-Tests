
        .org $0200
START   ldx #$00          ; Initialize X register (index)
        lda #10           ; Set length of list
SORT    cmp #$00          ; Check if end of list
        bcs NEXT
        rts              ; Exit if end of list
NEXT    lda LIST, x      ; Load current element
        clc              ; Clear carry flag
        adc LIST+1, x    ; Add next element
        sec              ; Set carry flag
        sbc LIST, x      ; Subtract current element
        bcs CONTINUE     ; Branch if carry is set
        sta TEMP         ; Store current element
        lda LIST+1, x    ; Load next element
        sta LIST, x      ; Store current element
        lda TEMP         ; Load temporary element
        sta LIST+1, x    ; Store next element
CONTINUE
        inx              ; Increment index
        jmp SORT         ; Continue sorting

LIST    .byte 5, 2, 7, 1, 9, 3, 4, 8, 6, 10
TEMP    .byte $00

        .end
