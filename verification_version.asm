
; Program to calculate the sum of all even Fibonacci numbers up to a given limit

          .org $0200
          
START     LDX #0       ; Initialize X to 0
          LDY #1       ; Initialize Y to 1
          LDA #0       ; Initialize the sum to 0
          STA SUM
      
CALCFIB:  LDA X        ; Add X to the sum
          ADC SUM
          STA SUM
      
          ; Calculate the next Fibonacci number
          CLC
          LDA Y        ; Add Y to X
          ADC X
          STA TEMP
          LDA Y        ; Set Y to X
          LDA TEMP
          STA Y
          
          ; Check if the Fibonacci number is even
          LSR A
          BCC NOT_EVEN
          ADC SUM      ; Add the even Fibonacci number to the sum
          STA SUM
      
NOT_EVEN: CPY LIMIT    ; Check if we've reached the limit
          BCC CALCFIB   ; If not, calculate the next Fibonacci number
      
          ; Program ends here
      
SUM       .byte $00
X         .byte $00
Y         .byte $00
TEMP      .byte $00
LIMIT     .byte 21     ; Limit for Fibonacci numbers (change as needed)
          
          .end
