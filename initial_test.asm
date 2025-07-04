
        .org $0200

matA    .byte $01, $02, $03, $04    ; input matrix A
matB    .byte $05, $06, $07, $08    ; input matrix B
result  .byte $00, $00, $00, $00    ; output matrix C

        lda #2                     ; loop counter for rows of result
rowLoop
        lda #2                     ; loop counter for columns of result
colLoop
        lda #0                     ; accumulator for result value
        sta tempRes                ; store accumulator in tempRes

        ; calculate dot product of row in matA and column in matB
        lda #$00                   ; initialize loop counter for dot product
        sta index
dotLoop
        lda matA, x                ; load byte from matA
        clc
        adc matB, y                ; add byte from matB
        sta tempVal                ; store result in tempVal
        lda tempRes
        clc
        adc tempVal                ; add result to accumulator
        sta tempRes                ; store new accumulator value
        
        inx                        ; increment index for matA
        bne skipLoadA              ; skip loading new byte if not zero
        inc index                  ; increment index to skip over second byte in matA
skipLoadA
       iny                        ; increment index for matB
        bne skipLoadB              ; skip loading new byte if not zero
        inc index                  ; increment index to skip over second byte in matB
skipLoadB

        cpx #2                     ; check if end of row in matA
        bne dotLoop                ; continue dot product if not
        cpy #2                     ; check if end of column in matB
        bne dotLoop                ; continue dot product if not

        ; store result in output matrix
        lda tempRes
        sta result, x              ; store result in output matrix
        
        dey                        ; decrement column loop counter
        bne colLoop                ; continue column loop if not zero

        dex                        ; decrement row loop counter
        bne rowLoop                ; continue row if not zero

        jmp $FFFE

index   .byte $00
tempRes .byte $00
tempVal .byte $00

        .end
