
START    LDA #NUMBER      ; Load the number to find prime factors of
         STA CURRENT_NUM  ; Store the number in CURRENT_NUM
         LDA #2           ; Start checking from 2
         STA FACTOR        ; Store current factor in FACTOR
LOOP     LDA CURRENT_NUM  ; Load current number
         CMP #1           ; Compare with 1
         BEQ END          ; If number is equal to 1, end loop
         LDA FACTOR       ; Load current factor
         JSR DIVIDE       ; Check if number is divisible by factor
         BCC NEXT         ; If not divisible, go to next factor
         JSR PRINT        ; Print prime factor
         JSR DIVIDE       ; Divide number by prime factor
         JMP LOOP         ; Repeat loop
NEXT     LDA FACTOR       ; Load current factor
         CLC
         ADC #1           ; Increment factor by 1
         STA FACTOR       ; Update factor
         JMP LOOP         ; Repeat loop
END      BRK              ; End program

DIVIDE   SEC              ; Set carry flag
         LDA CURRENT_NUM  ; Load current number
         SBC FACTOR       ; Subtract factor
         BCC NOT_DIVISIBLE ; If result is negative, not divisible by factor
         RTS              ; Return if divisible
NOT_DIVISIBLE
         CLC              ; Clear carry flag
         RTS              ; Return

PRINT    LDA FACTOR       ; Load current factor
         STA $6000,X      ; Print factor to memory address $6000
         INX              ; Increment index
         RTS              ; Return

NUMBER   .BYTE 30         ; Number to find prime factors of
CURRENT_NUM .BYTE 0       ; Current number being checked
FACTOR   .BYTE 0          ; Current factor being checked
