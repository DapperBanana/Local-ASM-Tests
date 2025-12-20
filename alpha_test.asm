// This C# code outputs a 6502 assembly program that converts a number (1-3999)
// to its Roman numeral equivalent.

string assemblyCode = @"
        .org $8000
        * Start here
        LDX #0            ; Index for input number (0-3999)
        LDY #0            ; Index for output string

        ; Read input number into A (for demonstration, hardcode a number, e.g., 1987)
        LDA #19
        STA NUM_HIGH
        LDA #87
        STA NUM_LOW

        ; Convert to total number (for simplicity, reconstruct number)
        LDA NUM_HIGH
        ASL
        CLC
        ADC NUM_HIGH
        ; total = NUM_HIGH * 100 + NUM_LOW

        ; For demonstration, use a hardcoded number
        LDA #19
        STA NUM_HIGH
        LDA #87
        STA NUM_LOW

        ; Here, for brevity, assume input number is in memory as 'NUM'

        ; Assume input number stored in zero page address 'NUM' (e.g., 4 bytes)
        ; In real code, you would get user input or pre-assign the number

        ; For simplicity, directly set 'NUM' value
        LDA #1987
        STA NUM

        ; Convert 'NUM' to Roman Numeral
        ; This process involves repeatedly subtracting from predefined values
        ; and appending corresponding symbols to output buffer

        ; Initialize output buffer pointer at $00
        LDX #0
        STX OUT_PTR

        ; Subtract and Append for 1000 (M)
LOOP_M:
        LDA NUM
        CMP #1000
        SBC #1000
        BCS skip_M
        ; Append 'M'
        LDA #77  ; 'M'
        JSR AppendChar
        ; Subtract 1000
        LDA NUM
        SBC #1000
        STA NUM
        JMP LOOP_M
skip_M:

        ; Subtract and Append for 900 (CM)
LOOP_CM:
        LDA NUM
        CMP #900
        SBC #900
        BCS skip_CM
        ; Append 'C'
        LDA #67  ; 'C'
        JSR AppendChar
        ; Append 'M'
        LDA #77
        JSR AppendChar
        ; Subtract 900
        LDA NUM
        SBC #900
        STA NUM
        JMP LOOP_CM
skip_CM:

        ; Subtract and Append for 500 (D)
LOOP_D:
        LDA NUM
        CMP #500
        SBC #500
        BCS skip_D
        ; Append 'D'
        LDA #68
        JSR AppendChar
        ; Subtract 500
        LDA NUM
        SBC #500
        STA NUM
        JMP LOOP_D
skip_D:

        ; Subtract and Append for 400 (CD)
LOOP_CD:
        LDA NUM
        CMP #400
        SBC #400
        BCS skip_CD
        ; Append 'C'
        LDA #67
        JSR AppendChar
        ; Append 'D'
        LDA #68
        JSR AppendChar
        ; Subtract 400
        LDA NUM
        SBC #400
        STA NUM
        JMP LOOP_CD
skip_CD:

        ; Subtract and Append for 100 (C)
LOOP_C:
        LDA NUM
        CMP #100
        SBC #100
        BCS skip_C
        ; Append 'C'
        LDA #67
        JSR AppendChar
        ; Subtract 100
        LDA NUM
        SBC #100
        STA NUM
        JMP LOOP_C
skip_C:

        ; Subtract and Append for 90 (XC)
LOOP_XC:
        LDA NUM
        CMP #90
        SBC #90
        BCS skip_XC
        ; Append 'X'
        LDA #88
        JSR AppendChar
        ; Append 'C'
        LDA #67
        JSR AppendChar
        ; Subtract 90
        LDA NUM
        SBC #90
        STA NUM
        JMP LOOP_XC
skip_XC:

        ; Subtract and Append for 50 (L)
LOOP_L:
        LDA NUM
        CMP #50
        SBC #50
        BCS skip_L
        ; Append 'L'
        LDA #76
        JSR AppendChar
        ; Subtract 50
        LDA NUM
        SBC #50
        STA NUM
        JMP LOOP_L
skip_L:

        ; Subtract and Append for 40 (XL)
LOOP_XL:
        LDA NUM
        CMP #40
        SBC #40
        BCS skip_XL
        ; Append 'X'
        LDA #88
        JSR AppendChar
        ; Append 'L'
        LDA #76
        JSR AppendChar
        ; Subtract 40
        LDA NUM
        SBC #40
        STA NUM
        JMP LOOP_XL
skip_XL:

        ; Subtract and Append for 10 (X)
LOOP_X:
        LDA NUM
        CMP #10
        SBC #10
        BCS skip_X
        ; Append 'X'
        LDA #88
        JSR AppendChar
        ; Subtract 10
        LDA NUM
        SBC #10
        STA NUM
        JMP LOOP_X
skip_X:

        ; Subtract and Append for 9 (IX)
LOOP_IX:
        LDA NUM
        CMP #9
        SBC #9
        BCS skip_IX
        ; Append 'I'
        LDA #73
        JSR AppendChar
        ; Append 'X'
        LDA #88
        JSR AppendChar
        ; Subtract 9
        LDA NUM
        SBC #9
        STA NUM
        JMP LOOP_IX
skip_IX:

        ; Subtract and Append for 5 (V)
LOOP_V:
        LDA NUM
        CMP #5
        SBC #5
        BCS skip_V
        ; Append 'V'
        LDA #86
        JSR AppendChar
        ; Subtract 5
        LDA NUM
        SBC #5
        STA NUM
        JMP LOOP_V
skip_V:

        ; Subtract and Append for 4 (IV)
LOOP_IV:
        LDA NUM
        CMP #4
        SBC #4
        BCS skip_IV
        ; Append 'I'
        LDA #73
        JSR AppendChar
        ; Append 'V'
        LDA #86
        JSR AppendChar
        ; Subtract 4
        LDA NUM
        SBC #4
        STA NUM
        JMP LOOP_IV
skip_IV:

        ; Subtract and Append for 1 (I)
LOOP_I:
        LDA NUM
        CMP #1
        SBC #1
        BCS skip_I
        ; Append 'I'
        LDA #73
        JSR AppendChar
        ; Subtract 1
        LDA NUM
        SBC #1
        STA NUM
        JMP LOOP_I
skip_I:

        ; End of conversion
        ; Here, you'd typically output the string in buffer

        RTS

; Data and routines
NUM     .byte 0
OUT_BUF .res 20       ; Reserve 20 bytes for output
OUT_PTR .res 1      ; Pointer for output buffer


; Routine to append character to output buffer
AppendChar:
        LDA OUT_PTR
        LDX OUT_PTR
        LDA #0
        STA OUT_BUF, X
        INX
        STX OUT_PTR
        RTS
";

Console.WriteLine(assemblyCode);