
        .org    $1000
        lda     #0        ; Initialize index for column
column_loop:
        lda     #0        ; Initialize index for row
row_loop:
        lda     #$41      ; Load ASCII character 'A' into register A
        jsr     rand     ; Call subroutine to generate a random character
        sta     $4000,X  ; Store the random character in memory location $4000+X
        inx              ; Increment index for row
        cpx     #$0A      ; Check if end of row is reached
        bne     row_loop  ; If not, continue generating characters for row
        iny              ; Increment index for column
        cpy     #$0A      ; Check if end of column is reached
        bne     column_loop ; If not, continue generating characters for column
        rts

rand:
        lda     #$FF     ; Load maximum value for random number generation
rand_loop:
        clc              ; Clear carry flag
        adc     #$01     ; Add 1 to A
        cmp     #$5A     ; Check if A is less than 'Z'
        bcc     rand_loop ; If yes, generate random number again
        rts
