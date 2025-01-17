
        .org $0200

start:  lda sideLength  ; Load the side length into the accumulator
        sta radius      ; Store the side length as the radius of the circumcircle
        jsr calcArea   ; Call the subroutine to calculate the area
        jsr printResult ; Call the subroutine to print the result

end:    rts            ; Return from the program

calcArea:
        ldx #$0A       ; Load the number of sides (11) into X register
        lda radius     ; Load the radius into the accumulator
        clc            ; Clear the carry flag
        adc radius     ; Add the radius to itself (doubling it)
        tay            ; Transfer the result to Y register
        lda #$20       ; Load the constant 32 into the accumulator
        tax            ; Transfer it to X register
loop:   dey            ; Decrement the Y register
        bpl loop       ; Repeat until Y reaches 0
        rts            ; Return from subroutine

printResult:
        ldx #$02       ; Load the X register with the index of the result
        lda #$0D       ; Load the constant character for newline
        jsr $FFD2      ; Output the newline character
        lda rangetype,x    ; Load a character from result string
        jsr $FFD2      ; Output the character
        inx            ; Increment the X register
        cpx #$08       ; Check if the end of the result string is reached
        bne printResult ; Repeat until done
        rts            ; Return from subroutine

sideLength: .byte $05   ; Length of one side of the hendecagon
radius:     .byte $00   ; Radius of the circumcircle
rangetype:  .byte "Area of the Hendecagon is: $20" ; Result string

        .end start
