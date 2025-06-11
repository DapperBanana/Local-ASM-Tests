
; Program to convert temperature from Celsius to Fahrenheit

    .org $1000
    
start
    LDX #0          ; Initialize index register
    LDY #5          ; Initialize counter
    LDA celsius,X   ; Load Celsius temperature from memory
    STA fahrenheit,X ; Store Fahrenheit temperature in memory
    INX             ; Increment index register
    DEY             ; Decrement counter
    BNE start       ; Branch back to start if counter is not zero
    BRK             ; End program

celsius
    .byte 0        ; Celsius temperature stored in memory
fahrenheit
    .byte 0        ; Fahrenheit temperature stored in memory
