
; 6502 Assembly program to calculate the volume of a cylinder
        .org $0600

        LDX #RADIUS        ; Load X register with radius
        STX RADIUS_ADDR     ; Store radius in memory
        LDX #HEIGHT        ; Load X register with height
        STX HEIGHT_ADDR     ; Store height in memory

        LDA RADIUS_ADDR     ; Load radius from memory
        JSR SQUARE          ; Calculate the square of the radius
        STA RADIUS_SQR      ; Store the square of the radius

        LDA HEIGHT_ADDR     ; Load height from memory
        STA HEIGHT          ; Store height in A register

        JSR MULTIPLY        ; Calculate (PI * radius^2 * height)
        
        LDA VOLUME_H        ; Load the high byte of the volume
        STA $D000           ; Store the high byte of the volume in memory
        LDA VOLUME_L        ; Load the low byte of the volume
        STA $D001           ; Store the low byte of the volume in memory

        BRK

SQUARE  ; Calculate the square of a number in the accumulator
        ASL                 ; Shift left to multiply by 2
        TAX                 ; Transfer to X register
        TXA                 ; Return it back to accumulator

        RTS

MULTIPLY ; Calculate the volume of the cylinder: PI * radius^2 * height
        LDA #3              ; Load PI into A register
        STA PI
        LDA RADIUS_SQR      ; Load the square of the radius
        STA TEMP            ; Store in temporary memory location
        LDA PI              ; Load PI
        STA TEMP+1          ; Store in temporary memory location

        LDA TEMP            ; Load the square of the radius
        STA VOLUME_H        ; Store the high byte of the volume
        LDA TEMP+1          ; Load the low byte of PI
        STA VOLUME_L        ; Store the low byte of the volume

        RTS

RADIUS_ADDR .byte 0
HEIGHT_ADDR .byte 0
RADIUS_SQR  .word 0
PI          .word 0
TEMP        .word 0
HEIGHT      .byte 0
VOLUME_H    .byte 0
VOLUME_L    .byte 0

RADIUS      .byte 5       ; Radius of the cylinder
HEIGHT      .byte 10      ; Height of the cylinder

        .end
