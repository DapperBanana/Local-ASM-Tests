
; Load the number into the accumulator
    LDA #25       ; Example number to calculate the sum of digits for
    STA number

loop:
    ; Check if the number is a single digit
    CMP #10
    BCC done

    ; Initialize variables
    LDX #0        ; Counter for the sum of digits
    LDY #0        ; Accumulator for the sum
    
    ; Calculate the sum of digits
    LDA number
    CLC
    ADC #0         ; Clear carry flag
    STA temp       ; Store the number in temp
    x_loop:
        LSR
        BCC done_x  ; Check if all bits are shifted out
        ADC number
        INX
        JMP x_loop
    done_x:
    STY result     ; Store the sum of digits
    LDA temp
    STA number
    JMP loop
    
done:
    LDA result     ; Load the final sum of digits
    ; Store the result
    STA result
    ; Halt the program
    BRK

temp: .byte 0
number: .byte 0
result: .byte 0
