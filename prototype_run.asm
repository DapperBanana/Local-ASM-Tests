
; Calculate the area of a circle given its radius

START:
    LDA #0         ; Clear accumulator
    STA radius     ; Clear memory location for radius
    STA area       ; Clear memory location for area

    LDA #10        ; Load radius value (e.g. 10)
    STA radius

    JSR calculateArea  ; Call calculateArea subroutine

    BRK             ; Exit program

calculateArea:
    LDA radius      ; Load radius value
    JSR multiply    ; Call multiply subroutine

    LDA #$FF        ; Load pi value (approximation)
    JSR multiply    ; Multiply by pi

    STA area        ; Store result in memory location for area

    RTS

multiply:
    PHA             ; Save A
    ASL             ; Shift left to multiply by 2
    TAX             ; Save result in X
loop:
    CLC             ; Clear carry
    LDA X           ; Load X value
    ADC radius      ; Add radius
    DEC A           ; Decrement A
    BNE loop        ; Loop until A is 0
    TAX             ; Store result in X
    PLA             ; Restore A
    RTS
