
        .org $200

matrix  .byte 1, 2, 3
        .byte 4, 5, 6
        .byte 7, 8, 9

det     .word 0

start   lda #06         ; Initialize loop counter
        sta $FE         ; Save loop counter in zero page
        lda #matrix     ; Load address of matrix
        sta $FC         ; Save address in zero page
        ldx #00          ; Initialize index for matrix elements
loop    lda $FC,x       ; Load first element of matrix
        sta $FB         ; Save to temporary location
        lda $FC+3,x     ; Load second element of matrix
        sta $FA         ; Save to temporary location
        lda $FC+6,x     ; Load third element of matrix
        sta $F9         ; Save to temporary location
        lda $FB         ; Load first element
        clc
        adc $FA         ; Add second element
        adc $F9         ; Add third element
        sta $F8         ; Save result
        lda det
        clc
        adc $F8         ; Add result to determinant
        sta det
        inx             ; Increment index
        lda $FE
        beq done        ; If loop counter is zero, exit loop
        dec $FE         ; Decrement loop counter
        lda $FC
        clc
        adc #1          ; Move to next row in matrix
        sta $FC
        jmp loop        ; Continue loop
done    rts

        .end
