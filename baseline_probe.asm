
START:
    LDX #0          ; Initialize X register to 0 (list index)
    LDA #0          ; Initialize accumulator to 0 (sum of x values)
    STA SUMX
    LDA #0          ; Initialize accumulator to 0 (sum of y values)
    STA SUMY
    LDA #0          ; Initialize accumulator to 0 (sum of x*y values)
    STA SUMXY
    LDA #0          ; Initialize accumulator to 0 (sum of x^2 values)
    STA SUMXSQ
    LDA #0          ; Initialize accumulator to 0 (sum of y^2 values)
    STA SUMYSQ

LOOP:
    LDA XVAL,X      ; Load X value from XVAL list
    STA VALX
    LDA YVAL,X      ; Load Y value from YVAL list
    STA VALY

    CLC             ; Clear carry flag
    LDA VALX
    ADC SUMX        ; Add to sum of x values
    STA SUMX

    LDA VALY
    ADC SUMY        ; Add to sum of y values
    STA SUMY

    LDA VALX
    STA TMP         ; Store X value in temporary variable

    CLC             ; Clear carry flag
    LDA TMP
    ADC TMP         ; Calculate x^2
    STA TMP
    ADC SUMXSQ      ; Add to sum of x^2 values
    STA SUMXSQ

    LDA VALY
    STA TMP         ; Store Y value in temporary variable

    CLC             ; Clear carry flag
    LDA TMP
    ADC TMP         ; Calculate y^2
    STA TMP
    ADC SUMYSQ      ; Add to sum of y^2 values
    STA SUMYSQ

    LDA VALX        ; Load X value
    MUL VALY        ; Multiply X and Y values
    STA TMP         ; Save result 
    CLC
    LDA TMP
    ADC SUMXY       ; Add to sum of x*y values
    STA SUMXY

    INX             ; Increment list index
    CPX #LISTSIZE   ; Compare list index to list size
    BNE LOOP        ; Continue loop if not at end of list

    ; Calculate correlation coefficient
    LDX #LISTSIZE   ; Load list size
    DEX             ; Decrement
    LDA SUMX
    STA TMP         ; Store sum of X values
    LDA SUMY
    ADC TMP         ; Add to sum of Y values
    STA TMP         ; Store sum of X + Y values
    LDA TMP
    SEC             ; Set carry flag
    SBC #LISTSIZE   ; Subtract list size
    STA TMP         ; Store sum of X + Y - n
    LDA SUMXSQ
    STA TMP         ; Store sum of X^2
    CLC
    LDA SUMYSQ
    ADC TMP         ; Add to sum of Y^2
    STA TMP         ; Store sum of X^2 + Y^2
    LDA SUMXY
    LSR             ; Shift right to divide by 2 (for averaging)
    ADC TMP         ; Add to sum of X*Y
    STA TMP         ; Store sum of X*Y + (X^2 + Y^2)/2

    ; Calculate correlation coefficient (r)
    LDA TMP         ; Load numerator
    MUL TMP         ; Square
    LDX #0          ; Initialize X register for division
    LDA SUMXSQ
    STA TMP         ; Store sum of X^2
    CLC             ; Clear carry flag
    LDA TMP
    ADC SUMYSQ      ; Add to sum of Y^2
    STA TMP         ; Store sum of X^2 + Y^2
    JSR SQRT        ; Calculate square root
    STA TMP         ; Store denominator (sqrt(X^2 + Y^2))
    PLA
    PLA
    ; Print correlation coefficient (r)
    JSR PRINTNUM

    RTS             ; Return from subroutine

; Square root subroutine
SQRT:
    STA SQRTNUM     ; Store input number
    LDX #0          ; Initialize X register for division
    LDA #0          ; Initialize accumulator for result
    LDA #0          ; Initialize accumulator for remainder
    STX REMAINDER
    STA RESULT
LOOP2:
    ASL SQRTNUM     ; Shift left
    ROL SQRTNUM
    ROL SQRTR
    LDA RESULT
    ASL
    ROL
    STA TMP
    LDA RESULT
    ADC SQRTNUM
    STA RESULT
    CMP #$80
    BCC NOTFOTO
    SEC
    SBC #$80
    STA RESULT
    INC REMAINDER
NOTFOTO:
    DEX
    BNE LOOP2
    RTS

PRINTNUM:
    ; Print number in accumulator
    STA TEMP         ; Store accumulator
    LDX #2           ; Print 2 decimal places
    LDA #$00         ; Print integer part
    JSR PRINTDIGIT   ; Print digit
    LDA #$2C         ; Print comma
    JSR PRINTCHR     ; Print character
    LDA TEMP         ; Load accumulator
    AND #$0F         ; Mask high nibble
    ASL              ; Shift to high nibble
    ASL
    ASL
    ASL
    JSR PRINTDIGIT   ; Print digit
    LDA #$2E         ; Print dot
    JSR PRINTCHR
    LDA TEMP         ; Load accumulator
    AND #$0F         ; Mask low nibble
    JSR PRINTDIGIT   ; Print digit
    RTS

PRINTDIGIT:
    PHA              ; Push accumulator onto stack
    AND #$0F         ; Mask low nibble
    CMP #$0A         ; Check if digit is >= 10
    BCC PRINTDIGIT2  ; If not, print digit
    ADC #$07         ; Convert to ASCII 'A'
    JSR PRINTCHR     ; Print character
    PLA              ; Pull accumulator from stack
    ADC #$03         ; Add 3 to convert to ASCII '0'
PRINTDIGIT2:
    ADC #$30         ; Convert to ASCII '0'
    JSR PRINTCHR     ; Print character
    PLA              ; Pull accumulator from stack
    RTS

PRINTCHR:
    STA $D010        ; Print character to screen
    RTS

; Data section
LISTSIZE:   .byte 10       ; List size
XVAL:       .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10    ; List of X values
YVAL:       .byte 10, 9, 8, 7, 6, 5, 4, 3, 2, 1    ; List of Y values

SUMX:       .byte 0        ; Sum of X values
SUMY:       .byte 0        ; Sum of Y values
SUMXY:      .byte 0        ; Sum of XY values
SUMXSQ:     .byte 0        ; Sum of X^2 values
SUMYSQ:     .byte 0        ; Sum of Y^2 values

VALX:       .byte 0        ; Current X value
VALY:       .byte 0        ; Current Y value
TMP:        .byte 0        ; Temporary value
RESULT:     .byte 0        ; Result of division
REMAINDER:  .byte 0        ; Remainder of division
SQRTNUM:    .byte 0        ; Number to calculate square root of
SQRTR:      .byte 0        ; Square root result
TEMP:       .byte 0        ; Temporary storage for printing

END START
