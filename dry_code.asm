
START        LDX #0              ; Initialize sum to 0
             LDY #0
             LDA #SIDES         ; Load number of sides into accumulator
             STA COUNT

LOOP         LDA #SIDEL          ; Load side length into accumulator
             STA LENGTH

             CLC
             LDA SUM
             ADC LENGTH         ; Add side length to sum
             STA SUM

             INY                ; Increment loop counter
             CPY COUNT          ; Compare current side count to total sides
             BNE LOOP           ; Loop until all sides processed

             LDA SUM
             JSR DIVIDE          ; Calculate half of perimeter
             STA PERIMETER

             LDA #0
             STA AREA           ; Initialize area to 0

             LDA #0
             STA X              ; Initialize x to 0

CALC_AREA    LDA PERIMETER
             STA PERIMETER

             LDA #0
             STA Y              ; Initialize y to 0

LOOP_AREA    LDX X
             LDA PERIMETER
             JSR SQRT            ; Calculate square root
             STA TEMP

             LDA Y
             ADC TEMP           ; Add square root to y
             STA Y

             LDA PERIMETER
             STA TEMP

             CLC
             LDA TEMP
             ADC LENGTH         ; Add side length to perimeter
             STA PERIMETER

             INX                ; Increment x
             CPX COUNT          ; Compare x to number of sides
             BNE LOOP_AREA      ; Loop until all sides processed

             LDA Y
             JSR MULTIPLY        ; Multiply y by side length
             STA AREA

DONE         BRK

DIVIDE       SEC
             LDA #DIV
             SBC SUM            ; Subtract sum from divisor
             STZ REMAINDER
DIV_LOOP     SBC #0
             BCC DIV_DONE       ; Exit loop if negative
             INC REMAINDER
             JMP DIV_LOOP
DIV_DONE     LDA #0
             ADC SUM            ; Calculate remainder
             STA REMAINDER
             LDA REMAINDER
             LSR                ; Divide remainder by 2
             LSR
             LSR
             LSR
             STA PERIMETER
             RTS

MULTIPLY     CLC
             LDA Y
             JSR TEMP1          ; Save y to temp1
             LDA Y
             ASL                ; Multiply y by 2
             ASL
             STA Y

MULTIPLY_LOOP STA TEMP            ; Save temp
             LDA #0
             STA TEMP2
MULTIPLY_L   ROL TEMP2           ; Multiply y by side length
             DEC X
             BNE MULTIPLY_L
             LDA TEMP
             ADC TEMP2
             STA AREA
             RTS

SQRT         LDY #8
             LDA #0
             STA ROOT
SQRT_L       CLC
             ROL TEMP            ; Shift left
             BCC SQRT_S
             LDA ROOT
             ADC #$01            ; Add x to root
             STA ROOT
SQRT_S       DEY
             BNE SQRT_L
             RTS

DIV          .BYTE #$02
SIDES        .BYTE 6
SIDEL        .BYTE 5

COUNT        .BYTE
SUM          .BYTE
LENGTH       .BYTE
PERIMETER    .BYTE
AREA         .BYTE
X            .BYTE
Y            .BYTE
REMAINDER    .BYTE
TEMP         .BYTE
TEMP1        .BYTE
TEMP2        .BYTE
ROOT         .BYTE
