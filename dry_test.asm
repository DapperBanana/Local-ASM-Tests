
FRUSTUM_AREA equ $0600
RADIUS_TOP equ $0700
RADIUS_BOTTOM equ $0800
HEIGHT equ $0900

START
    LDA #10         ; Load top radius
    STA RADIUS_TOP
    LDA #5          ; Load bottom radius
    STA RADIUS_BOTTOM
    LDA #8          ; Load height
    STA HEIGHT

    JSR CALC_AREA   ; Calculate the area

    ; Print the result
    LDA FRUSTUM_AREA
    STA $FFD2       ; Output the result

    BRK             ; End program

CALC_AREA
    LDA RADIUS_TOP
    STA $FE   ; Save top radius
    LDA RADIUS_BOTTOM
    STA $FF   ; Save bottom radius

    LDA RADIUS_TOP
    CLC
    ADC RADIUS_BOTTOM
    LSR           ; Divide by 2
    STA $FD       ; Save average radius

    LDA $FD
    LDX HEIGHT
    SEC
    SBC #1
    PHA           ; Save height-1
LOOP
    CLC
    LDA $FD
    ADC $FE
    ADC $FF
    TAY
    LDA HEIGHT
    ROL           ; Shift left
    ROL
    DEX
    BNE LOOP
    PLA           ; Recover height-1
    ADC HEIGHT
    TAX

    STA FRUSTUM_AREA

    RTS
