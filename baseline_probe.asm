
; Define memory locations for variables
.average    .eq $00      ; Average value
.sum        .eq $01      ; Sum of values
.count      .eq $02      ; Number of values
.value      .eq $03      ; Value being read from file

; Program entry point
start       lda #$00     ; Initialize variables
            sta average
            lda #$00
            sta sum
            lda #$00
            sta count
            lda #$00
            sta value

read_loop   lda value     ; Read value from file
            beq calc_avg   ; If end of file, calculate average
            clc
            adc sum        ; Add value to sum
            sta sum
            inc count      ; Increment count
            jmp read_loop  ; Continue reading values

calc_avg    lda sum        ; Calculate average
            ldx count
            cpx #00
            beq end_prog   ; If count is 0, end program
            jsr divide     ; Divide sum by count
            sta average

end_prog    ; End program

divide      sec
            lda sum
            ldx #$00
            ldy count
            divloop     ; Division loop
            dex
            bne divloop

            rts

divloop     sbc count
            bcc divskip
            inx
            jmp divloop
divskip     rts
