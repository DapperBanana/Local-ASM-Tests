
    LDA #11        ; Number of sides of the hendecagon
    STA sides      ; Store in variable sides
    
    LDA #15        ; Length of each side
    STA side_length ; Store in variable side_length
    
    LDA side_length
    STA base        ; Store in variable base
    
    LDX #0         ; Initialize index register X
    
loop:
    LDA base       ; Load base (side length) into accumulator
    STA height     ; Store in variable height
    
    JSR multiply   ; Call multiply subroutine to calculate base * height
    STA area       ; Store the result in variable area
    
    LDA area       ; Load the area into accumulator
    LDX #0         ; Reset the index register X
    
    INX            ; Increment index register X
    STX base       ; Store new base value 
    
    DEC sides      ; Decrement sides counter
    
    LDA sides
    BNE loop       ; Continue loop until all sides have been calculated
    
    HLT            ; Halt the program

multiply:
    ; Multiplication subroutine to calculate base * height
    LDX #0
    LDY #0
    
multiply_loop:
    CLC            ; Clear the carry flag
    LDA base       ; Load base value
    ADC area       ; Add area value
    STA area       ; Store the result in area
    
    LDA height     ; Load height value
    ADC carry      ; Add carry value
    STA carry      ; Store the carry value
    
    INX            ; Increment index X
    CPX #8         ; Compare index X to 8
    BNE multiply_loop ; Continue loop until 8 iterations are done
    
    RTS            ; Return from subroutine

sides:   .BYTE 0
side_length: .BYTE 0
base:    .BYTE 0
height:  .BYTE 0
area:    .WORD 0
carry:   .BYTE 0
