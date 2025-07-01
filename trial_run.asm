
    ; Fibonacci sequence generator in 6502 Assembly
    
    .org $0200
    
start:
    ; Display message to enter number of terms
    LDX #<message
    LDY #>message
    JSR printString
    
    ; Read the input number of terms from the user
    JSR readNumber
    STA numTerms
    
    ; Initialize variables
    LDA #0
    STA prevValue      ; Previous Fibonacci number
    STA curValue       ; Current Fibonacci number
    STA count          ; Counter for number of terms generated
    
    ; Print the initial Fibonacci numbers
    LDA prevValue
    JSR printNumber
    LDA #","
    JSR printChar
    LDA curValue
    JSR printNumber
    
generateSequence:
    ; Calculate the next Fibonacci number
    CLC
    LDA curValue
    ADC prevValue
    STA nextValue
    
    ; Update variables for next iteration
    LDA curValue
    STA prevValue
    LDA nextValue
    STA curValue
    
    ; Print the next Fibonacci number
    LDA #","
    JSR printChar
    LDA curValue
    JSR printNumber
    
    ; Increment the counter
    INC count
    
    ; Check if we have reached the desired number of terms
    LDA numTerms
    CMP count
    BNE generateSequence
    
    ; End of program
    BRK
    
message:
    .text "Enter the number of terms: $00"
    
prevValue:
    .byte 0
curValue:
    .byte 0
nextValue:
    .byte 0
count:
    .byte 0
numTerms:
    .byte 0

include "io.asm"  ; Input/Output routines

    .end
