
.data
data_dict:   .byte 10, 5, 8, 3, 12  ; Data dictionary containing values for bar chart
chart_char:  .byte '#'

.code
start:
    lda #0                        ; Initialize index register to zero
    sta $fe00                     ; Set memory location for cursor position

draw_bars:
    lda data_dict, x              ; Load data value from dictionary
    sta $fe01                     ; Set memory location for cursor position for printing

    ldx #0                        ; Initialize index register to zero
loop:
    lda chart_char                 ; Load bar chart character
    sta $fb00, x                  ; Print bar chart character
    inx                           ; Increment index
    cpx data_dict, x              ; Check if all data values have been processed
    bne loop                      ; If not done, continue printing

    inx                           ; Increment index
    cpx #5                        ; Check if all bars have been drawn
    beq end_program               ; If yes, end program

    lda #$0d                      ; Load carriage return character
    sta $fb00, x                  ; Move cursor to next line
    lda #$0a                      ; Load new line character
    sta $fb00, x                  ; Move cursor to beginning of next line
    inx                           ; Increment index for new line

    inx                           ; Increment index
    stx $fe00                     ; Set memory location for cursor position for printing
    jmp draw_bars                 ; Jump back to draw next bar

end_program:
    rts                           ; Return from subroutine
