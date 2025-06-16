
    LDA #5         ; Load the number whose factorial needs to be calculated
    STA number

    LDX #1         ; Initialize the product to 1
    STX product

loop:
    LDA number     ; Load the current number
    CMP #0         ; Check if it is 0
    BEQ done       ; If so, we are done

    JSR multiply   ; Call subroutine to multiply X with current number
    DEX            ; Decrement X
    STA product     ; Store the result in product
    DEC number     ; Decrement the number
    
    JMP loop       ; Repeat the loop

multiply:
    LDY product     ; Load the product
    CLC             ; Clear the carry bit
    ADC number      ; Add the current number to Y
    STY product     ; Store the result back in Y
    RTS

done:
    BRK            ; Break and terminate the program
number:
    .BYTE  0
product:
    .BYTE  0
