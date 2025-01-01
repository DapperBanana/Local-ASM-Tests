
        .org $0200      ; Start program at address $0200

start   lda #0          ; Initialize accumulator to 0
        sta sum        ; Initialize sum variable to 0
        lda #10         ; Load size of list into accumulator
        sta size       ; Store size of list in size variable

        ldx #0          ; Initialize index to 0
        lda numbers,x  ; Load first number from list
        sta min        ; Set first number as minimum
        lda numbers,x  ; Load first number from list
        sta max        ; Set first number as maximum

loop    lda numbers,x   ; Load number from list
        cmp min         ; Compare number with current minimum
        bcc update_min  ; Branch if number is less than current minimum

        cmp max         ; Compare number with current maximum
        bcs update_max  ; Branch if number is greater than current maximum

        inx             ; Increment index
        bne loop        ; Branch to loop if index is not zero

        lda min
        clc
        adc max
        lsr
        sta median

        rts            ; Return from subroutine

update_min
        sta min        ; Update minimum
        bra end_loop

update_max
        sta max        ; Update maximum
        bra end_loop

end_loop
        inx
        cmp size
        bne loop

sum     .byte 0
size    .byte 0
min     .byte 0
max     .byte 0
median  .byte 0

numbers .byte 3, 6, 1, 9, 2, 7, 5, 8, 4

        .end
