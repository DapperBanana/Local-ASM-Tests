
        .org $0200       ; start address of program

start   lda #0          ; initialize index
        sta index

loop    lda data,x      ; load next number from array
        sta temp        ; store number in temp
        lda index        ; load index
        tax             ; transfer index to X register

inner   lda data,x      ; load number to compare to
        cmp temp        ; compare with temporary number
        bcs skip        ; if current number is greater, skip
        sta temp        ; if current number is smaller, swap with temp
        sta data,x

skip    inx             ; increment index
        lda index
        cmp #6          ; check if at end of array
        beq done        ; if at end, then done
        bne inner        ; if not at end, continue inner loop

        lda #0
        sta index       ; reset index
        jmp loop        ; continue outer loop

done    rts             ; return from subroutine

data    .byte 7, 2, 4, 1, 3, 5, 6

temp    .byte 0
index   .byte 0

        .end
