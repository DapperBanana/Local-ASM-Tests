
LDA #10      ; Load base of parallelogram into accumulator
STA base

LDA #5       ; Load height of parallelogram into accumulator
STA height

LDA base
SEC
ADC height   ; Add base and height
STA side1

LDA height
SEC
ADC base     ; Add height and base
STA side2

LDA side1    ; Load side1 into accumulator
CLC
ADC side2    ; Add side1 and side2
LSR          ; Divide by 2 (right shift)
STA average

LDA base
SEC
ADC average  ; Add base and average
STA sum1

LDA height
SEC
ADC average  ; Add height and average
STA sum2

LDA sum1     ; Load sum1 into accumulator
CLC
ADC sum2     ; Add sum1 and sum2
STA area

BRK          ; Break
