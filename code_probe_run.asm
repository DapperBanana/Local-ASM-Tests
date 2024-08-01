
ORG $0600

LDX #0       ; Initialize X register for loop
LDA num1     ; Load num1 into accumulator
SEC          ; Set carry flag for subtraction
SBC num2     ; Subtract num2 from accumulator
CMP $00      ; Compare result with 0
BCC subtract ; If result is negative, jump to subtract
STA result   ; Store result in result variable
BRK          ; Break and end program

subtract:
LDA num2     ; Load num2 into accumulator
SEC          ; Set carry flag for subtraction
SBC num1     ; Subtract num1 from accumulator
CMP $00      ; Compare result with 0
BCC subtract ; If result is negative, jump to subtract
STA result   ; Store result in result variable
BRK          ; Break and end program

num1: .BYTE 20 ; First number
num2: .BYTE 30 ; Second number
result: .BYTE 0 ; GCD result

.END
