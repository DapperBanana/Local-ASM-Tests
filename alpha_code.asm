
;----------------------------------------------
; 6502 Assembly program to calculate the sum
; of all even Fibonacci numbers up to a given limit
;----------------------------------------------

        .org $0200              ; Start address where program will be loaded

        LDX #0                 ; Initialize X register to 0 (Fibonacci term)
        LDY #1                 ; Initialize Y register to 1 (next Fibonacci term)
        LDA #0                 ; Initialize accumulator to 0 (sum of even Fibonacci numbers)
        STA SUM                ; Store sum at memory address SUM

LOOP:
        CPX LIMIT              ; Compare current Fibonacci term with the limit
        BCS END                ; If current term >= limit, end the program

        STA TMP                ; Store current Fibonacci term in TMP
        ADC X                  ; Add current term to accumulator
        BCS ADD_OVERFLOW       ; Handle 16-bit addition overflow
        STA SUM                ; Store sum in memory
        LDA Y                  ; Load next Fibonacci term from Y register
        STA TMP2               ; Store it in TMP2
        CLC
        ADC Y                  ; Add next term to previous term
        BCC SKIP               ; Branch if no carry (no overflow)
        INC TMP2               ; Add carry to higher byte
        SEC
        SBC #256               ; Subtract 256
        STA Y
SKIP:
        LDA TMP2               ; Load next term back from TMP2
        STA Y
        LDA TMP                ; Load current term back from TMP
        STA X                  ; Move current term to X register
        
        JMP LOOP               ; Repeat process for next Fibonacci term

ADD_OVERFLOW:
        INC TMP2               ; Increment higher byte
        STA Y                  ; Store it in Y register

END:
        BRK                    ; End program

SUM:    .byte 0                ; Memory location to store sum
TMP:    .byte 0                ; Temporary storage for current term
TMP2:   .byte 0                ; Temporary storage for next term
LIMIT:  .byte 10               ; Limit for Fibonacci series

        .end
