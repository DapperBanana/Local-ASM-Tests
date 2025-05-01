
; Assume the variable 'radius' is already defined and holds the radius value
; Assume the 'pi' constant is already defined and holds the value of pi (e.g. 3.14159)

    LDA radius    ; Load the radius value into the accumulator
    STA $00       ; Store it in memory location $00
    LDA $00       ; Load the radius value back into the accumulator
    JSR MULT      ; Call the MULT subroutine to calculate radius * radius
    STA $01       ; Store the result in memory location $01
    LDA $01       ; Load the result back into the accumulator
    JSR MULT      ; Call the MULT subroutine again to calculate the result * pi
    STA $02       ; Store the final result in memory location $02

    ; Now $02 contains the area of the circle given its radius

MULT:
    LDX #0         ; Clear X register (result will be stored here)
LOOP:
    CMP #0         ; Check if A is zero
    BEQ EXIT       ; If A is zero, exit the loop
    CLC            ; Clear carry
    ADC $00        ; Add the value in $00 to X (result)
    DEX            ; Decrement X
    BNE LOOP       ; Continue looping until X reaches 0
EXIT:
    RTS            ; Return from subroutine
