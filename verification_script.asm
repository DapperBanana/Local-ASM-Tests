
; Fibonacci sequence calculator using memoization in 6502 Assembly language
; Input: The desired term 'n' should be stored in memory location 'n'
; Output: The nth Fibonacci term will be stored in memory location 'result'

ORG $0200 ; Start of the program

start:
    LDA #0        ; Initialize the counter of calculated Fibonacci terms
    STA counter
    LDA #0        ; Initialize the first term of Fibonacci sequence
    STA result
    LDA #1        ; Initialize the second term of Fibonacci sequence
    STA result+1

loop:
    LDA $n        ; Load the value of 'n' into A register
    CMP #0        ; Compare it with 0
    BEQ done      ; If 'n' is 0, then we are done
    
    LDA counter   ; Load the current counter value
    SEC           ; Set carry flag for BCD math
    SBC $n        ; Subtract 'n' from counter
    BEQ calculate ; If 'n' matches the counter value, calculate the next term
    
    JSR nextTerm  ; Otherwise, calculate the next term
    BRA loop      ; Go back to check if the term has been calculated

calculate:
    LDA result+1  ; Load the current calculated value (n-1) into A register
    CLC           ; Clear carry flag
    ADC result    ; Add the value of (n-2) to A register
    STA temp      ; Store the sum in temp memory
    LDA result+1  ; Load the result+1 into A register
    STA result    ; Move the result+1 to result
    LDA temp      ; Load the temp memory into A register
    STA result+1  ; Store the sum in result+1
    INC counter   ; Increment the counter
    BRA loop      ; Return to the loop

nextTerm:
    LDA result    ; Load result into A register
    SEC           ; Set carry flag for BCD math
    SBC result+1  ; Subtract result+1 from A register
    STA temp      ; Store the difference in temp memory
    LDA result+1  ; Load result+1 into A register
    STA result    ; Store result+1 in result
    LDA temp      ; Load the temp memory into A register
    ADC result    ; Add the temp sum with result
    STA result+1  ; Store the new sum in result+1
    INC counter   ; Increment the counter
    RTS           ; Return to the calling routine

done:
    BRK           ; Terminate the program

n: .BYTE 10      ; Store the desired term 'n' here
counter: .BYTE 0 ; Counter for tracking the Fibonacci terms
result: .WORD 0  ; Store the calculated Fibonacci term here
temp: .WORD 0    ; Temporary storage for calculations

END           ; End of the program
