
ORG $1000

LDX #$00         ; Initialize index variable to 0
LDY #$01         ; Initialize second Fibonacci number to 1
LDA #$00         ; Initialize sum to 0

start:
    STA $FF       ; Save previous Fibonacci number
    CLC
    LDA XREG      ; Load current Fibonacci number
    ADC YREG      ; Add previous Fibonacci number
    TAX           ; Save current Fibonacci number
    TYA
    TAY           ; Save current Fibonacci number
    AND #$01      ; Check if current Fibonacci number is even
    BEQ even      ; If even, add to sum
    JMP continue

even:
    LDA AREG      ; Load sum
    ADC XREG      ; Add even Fibonacci number
    STA AREG      ; Save sum

continue:
    CMP #100      ; Check if reached limit of 100
    BCC start     ; If not, continue loop

done:
    ; Program is complete
    BRK

  .ORG $FD.   ; Program variables
XREG .DS 1
YREG .DS 1
AREG .DS 1

  .ORG $FF.   ; Previous Fibonacci number
  .DS 1

