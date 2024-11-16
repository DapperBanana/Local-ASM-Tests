
START:
    LDA #10           ; Load radius (r) with 10
    STA radius

    LDA #5            ; Load height (h) with 5
    STA height

    JSR CALC_VOLUME   ; Jump to subroutine to calculate volume

    LDA result_high
    STA $00           ; Store high byte of result at memory location $00

    LDA result_low
    STA $01           ; Store low byte of result at memory location $01

    JMP $FFFE         ; End program

CALC_VOLUME:
    LDA radius        ; Load radius
    STA $02           ; Store radius at memory location $02

    LDA height        ; Load height
    STA $03           ; Store height at memory location $03

    LDX #0            ; Initialize X register

    LDA #$02          ; Load constant 2
    STA $04           ; Store at memory location $04

    LDA #$22          ; Load K = 1/3
    STA $05           ; Store at memory location $05

    LDA $02           ; Load radius into accumulator
    ASL               ; Multiply radius by 2
    STA radius_double

    LDA $04           ; Load constant 2 into accumulator
    ADC $04           ; Add 2 to accumulator
    STA radius_add_2

    LDA radius_double ; Load doubled radius into accumulator
    STA radius_squared

    LDA radius_squared ; Load squared radius
    LDA $03           ; Load height into accumulator
    STA height

    LDA radius_squared ; Load squared radius
    LDA height        ; Load height into accumulator
    ASL               ; Multiply by 2
    STA height_double

    LDA radius_add_2  ; Load radius + 2
    LDA height_double
    STA height

    LDA radius_squared ; Load squared radius
    LDA height        ; Load height into accumulator
    STA product

    LDA radius        ; Load radius
    LDA $03           ; Load height into accumulator
    ASL               ; Multiply by 2
    STA height_double

    LDA radius_squared ; Load squared radius
    LDA height_double
    STA height

    LDA radius_add_2  ; Load radius + 2
    LDA height_double ; Load doubled height
    STA height

    LDA product       ; Load product of radius and height
    LDA radius        ; Load radius into accumulator
    ASL               ; Multiply by 2
    STA radius_double

    LDA radius_squared ; Load squared radius
    LDA height_double ; Load doubled height
    ASL               ; Multiply doubled height by 2
    STA height_double

    LDA radius_add_2  ; Load radius + 2
    LDA height_double
    STA height

    STA high          ; Store high byte of result

    LDA result_high   ; Load high byte of result
    CLC               ; Clear carry
    ADC result_low    ; Add low byte of result
    STA low           ; Store low byte of result

    RTS               ; Return from subroutine

    ORG $FFFE
    DW START

radius:    .BYTE 0
height:    .BYTE 0
result_low: .BYTE 0
result_high: .BYTE 0

radius_double: .BYTE 0
height_double: .BYTE 0
height: .BYTE 0
radius_add_2: .BYTE 0
radius_squared: .BYTE 0
product: .BYTE 0
high: .BYTE 0
low: .BYTE 0
