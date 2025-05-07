
; 6502 Assembly program to calculate the area of a triangle given its three sides

        .org $0200

        LDX #0            ; Initialize index register X to 0
        LDY #3            ; Initialize index register Y to 3

; Input the three sides of the triangle into memory

INPUT_LOOP:
        LDA INPUT,X       ; Load the next side into the A register
        STA SIDES,X       ; Store the side in a memory location
        INX               ; Increment X
        DEY               ; Decrement Y
        BNE INPUT_LOOP     ; Loop until all sides are input

; Calculate the semi-perimeter of the triangle

        LDX #0            ; Initialize X to 0
        LDA SIDES,X       ; Load the first side into the A register
        CLC               ; Clear the carry flag
        ADC SIDES+1,X     ; Add the second side to A
        ADC SIDES+2,X     ; Add the third side to A
        STA SEMI_PERIMETER ; Store the sum in a memory location

; Calculate the area of the triangle using Heron's formula

        LDA SEMI_PERIMETER ; Load the semi-perimeter into A
        LDX #0             ; Initialize X to 0
        LDA SIDES,X        ; Load the first side into A
        STA TEMP           ; Store the first side in a temporary memory location
        LDA SIDES+1,X      ; Load the second side into A
        STA SIDES,X        ; Store the second side in the first position
        LDA SIDES+2,X      ; Load the third side into A
        STA SIDES+1,X      ; Store the third side in the second position
        LDA TEMP           ; Load the first side back into A
        STA SIDES+2,X      ; Store the first side in the third position
        LDA SEMI_PERIMETER ; Load the semi-perimeter back into A
        SEC                ; Set the carry flag
        SBC SIDES+1,X      ; Subtract the second side from A
        STA A_SIDE         ; Store the value in a memory location
        SEC                ; Set the carry flag
        SBC SIDES+2,X      ; Subtract the third side from A
        STA B_SIDE         ; Store the value in a memory location
        SEC                ; Set the carry flag
        SBC TEMP           ; Subtract the first side from A
        STA C_SIDE         ; Store the value in a memory location
        LDA A_SIDE         ; Load the value of side A into A
        LDX #0             ; Initialize X to 0
        STA SQ_A           ; Store the square of side A in a memory location
        LDA B_SIDE         ; Load the value of side B into A
        CLC                ; Clear the carry flag
        ADC SQ_A           ; Add the square of side A to A
        STA SQ_B           ; Store the sum in a memory location
        LDA C_SIDE         ; Load the value of side C into A
        CLC                ; Clear the carry flag
        ADC SQ_B           ; Add the square of side B to A
        STA SQ_C           ; Store the sum in a memory location
        LDA SQ_A           ; Load the square of side A into A
        CLC                ; Clear the carry flag
        ADC SQ_B           ; Add the square of side B to A
        LSR                ; Divide the sum by 2
        STA TEMP           ; Store the result in a temporary memory location
        LDA TEMP           ; Load the result back into A
        CLC                ; Clear the carry flag
        ADC SQ_C           ; Add the square of side C to A
        STA AREA           ; Store the final result in a memory location

; Output the area of the triangle

        LDX #0             ; Initialize X to 0
        LDA AREA           ; Load the area into the A register
        STA OUTPUT,X       ; Store the area in a memory location
