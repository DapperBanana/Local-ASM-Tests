
    .text
    .org $0200

start:

    ; Initialize variables
    LDA #5      ; Load the number for which we want to calculate the factorial (e.g. 5)
    STA number  ; Store the number in memory
    LDA #1
    STA result  ; Initialize the result to 1

    ; Calculate the factorial
    LDA number   ; Load the number
loop:
    BEQ done     ; If the number is zero, we are done
    JSR multiply ; Otherwise multiply the result by the number
    DEC number   ; Decrement the number
    JMP loop     ; Repeat the loop

done:
    ; Print the result
    LDA result
    ; Add code here to print the result

    ; End of program
    BRK
    
multiply:
    LDA result
    CLC
    ADC number
    STA result
    RTS
    
    .data
number: .byte 0
result: .byte 0
