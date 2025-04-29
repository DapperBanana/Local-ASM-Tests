
MAIN    LDX #0              ; initialize X register to 0
        LDA #0              ; initialize A register to 0
        STA AREA            ; initialize the area variable to 0

GET_SIDES
        LDA #<SIDES_PROMPT  ; load low byte of SIDES_PROMPT address
        LDY #>SIDES_PROMPT  ; load high byte of SIDES_PROMPT address
        JSR PRINT_STRING    ; print prompt for number of sides
        JSR READ_NUMBER      ; read number of sides into A register

        STA SIDES           ; store number of sides in SIDES variable

GET_SIDE_LENGTH
        LDA #<SIDE_LENGTH_PROMPT  ; load low byte of SIDE_LENGTH_PROMPT address
        LDY #>SIDE_LENGTH_PROMPT  ; load high byte of SIDE_LENGTH_PROMPT address
        JSR PRINT_STRING          ; print prompt for side length
        JSR READ_NUMBER            ; read side length into A register

        STA SIDE_LENGTH         ; store side length in SIDE_LENGTH variable

CALCULATE_AREA
        LDX SIDES        ; get number of sides
        LDA SIDE_LENGTH  ; get side length

        SEC
        LDA AREA         ; clear carry flag
NEXT_SIDE
        ADC AREA         ; add the current area to accumulator
        STA AREA         ; store the result in AREA
        DEX              ; decrement X register
        BNE NEXT_SIDE    ; loop until all sides are processed

        JSR CLEAR_SCREEN  ; clear the screen
        JSR PRINT_RESULT  ; print the calculated area

END     BRK              ; terminate the program

AREA        .BYTE 0
SIDES       .BYTE 0
SIDE_LENGTH .BYTE 0

SIDES_PROMPT       .BYTE "Enter number of sides: ",0
SIDE_LENGTH_PROMPT .BYTE "Enter length of each side: ",0

INCLUDE "print_string.asm"
INCLUDE "read_number.asm"
INCLUDE "clear_screen.asm"
INCLUDE "print_result.asm"
