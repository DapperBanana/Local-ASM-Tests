
.data
data_dict:   .byte 5, 8, 3, 6, 4

.text
start:
    ldx #0                 ; Load index register X with 0
    lda data_dict, x       ; Load the next value from the data dictionary
    tax                    ; Transfer the value to X register
    jsr draw_bar           ; Call draw_bar subroutine
    inx                    ; Increment X
    cpx #5                 ; Check if we have processed all the values
    bne start              ; If not, go back to start

    rts

draw_bar:
    lda #$2D               ; Load ASCII value for '-'
    sta $FB                ; Store it in memory for drawing the bar
loop:
    cmp $FB, #0            ; Check if we have reached the value of the bar
    beq done               ; If yes, exit the loop
    jsr draw_char          ; Call draw_char subroutine to draw the bar character
    dec $FB                ; Decrement the bar value
    jmp loop

draw_char:
    jsr $FFD2              ; Print the character to the screen
    rts

done:
    rts
