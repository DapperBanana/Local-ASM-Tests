
; Read and analyze data from a CSV file
; Assume the CSV file is located at memory address $3000

        lda #$30      ; starting address of the CSV file
        sta $fe       ; set file pointer
        lda #$00      ; clear sum
        sta $fd
        lda #$00      ; clear count
        sta $fc

read_loop:
        lda ($fe),y   ; load next byte from file
        cmp #$2c      ; compare with comma
        beq comma_found  ; branch if comma is found
        and #$0f      ; convert ASCII to integer
        clc
        adc $fd       ; add to sum
        sta $fd
        inc $fc       ; increment count
        iny
        bne read_loop

comma_found:
        lda $fc
        beq end_of_file  ; if count is zero, end of file
        ldy #$00
        lda $fd
        clc
        lsr          ; divide by 2
        lsr
        adc $fd
        bcc end_of_file
        sta $fd
        sec
        sbc #$00
        sta $fd+1     ; store avg in $fd, $fd+1
        jmp read_loop

end_of_file:
        ; Program ends here, sum is in $fd, and avg is in $fd and $fd+1

        jmp end_of_file
