
; Factorial Calculation Using Recursion
; Input: Number stored in memory location 'number'
; Output: Factorial of the input number stored in memory location 'result'

    .text
    
    .org $0200
    
    ; Entry point of the program
    start:
        LDA #6          ; Load the input number (change as needed)
        STA number      ; Store the input number in 'number' memory location
        
        JSR factorial   ; Call the factorial function
        
        LDA result      ; Load the result
        ; Display the result here (store in memory location, print to screen, etc.)
        
        JMP $FFFC       ; End of program
    
    ; Factorial function
    factorial:
        JSR push        ; Save current state on stack
        
        LDA number      ; Load number
        BNE continue    ; If number is not zero, continue with recursion
        
        LDA #1          ; If number is zero, return 1 as factorial
        JMP done        ; End recursive call
        
    continue:
        DEC number      ; Decrement number
        JSR factorial   ; Recursive call
        
        TAX             ; Save return value on stack
        JSR pop         ; Restore previous state from stack
        
        ; Calculate factorial and store in 'result'
        LDA number
        CLC
        ADC result
        STA result
        
    done:
        RTS
    
    ; Stack operations
    push:
        PHA
        TXA
        PHA
        RTS
        
    pop:
        PLA
        TAX
        PLA
        RTS
    
    ; Data storage
    .org $0260
    number: .byte 0     ; Input number
    result: .byte 0     ; Factorial result
    
    .org $02FF
