
        .org $0200

start   lda #$00        ; Initialize sum to 0
        sta sum
        ldx #$00        ; Initialize count to 0
        stx count

loop    lda input,x     ; Load next number from input list
        beq end         ; If number is 0, end loop
        cmp #$00        ; Check if end of list
        beq end

        clc
        lda sum         ; Add current sum
        clc
        adc input,x     ; Add current input to sum
        sta sum

        inx             ; Increment count
        jmp loop        ; Repeat loop

end     ldx count       ; Get count of numbers
        bne calculate   ; If count > 0, calculate median
        rts             ; Exit if count = 0

calculate lda sum        ; Load sum
        clc
        lsr             ; Divide by 2
        pha             ; Save result on stack
        lda sum         ; Load sum back
        ldx #$00
        lda #$00

find_median 
        clc
        adc input,x     ; Add next number from input
        lsr             ; Divide by 2
        sec
        sbc (sp),y      ; Subtract previous result
        tay             ; Store result in Y register

        inx             ; Increment index
        cpx count       ; Compare index to count
        bne find_median ; Repeat loop if not done

        pla             ; Get median from stack
        sta median
        rts

input   .byte $02, $05, $07, $09, $0A, $00
sum     .byte $00
count   .byte $00
median  .byte $00

        .end
