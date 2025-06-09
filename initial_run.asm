
ORG $0200

LDX #$00    ; Set X to 0 (initialize counter)
LDY #$00    ; Set Y to 0 (initialize index for number comparison)
LDZ #$00    ; Set Z to 0 (initialize index for reversed number)
LDA number ; Load the input number into accumulator A

reverse_loop:
    STA input_num, Y ; Store the number in the input_num array
    INY             ; Increment Y
    INX             ; Increment X
    LSR             ; Shift right the number for comparison
    BNE reverse_loop

    LDX #$00        ; Reset X to 0
    DEC Y           ; Decrement Y to get the last index of the input number

compare_loop:
    LDA input_num, X ; Load the number from input_num array
    CMP input_num, Y ; Compare the number with its reversed form
    BNE not_palindrome
    INX             ; Increment X
    DEY             ; Decrement Y
    CPX Y           ; Compare X with Y
    BCC compare_loop

    LDA #$01        ; Set A to 1 (number is a palindrome)
    JMP end_program

not_palindrome:
    LDA #$00        ; Set A to 0 (number is not a palindrome)

end_program:
    STA result      ; Store the result in the result variable

    BRK

number: .BYTE $A3 ; Input number (replace $A3 with any number to test)

input_num: .BYTE $00, $00, $00, $00 ; Array to store the input number
result: .BYTE $00 ; Variable to store the result

ORG $FFFA
    .WORD $0200
