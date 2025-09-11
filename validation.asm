
        .text
        .globl _start

_start:
        ; Load the number to check into register A (assuming it is stored in memory location 0x1000)
        LDA $1000
        
        ; Initialize variables
        LDX #0        ; Initialize sum of narcissistic number digits to zero
        LDY #0        ; Initialize loop counter to zero
        LDZ #0        ; Initialize temporary variable for calculating narcissistic number to zero

check_loop:
        ; Check if loop counter is greater than zero
        CPY #0
        BEQ sum_digits
        
        ; Multiply temporary variable by the original number
        ASL
        ASL
        ASL
        ASL
        CLC
        ADC $1000
        
        ; Increment loop counter
        INY
        
        ; Check if loop counter is less than 3
        CPY #3
        BNE check_loop
        
sum_digits:
        ; Split the number into individual digits and calculate sum of narcissistic number digits
        LDX #3        ; Initialize loop counter to 3
        
digit_loop:
        ; Extract least significant digit
        LSR
        TAX
        
        ; Calculate the sum of narcissistic number digits
        CLC
        ADC $1000
        STX $1001
        BCC next_digit
        
        INC $1001
        
next_digit:
        DEX
        BNE digit_loop
        
        ; Compare the sum of narcissistic number digits with the original number
        LDA $1001
        CMP $1000
        BEQ is_narcissistic
        
not_narcissistic:
        ; Print result (0 = not narcissistic number)
        LDA #0
        STA $1002
        
        ; End program
        BRK
        
is_narcissistic:
        ; Print result (1 = narcissistic number)
        LDA #1
        STA $1002
        
        ; End program
        BRK
