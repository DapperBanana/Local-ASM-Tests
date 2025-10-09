
        ; Program to swap the values of two variables without using a temporary variable
        
        ; Define variables
        LDX #VALUE1          ; Load the memory address of variable1 into X register
        LDY #VALUE2          ; Load the memory address of variable2 into Y register
        
        ; Swap values without using temporary variable
        LDA (X),Y            ; Load the value of variable1 into accumulator
        STA (Y),X            ; Store the value of variable2 into the memory location of variable1
        STA (X),Y            ; Store the value of variable1 into the memory location of variable2
        
        ; End of program
        BRK
        
        ; Variable declarations
VALUE1  .BYTE $05           ; Variable 1 with initial value of 5
VALUE2  .BYTE $0A           ; Variable 2 with initial value of 10
