
; Initialize variables
seed        .eq $00     ; Random number seed
x_position  .eq $01     ; X position
y_position  .eq $02     ; Y position
step        .eq $03     ; Current step

; Main program
start       ldx #0
            stx seed        ; Set random number seed to 0

            lda #0
            sta x_position  ; Set initial x position to 0
            sta y_position  ; Set initial y position to 0

            ldx #0
loop        lda seed
            lsr             ; Shift right to get random number
            bcs next_step   ; If carry flag is set, move to next step
            inx             ; Increment x position
            jsr plot_point  ; Call plot_point subroutine
            bne next_step

plot_point  ; Subroutine to plot a point on the graph
            sta x_position
            lda x_position
            sta x_position

            lda y_position
            sta y_position
            lda y_position

            lda (x_position)
            sta (y_position)

            rts

next_step   inx
            lsr
            inx
            lsr
            inx
            lsr
            tax             ; Save the result in X register

            lda x_position  ; Load current x position
            clc
            adc #0          ; Add to current x position
            sta x_position  ; Save new x position

            lda y_position  ; Load current y position
            adc seed        ; Add random number to current y
            sta y_position  ; Save new y position

            inx
            lda x_position
            beq loop

            lda y_position
            beq loop

            lda seed
            beq loop

            inc step        ; Increment current step

            rts
