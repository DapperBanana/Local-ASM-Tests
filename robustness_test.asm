
; Sector area calculator program for 6502 Assembly

        .org  $0200

        LDX  #RADIUS         ; Load radius into X register
        LDY  #ANGLE          ; Load angle into Y register

        JSR  CALC_AREA       ; Call subroutine to calculate area

        BRK

CALC_AREA:
        STX  RADIUS          ; Store radius
        STY  ANGLE           ; Store angle

        LDA  RADIUS          ; Load radius
        STA  ACCUM           ; Store in accumulator for calculation

        SEC                   ; Set carry flag for divide operation
        LDA  #360            ; Load 360 (full circle) into accumulator
        SBC  ANGLE           ; Subtract angle
        STA  ANGLE_DIFF      ; Store difference in angle_diff

        STY  ACCUM           ; Store angle in accumulator
        LDA  #2              ; Load 2 into accumulator
        JSR  DIVIDE          ; Call subroutine to divide RADIUS by 2

        LDA  ACCUM           ; Load result of RADIUS / 2 into accumulator
        STA  RADIUS_HALF     ; Store in radius_half

        LDY  ANGLE_DIFF      ; Load angle difference
        LDA  #RADIAN_CONV    ; Load radians conversion constant
        JSR  MULTIPLY        ; Call subroutine to multiply angle difference by constant

        LDA  ACCUM           ; Load result of angle difference * constant into accumulator
        STA  RADIAN_ANGLE    ; Store in radian_angle

        LDA  RADIUS_HALF     ; Load radius / 2 into accumulator
        STA  ACCUM           ; Store in accumulator for calculation

        LDA  RADIAN_ANGLE    ; Load radian angle into accumulator
        JSR  SIN             ; Call subroutine to calculate sine of radian angle

        LDA  ACCUM           ; Load result of sine calculation into accumulator
        JSR  MULTIPLY        ; Call subroutine to multiply by radius_half

        LDA  ACCUM           ; Load result of radius_half * sine into accumulator
        STA  SECTOR_AREA     ; Store in sector_area

        RTS

DIVIDE:
        LSR                   ; Shift right to divide by 2
        SEC
DIV_LOOP:
        SBC  ACCUM
        BCS  DIV_LOOP
        CLC

        RTS

MULTIPLY:
        PHA
        LDX  #0
MULT_LOOP:
        CLC
        ROL                   ; Left shift the accumulator
        BCC  MULT_SKIP
        CLC
        ADC  ACCUM
MULT_SKIP:
        DEX
        BNE  MULT_LOOP

        PLA

        RTS

SIN:
        LDA  #0              ; Initialize result to 0
        STA  ACCUM

        LDX  #12             ; Number of power terms
        LDA  RADIAN_ANGLE    ; Load angle into accumulator

SIN_LOOP:
        LDA  ACCUM           ; Load accumulator into Y
        STA  Y_TEMP          ; Store in y_temp

        LDY  #2              ; Initial power value
        LDX  #2              ; Initial factorial value

SIN_TERM:
        LDA  Y_TEMP
        JSR  DIVIDE          ; Divide by x

        LDY  #2
        LDA  Y_TEMP
        JSR  MULTIPLY        ; Multiply by -x^2

        LDY  #2
        LDA  Y_TEMP
        JSR  DIVIDE          ; Divide by 2

        JSR  ADD             ; Add result to accumulator

        DEX
        BNE  SIN_TERM

        RTS

ADD:
        CLC
        ADC  ACCUM           ; Add result to accumulator
        STA  ACCUM

        RTS

        .org $0300

RADIUS  .byte $00           ; Radius variable
ANGLE   .byte $00           ; Angle variable
ACCUM   .byte $00           ; Accumulator for calculation
RADIUS_HALF .byte $00       ; Radius / 2
ANGLE_DIFF  .byte $00       ; Difference between 360 and angle
RADIAN_ANGLE .byte $00      ; Angle converted to radians
Y_TEMP  .byte $00           ; Temporary storage for y value
SECTOR_AREA .byte $00       ; Final sector area

RADIAN_CONV .byte $0C       ; Constant for converting to radians (360 / 30 = 12)

        .end
