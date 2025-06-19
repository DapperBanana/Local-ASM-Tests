
RESET    .org $0200  ; Set the program start address to $0200

START    LDX #$00    ; Initialize X register to zero for loop count
         LDY #ROOTS  ; Load the address of the ROOTS array
         
LOOP     LDA ROOTS,Y ; Load the next coefficient from the ROOTS array
         STA COEF,X  ; Store the coefficient in the COEF array
         INY         ; Increment Y to point to the next coefficient
         INX         ; Increment X to point to the next location in COEF
         CPY #ROOTS_END ; Compare Y with the end of the ROOTS array
         BNE LOOP    ; If Y is not at the end, continue the loop

         LDX #$00    ; Initialize X for calculating the roots
CALCULATE LDA COEF,X  ; Load the first coefficient
         STA A        ; Store it in register A
         LDA COEF,X+1 ; Load the second coefficient
         STA B        ; Store it in register B
         LDA COEF,X+2 ; Load the third coefficient
         STA C        ; Store it in register C

         LDX #$00    ; Initialize X for calculating the roots
         LDA B        ; Load the second coefficient
         STA TEMP     ; Store it in TEMP
         SEC          ; Set the carry flag
         SBC SQR(TEMP) ; Subtract the square root of the second coefficient
         STA TEMP     ; Store the result in TEMP
         LDA TEMP     ; Load the result
         STA TEMP     ; Store the result in TEMP
         LDX #$00    ; Initialize X for calculating the roots
         
         LDA SQR(B)   ; Load the square root of the second coefficient
         STA TEMP2    ; Store it in TEMP2
         LDA TEMP     ; Load the result
         STA TEMP     ; Store the result in TEMP
         
         LDA B        ; Load the second coefficient
         ADC TEMP     ; Add the result
         LSR          ; Shift the result right
         ADC TEMP2    ; Add TEMP2
         STA TEMP     ; Store the final result in TEMP
         
         LDA TEMP     ; Load the final result
         STA ROOT1    ; Store it as the first root
         
         LDA SQR(TEMP) ; Load the square root of TEMP
         STA TEMP     ; Store it in TEMP
         LDA B        ; Load the second coefficient
         STA ROOT2    ; Store it as the second root
         
         RTS          ; Return from subroutine

; Constants and Variables
ROOTS    .byte 3, 4, 5 ; Coefficients of the quadratic equation
ROOTS_END = *-1         ; End of ROOTS array
COEF     .res 3         ; Array to store the coefficients
A        .res 1         ; Register to store first coefficient
B        .res 1         ; Register to store second coefficient
C        .res 1         ; Register to store third coefficient
TEMP     .res 1         ; Temporary storage for calculations
TEMP2    .res 1         ; Temporary storage for calculations
ROOT1    .res 1         ; First root of the equation
ROOT2    .res 1         ; Second root of the equation

; Square root function
SQR      .byte $00, $01, $01, $02 ; Square root values

         .end
