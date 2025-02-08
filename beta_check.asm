
         .org $0200      ; Start of program memory location
         
         LDX #6         ; Radius of the cylinder (change the value as needed)
         LDY #10        ; Height of the cylinder (change the value as needed)
         
         ; Calculate the volume of the cylinder: volume = pi x r^2 x h
         LDA #$03       ; Load the value of pi (approximation)
         STA $FB        ; Store pi at memory location $FB
         
         ; Calculate radius squared
         LDA X
         STA $FD        ; Store radius in memory location $FD
         JSR MULT       ; Call subroutine to multiply radius with itself and store the result at $FD
         
         ; Calculate volume
         LDA $FB        ; Load pi
         STA $FC        ; Store pi temporarily at $FC
         
         LDA $FD        ; Load r^2
         STA $FB        ; Store r^2 as pi for further calculations
         
         LDA $FC        ; Reload pi
         JSR MULT       ; Multiply pi with r^2 and store the result at $FD
         
         LDA $FD        ; Load the result of pi x r^2 to the accumulator
         STA $FE        ; Store the result at memory location $FE
         
         LDX Y          ; Load the height of the cylinder to X register
         JSR MULT       ; Multiply height with the value stored at $FE (pi x r^2) and store the result at $FF
         
         LDA $FF        ; Load the final result (volume) to the accumulator
         STA $0200      ; Store the result of volume at memory location $0200
         
END:     BRK           ; End of program

MULT:    PHA           ; Store value of r^2 or pi in stack
         TXA           ; Transfer current value in X registers to A registers
         LDA $FD       ; Load the value of r^2 or pi from $FD to A register
         STA $FE       ; Store the current value of r^2 or pi in $FE memory location
         SEC
LOOP:    CLC
         ROL $FE       ; Rotate left the value of r^2 or pi
         ROL $FE
         ROL $FE
         ROL $FE
         DEX           ; Decrement the counter (height or r^2)
         BNE LOOP
         PLA           ; Restore value of r^2 or pi from stack
         RTS           ; Return to the main program
