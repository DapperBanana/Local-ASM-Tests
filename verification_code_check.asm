
 ; Fibonacci sequence generator up to X terms

    LDX #10      ; Change this value to generate Fibonacci sequence up to a different number of terms

    LDA #0       ; Initiate first Fibonacci number
    STA $00
    LDA #1       ; Initiate second Fibonacci number
    STA $01

loop:
    LDA $00      ; Load first Fibonacci number
    CLC
    ADC $01      ; Add second Fibonacci number
    STA $02      ; Store the sum as the next Fibonacci number

    LDA $01      ; Move the second Fibonacci number to the first position
    STA $00

    LDA $02      ; Move the sum to the second position
    STA $01

    JSR print   ; Print the current Fibonacci number

    DEX          ; Decrement X (number of terms)
    BNE loop     ; Loop until X becomes 0

    BRK          ; Exit

print:
    ; Print the current Fibonacci number
    LDA $00
    STA $D020    ; Display number on screen
    
    LDA $01
    STA $D021

    LDA #$00     ; Print newline character
    STA $D021

    RTS
