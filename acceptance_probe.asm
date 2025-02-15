
        .org $0200

        lda #0
        sta $02     ; Initialize row counter i
        lda #0
        sta $03     ; Initialize column counter j

        loop_row:
            lda #0
            sta $01     ; Initialize product accumulator

            lda $02
            clc
            adc $04     ; Load address of first element of current row of first matrix
            sta $06     ; Store address in pointer register A
            lda $03
            clc
            adc $06     ; Load address of element in current column of second matrix
            sta $07     ; Store address in pointer register B

            lda #0
            sta $05     ; Initialize inner loop counter k

            inner_loop:
                lda ($06),y     ; Load element from first matrix
                tay
                lda ($07),y     ; Load element from second matrix
                clc
                adc $00         ; Multiply elements and accumulate in accumulator
                sta $01

                iny
                iny
                iny

                inx             ; Move to next column of first matrix
                iny             ; Move to next row of second matrix

                inc $05         ; Increment inner loop counter
                cmp #3          ; Check if inner loop counter has reached 3
                bne inner_loop  ; If not, continue inner loop

            lda $07
            clc
            adc #4          ; Move to next column of second matrix
            sta $07

            lda $05
            cmp #3          ; Check if inner loop counter has reached 3
            beq end_inner   ; If yes, finish inner loop
            lda $02
            clc
            adc #4          ; Move to next column of first matrix
            sta $02
            jmp loop_row    ; Continue outer loop

        end_inner:
            lda $04
            clc
            adc #8          ; Move to next row of first matrix
            sta $04

            lda $02
            lda #0
            sta $02         ; Reset row counter i
            inc $03         ; Move to next column of first matrix
            cmp #3          ; Check if all rows and columns have been processed
            bne loop_row    ; If not, continue outer loop

        sta $08             ; Store result in designated memory location

        rts

        ; Define matrices
        .org $0300
        .byte 1, 2, 3
        .byte 4, 5, 6
        .byte 7, 8, 9

        .byte 9, 8, 7
        .byte 6, 5, 4
        .byte 3, 2, 1

        ; Allocate memory for result
        .org $0400
        .byte 0, 0, 0
        .byte 0, 0, 0
        .byte 0, 0, 0

