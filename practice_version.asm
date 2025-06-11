
        .text
        .globl _start
	
_start:
        LDA radius         ; Load radius into accumulator
        STA radius
	
        LDX radius         ; Load radius into X register
        JSR multiply       ; Call multiply subroutine to calculate (radius * radius)
	
        JSR multiply       ; Call multiply subroutine to calculate result * PI (3.14159)
	
        STA area           ; Store the result in the "area" variable
	
        HLT                ; Halt the program

multiply:
        LDY #$00           ; Clear Y register
        STY result         ; Clear the result variable
	
loop:
        CPX #$00           ; Check if X register is zero
        BEQ end            ; If zero, end the loop
	
        CLC                ; Clear carry flag
        LDA radius         ; Load radius into accumulator
        ADC result         ; Add result to accumulator
        STA result         ; Store the result
	
        DEX                ; Decrement X register
        JMP loop           ; Continue loop
	
end:
        RTS                ; Return from subroutine

        .data
	
radius: .byte 5           ; Radius of the circle
result: .byte 0           ; Result of calculations
area:   .byte 0           ; Area of the circle
