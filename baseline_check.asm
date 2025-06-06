
        .org $0200

        JSR INPUT_COORDINATES ; Get input coordinates for points A and B
        JSR CALC_DISTANCE ; Calculate the distance between points A and B

        BRK ; End of program

; Subroutine to get input coordinates for points A and B
INPUT_COORDINATES:
        LDX #$00 ; Initialize index
GET_COORDINATE:
        LDA PROMPT,X ; Display prompt for X, Y, Z coordinates
        JSR PRINT_STRING
        
        JSR READ_INT ; Read input X coordinate
        STA POINT_A,X ; Store X coordinate for point A

        INX ; Increment index
        CPX #$03 ; Check if all coordinates have been entered
        BNE GET_COORDINATE ; Continue getting input coordinates
        RTS ; Return from subroutine

POINT_A: .byte 3 ; Store X, Y, Z coordinates for point A
POINT_B: .byte 3 ; Store X, Y, Z coordinates for point B

PROMPT: .asc "Enter coordinate: "

; Subroutine to calculate the distance between points A and B
CALC_DISTANCE:
        LDX #$00 ; Initialize index for coordinates
        LDA #$00 ; Initialize sum of squares
CALC_SQUARES:
        LDY POINT_A,X ; Get X coordinate of point A
        LDA POINT_B,X ; Get X coordinate of point B
        CLC
        ADC #$80 ; Adjust for signed 8-bit addition
        SEC
        SBC LDY ; Calculate difference between coordinates
        ASL A ; Square the difference
        CLC
        ADC A ; Add to sum of squares
        STA SUM_SQUARES

        INX ; Increment index
        CPX #$03 ; Check if all coordinates have been processed
        BNE CALC_SQUARES ; Continue calculating squares

        LDA SUM_SQUARES ; Load sum of squares
        STA $1000 ; Store in memory for display

        JSR SQRT ; Calculate square root of sum of squares

        LDA $1000 ; Load result into accumulator
        STA $2000 ; Store in memory for display
        
        RTS ; Return from subroutine

SQRT:   ; Calculates the square root of the stored value
        LDX #$00
        LDA $1000
        STA FAC ; Sets accumulator to saved result
        LDA #$00
        STA SRP ; Starts recursion at zero

SQRT1:  JSR SQROOT ; Computes recursively
        LDA FAC
        STA $1001
        DEC X
        BNE SQRT1
        RTS

WSQRT:  ; Specifies word for recursive function
        .dw $1001

FAC:    .ds 1 ; Store current value being squared
SRP:    .ds 1 ; Square root pointer position
SUM_SQUARES: .ds 1 ; Stores the sum of squares for distance calculation

; Subroutine to read an integer input
READ_INT:
        LDA #$00 ; Clear accumulator
GET_CHAR:
        JSR GET_KEY ; Wait for key press
        CMP #$0D ; Check for Enter key press
        BEQ END_READ_INT ; Exit loop if Enter key pressed

        CMP #$30 ; Check if input is valid ASCII digit
        BCC GET_CHAR ; Continue getting input if not a digit
        CMP #$39
        BCS GET_CHAR

        PHA ; Save input digit on stack
        LSR ; Shift input digit to the right
        LSR
        LSR
        LSR
        CLC ; Clear carry flag
        ADC #$30 ; Convert input digit to decimal
        TAX ; Transfer input digit to X register
        PLA ; Restore input digit from stack
        JSR PRINT_CHAR ; Display input digit
        JMP GET_CHAR ; Continue getting input

END_READ_INT:
        RTS

; Subroutine to get key input
GET_KEY:
        LDA $FF00 ; Check keyboard buffer
        BEQ GET_KEY ; Wait until key is pressed
        STA $FF02 ; Clear keyboard buffer
        RTS

; Subroutine to print a character
PRINT_CHAR:
        STA $FF01 ; Display character
        RTS

; Subroutine to print a string
PRINT_STRING:
        LDY #$00 ; Initialize index
PRINT_LOOP:
        LDA (PROMPT),Y ; Load character from string
        BEQ END_PRINT_STRING ; Exit loop if end of string
        JSR PRINT_CHAR ; Display character
        INY ; Increment index
        JMP PRINT_LOOP ; Continue printing string

END_PRINT_STRING:
        RTS

        .end
