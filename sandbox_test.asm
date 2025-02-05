
.org $8000
start:
    LDA #5 ; Load the number for which factorial needs to be calculated
    STA number
    LDA #1 ; Initialize the result to 1
    STA result
    
loop:
    LDA number
    CMP #$01  ; Compare the number with 1
    BEQ end   ; If number is 1, end the loop
    DEC number  ; Decrement the number by 1
    LDA result  ; Load the current result
    PHA         ; Push the current result onto the stack
    JSR multiply ; Call multiply subroutine
    PLA         ; Pop the previous result from the stack
    STA result  ; Store the new result
    JMP loop    ; Repeat the loop
    
end:
    BRK

multiply:
    LDA number  ; Load the current number
    CLC
    ADC result  ; Add the current result to the number
    STA result
    RTS
    
number:
    .byte 0
result:
    .byte 0

.end start
