
LOAD_A:
    LDA #0          ; Load accumulator with 0
    STA RESULT      ; Store 0 in result variable

INPUT:
    JSR READ_INPUT  ; Call subroutine to read user input
    CMP #$2B        ; Compare input with ASCII code for '+'
    BEQ ADD
    CMP #$2D        ; Compare input with ASCII code for '-'
    BEQ SUBTRACT
    CMP #$2A        ; Compare input with ASCII code for '*'
    BEQ MULTIPLY
    CMP #$2F        ; Compare input with ASCII code for '/'
    BEQ DIVIDE

FINISH:
    JMP INPUT       ; Loop back to input

ADD:
    JSR READ_INPUT  ; Read second number
    CLC             ; Clear carry flag
    ADC RESULT      ; Add second number to result
    STA RESULT      ; Store result
    JMP FINISH

SUBTRACT:
    JSR READ_INPUT  ; Read second number
    SEC             ; Set carry flag
    SBC RESULT      ; Subtract second number from result
    STA RESULT      ; Store result
    JMP FINISH

MULTIPLY:
    JSR READ_INPUT  ; Read second number
    LDA RESULT      ; Load first number from result
    STA TEMPA       ; Store first number
    LDA RESULT+1    ; Load first number from result
    STA TEMPA+1     ; Store first number
    LDA TEMPA       ; Load first number from temp
    STA TEMPB       ; Store first number
    LDA TEMPA+1     ; Load first number from temp
    STA TEMPB+1     ; Store first number
    LDA #0          ; Initialize accumulator
    STA RESULT      ; Clear result
    STA RESULT+1
LOOP:
    LDA TEMPB       ; Load first number from temp
    BEQ FINISH_LOOP ; If first number is 0, exit loop
    CLC             ; Clear carry flag
    ADC TEMPA       ; Add first number to accumulator
    STA RESULT      ; Store result
    LDA TEMPB+1     ; Load first number from temp
    ADC #0          ; Add carry to second number
    STA TEMPB+1     ; Store first number
    JMP LOOP

FINISH_LOOP:
    JMP FINISH

DIVIDE:
    JSR READ_INPUT  ; Read second number
    LDA RESULT      ; Load first number from result
    STA TEMPA       ; Store divisor
    LDA RESULT+1    ; Load first number from result
    STA TEMPA+1     ; Store divisor
    LDA #0          ; Initialize accumulator
    STA RESULT      ; Clear result
    STA RESULT+1
    LDA #$FFFF      ; Load -1 into register
    STA TEMP        ; Store -1
DIV_LOOP:
    LDA RESULT      ; Load dividend from result
    BEQ FINISH_DIV  ; If dividend is 0, exit loop
    CPY TEMP        ; Compare dividend with -1
    BEQ NEG_DIV     ; If dividend is negative, skip negation
    SEC             ; Set carry flag
NEG_DIV:
    SBC TEMPA       ; Subtract divisor from dividend
    INC TEMP        ; Increment negative divisor
    BCC DIV_LOOP    ; Branch if carry flag is clear
    JMP FINISH_DIV

FINISH_DIV:
    JMP FINISH

READ_INPUT:
    LDX #0          ; Load index register with 0
GETCHAR:
    JSR GETC        ; Call GETC subroutine
    CMP #$0D        ; Check for ENTER key
    BEQ RETURN      ; If ENTER key is pressed, return
    STA BUFFER,X    ; Store input in buffer
    INX             ; Increment index
    JMP GETCHAR

RETURN:
    RTS             ; Return from subroutine

RESULT:
    .BYTE 0         ; Result variable (2 bytes)

BUFFER:
    .BLKB 10        ; Input buffer

TEMPA:
    .BYTE 0         ; Temporary variable (2 bytes)

TEMPB:
    .BYTE 0         ; Temporary variable (2 bytes)

TEMP:
    .BYTE 0         ; Temporary variable
