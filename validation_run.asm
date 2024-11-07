
        .org $0200
start:
        LDA #0      ; Initialize counter to 0
        STA counter
        LDA #2      ; Load the number to check in the accumulator
        STA number
        LDA #0      ; Initialize isPrime flag to 0
        STA isPrime

loop:
        LDA number  ; Load the number to check in the accumulator
        CMP counter ; Compare the number with the counter
        BEQ endLoop ; If the counter equals the number, exit the loop

        LDA counter ; Load the counter in the accumulator
        CLC         ; Clear carry flag
        ADC #1      ; Increment the counter
        STA counter ; Store the new value of the counter

        LDA number  ; Reload the number to check in the accumulator
        SEC         ; Set the carry flag
        SBC counter ; Subtract the counter from the number
        BCC notDivisible ; If the counter divides the number, it's not prime
        JMP loop    ; Otherwise continue looping

notDivisible:
        LDA #1      ; Set the isPrime flag to 1
        STA isPrime
        JMP endLoop ; Exit the loop

endLoop:
        LDA isPrime ; Check the isPrime flag
        BEQ notPrime ; If the flag is 0, the number is not prime
        
        ; Put code here to handle printing or storing the result that the number is a prime number
        ; (e.g., LDA #primeMessage, JSR printString)
        
notPrime:
        ; Put code here to handle printing or storing the result that the number is not a prime number
        ; (e.g., LDA #notPrimeMessage, JSR printString)

        BRK         ; End of program

number: .byte 0
counter: .byte 0
isPrime: .byte 0

primeMessage: .byte "The number is prime", $0D, $0A, $00
notPrimeMessage: .byte "The number is not prime", $0D, $0A, $00

        .end
