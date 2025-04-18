
; Program to calculate the sum of all even Fibonacci numbers up to a given limit

.segment "CODE"

RESET:  .word START

; Initialize variables
START:  LDX #0          ; Initialize X to 0 (index variable)
        LDY #1          ; Initialize Y to 1 (first Fibonacci number)
        STY PREV       ; Store current Fibonacci number in PREV
        STY SUM        ; Initialize SUM to 0

LOOP:   CPY LIMIT      ; Check if current Fibonacci number exceeds limit
        BCC END        ; Exit loop if current number exceeds limit

        SEC
        SBC #1          ; Decrement limit
        LSR             ; Divide limit by 2
        STA LIMIT       ; Store new limit

        CPY #2          ; Check if current number is even
        BNE ODD_NUMBER  ; If not, go to ODD_NUMBER
        CLC
        ADC SUM         ; Add to the sum of even Fibonacci numbers
        STA SUM

ODD_NUMBER:
        TXA             ; Store old Y value in X
        CLC             ; Clear carry
        ADC PREV        ; Add previous Fibonacci number to get new Fibonacci number
        TAX
        STY PREV        ; Store new Fibonacci number in PREV
        TYA             ; Restore old Y value
        JMP LOOP        ; Repeat loop

END:    BRK             ; End of program

.segment "DATA"

PREV:   .byte 0         ; Previous Fibonacci number
SUM:    .byte 0         ; Sum of even Fibonacci numbers
LIMIT:  .byte 0         ; Limit for Fibonacci sequence
