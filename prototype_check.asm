
START LDA #11           ; Load the number of sides of the hendecagon (11) into the accumulator
    STA SIDES

    LDA #100           ; Load the length of each side of the hendecagon (assuming it's 100 units) into the accumulator
    STA SIDE_LENGTH

    JSR CALC_AREA      ; Jump to the subroutine to calculate the area

    ; Output the result
    LDX AREA           ; Load the area into the X register
    LDA AREA+1         ; Load the high byte of the area into the accumulator
    JSR PRINT_AREA     ; Jump to the subroutine to print the area

    BRK                ; End the program

CALC_AREA LDA #0         ; Clear the accumulator
    STA AREA+1        ; Clear the high byte of the area

    LDA SIDES         ; Load the number of sides into the accumulator
    CLC
    ADC #1            ; Add 1 to account for the first side
    STA TEMP          ; Store the result in TEMP

    LDA TEMP          ; Load TEMP into the accumulator
    ASL               ; Multiply by 2 (each triangle is made up of 2 sides of the hendecagon)
    STA TEMP

    LDA TEMP          ; Get the number of sides times 2 into the accumulator
    STA MULT

    LDA SIDES         ; Load the number of sides into the accumulator
    LSR               ; Divide by 2 (number of triangles in the hendecagon)
    STA SIDES

LOOP LDA SIDE_LENGTH   ; Load the side length into the accumulator
    STA TEMP

    LDA MULT          ; Load the multiplier into the accumulator
    CLC
    ADC AREA          ; Add the current area
    STA AREA

    LDA TEMP          ; Load the side length into the accumulator
    ADC AREA+1        ; Add the high byte of the current area
    STA AREA+1

    DEC SIDES         ; Decrement the number of sides
    BNE LOOP          ; Repeat until all sides have been processed

    RTS               ; Return from subroutine

PRINT_AREA LDA #<RESULT  ; Load the low byte of the string address into the accumulator
    STA TEMP
    LDA #>RESULT        ; Load the high byte of the string address into the accumulator
    STA TEMP+1

    LDX #0             ; Set X register to 0 (start of string)

LOOP2 LDA RESULT,X      ; Load the character at the current position into the accumulator
    BEQ END_PRINT     ; If the character is zero, end printing
    JSR $FFD2         ; Output the character to screen
    INX               ; Increment the X register
    JMP LOOP2         ; Repeat until zero terminator

END_PRINT RTS
