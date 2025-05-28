
; Calculate the area of a trapezoidal prism

        .text               ; start of code section

        .global _start      ; make entry point visible to linker

_start:
        lda #10             ; load base1 value into accumulator (you can use different values)
        sta base1
        
        lda #15             ; load base2 value into accumulator (you can use different values)
        sta base2
        
        lda #8              ; load height value into accumulator (you can use different values)
        sta height
        
        lda base1          ; load base1 into accumulator
        clc                 ; clear carry flag
        adc base2          ; add base2 to accumulator
        asl                 ; shift left to multiply by 2 (equiv. to multiplying by 2)
        adc height          ; add height to accumulator
        lsr                 ; shift right to divide by 2 (equiv. to dividing by 2)
        
        ; The calculated area is now in the accumulator
        
        ; You can now do further processing or store the result as desired
        
        ; Terminate the program
        brk                 ; break

        .data               ; start of data section

base1:  .byte   0           ; variable to store base1 value
base2:  .byte   0           ; variable to store base2 value
height: .byte   0           ; variable to store height value
