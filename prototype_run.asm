
        .org $0200        ; Start program at address $0200

radius  .ds 1            ; Define memory for radius
height  .ds 1            ; Define memory for height
volume  .ds 2            ; Define memory for volume result

        .org $FC00        ; Start of program
start   lda radius        ; Load radius from memory into accumulator
        sta $0000         ; Store radius in zero page address $0000
        lda height        ; Load height from memory into accumulator
        sta $0001         ; Store height in zero page address $0001
        
        jsr calculateVolume  ; Call subroutine to calculate volume
        
        lda volume        ; Load lower byte of volume result into accumulator
        sta $D000         ; Store lower byte of volume result in memory
        lda volume+1      ; Load upper byte of volume result into accumulator
        sta $D001         ; Store upper byte of volume result in memory
        
        rts               ; Return from subroutine and end program

calculateVolume:
        lda $0000         ; Load radius from zero page into accumulator
        ldx $0001         ; Load height from zero page into X register
        
        ; Calculate volume of cylinder using formula volume = pi * radius^2 * height
        lda #3            ; Load constant 3 (approximation of pi) into accumulator
        jsr multiply      ; Call subroutine to multiply accumulator by radius
        jsr multiply      ; Call subroutine to multiply accumulator by radius
        jsr multiply      ; Call subroutine to multiply accumulator by height
        
        rts               ; Return from subroutine

multiply:
        sta $00           ; Store accumulator in memory
        ldx $00           ; Load X register with stored value
        lda $0000         ; Load radius from zero page into accumulator
        clc               ; Clear carry flag
        adc $00           ; Add stored value in memory to accumulator
        sta $00           ; Store result in memory
        lda $0000         ; Load radius from zero page into accumulator
        bcc noCarry       ; Branch if no carry
        inc $00           ; Increment result if carry occurred
noCarry:
        lda $00           ; Load result from memory into accumulator
        sta $0000         ; Store result back in zero page
        rts               ; Return from subroutine
