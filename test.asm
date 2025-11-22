
        .org $600
dictionary:
        .byte $0F, $2A, $C3, $7E, $55, $A9, $21, $6D   ; sample dictionary values
        .byte $00                                     ; terminating byte

start:
        lda #0         ; initialize max and min
        sta max
        sta min

next_byte:
        lda dictionary, x   ; load next byte from dictionary
        beq end_of_dict     ; if byte is 0, end of dictionary

        cmp max             ; compare with max value
        bcc not_max         ; if byte is less than max, skip max check
        sta max             ; update max value
not_max:
        cmp min             ; compare with min value
        bcs not_min         ; if byte is greater than min, skip min check
        sta min             ; update min value
not_min:

        inx                 ; move to next byte in dictionary
        jmp next_byte

end_of_dict:
        ; output max and min values
        lda max
        sta $80             ; store max value in memory location $80
        lda min
        sta $81             ; store min value in memory location $81

        ; end program
        brk

max:
        .byte 0
min:
        .byte 0
