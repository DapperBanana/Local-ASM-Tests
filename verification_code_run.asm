
        .org $0200

start   LDX #10                  ; Set the limit to 10 terms
        LDA #0                   ; First Fibonacci number is 0
        STA $00                  ; Store it at memory location $00
        LDA #1                   ; Second Fibonacci number is 1
        STA $01                  ; Store it at memory location $01
        LDA #0                   ; Initialize index
        STA $02                  ; Store it at memory location $02

generate
        LDA $00                  ; Load the current Fibonacci number
        CLC                       ; Clear carry flag
        ADC $01                  ; Add the previous Fibonacci number
        STA $03                  ; Store the new Fibonacci number
        LDA $01                  ; Load the previous Fibonacci number
        STA $00                  ; Move it to the current Fibonacci number
        LDA $03                  ; Load the new Fibonacci number
        STA $01                  ; Move it to the previous Fibonacci number
        INX                       ; Increment index
        CPX #10                   ; Check if limit is reached
        BEQ end                   ; If limit is reached, end program
        BRA generate              ; Otherwise, continue generating Fibonacci numbers

end     BRK                       ; End of program

        .end
