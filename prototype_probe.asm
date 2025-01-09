
        .org $0800 ; start address of the program
        .processor 6502

start:
        ldx #$00    ; initialize index to 0
        lda dict,X  ; load first value from dictionary
        sta max     ; initialize max value
        sta min     ; initialize min value
        inx         ; increment index
loop:
        lda dict,X  ; load next value from dictionary
        cmp max     ; compare with max value
        bcs update_max ; if value > max, update max
        cmp min     ; compare with min value
        bcc update_min ; if value < min, update min
        inx         ; increment index
        cpx #num_elements ; compare with total number of elements
        bne loop    ; if not reaching the end, continue loop

done:
        rts         ; end of the program

update_max:
        sta max     ; update max value
        rts

update_min:
        sta min     ; update min value
        rts

dict:   .byte 12, 3, 16, 5, 20, 7, 9, 4
num_elements = *-dict

max:    .byte 0
min:    .byte 0

        .end        ; end of the program
