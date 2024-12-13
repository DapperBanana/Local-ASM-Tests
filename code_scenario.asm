
; Program to calculate the area of a trapezoidal prism

; Define constants
trapz_height = $02 ; Height of the trapezoid
base1 = $05         ; Length of the first base of the trapezoid
base2 = $07         ; Length of the second base of the trapezoid

.segment "CODE"
start:
    LDA base1       ; Load the length of the first base
    STA $00         ; Store it in memory location $00
    LDA base2       ; Load the length of the second base
    STA $01         ; Store it in memory location $01
    LDA trapz_height ; Load the height of the trapezoid
    STA $02          ; Store it in memory location $02

    LDA $00          ; Load the length of the first base
    CLC             ; Clear the carry flag
    ADC $01         ; Add the length of the second base
    TAX             ; Store the sum in the X register

    LDA $02          ; Load the height of the trapezoid
    ADC $02         ; Add the height to the sum
    TAX             ; Store the new sum in the X register

    LDA $00          ; Load the length of the first base
    STA $03         ; Store it in memory location $03
    LDA $01          ; Load the length of the second base
    STA $04         ; Store it in memory location $04

    LDA $00          ; Load the length of the first base
    CLC             ; Clear the carry flag
    ADC $01         ; Add the length of the second base
    TAX             ; Store the sum in the X register

    LDA $03          ; Load the length of the first base
    CLC             ; Clear the carry flag
    ADC $04         ; Add the length of the second base
    TAX             ; Store the new sum in the X register

    STA result      ; Store the result in the memory location "result"

end:
    JMP end         ; End of the program

.segment "DATA"
result: .BYTE 0      ; Memory location to store the result

