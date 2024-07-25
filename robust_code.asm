
        .org $0200

start   LDX #0          ; Initialize index X to 0
        LDY #0          ; Initialize index Y to 0
        LDA number     ; Load the number to check into accumulator
        STA original   ; Store the original number for comparison later

        ; Calculate the number of digits in the input number
count   INX             ; Increment index X
        LSR             ; Shift the input number right by 1 bit
        BCC count       ; Repeat until the input number is 0

        DEX             ; Decrement index X to get the number of digits

check   CMP original,X  ; Compare the current digit with the corresponding digit from the end
        BNE not_palindrome ; If not equal, the number is not a palindrome
        INX             ; Increment index X
        DEY             ; Decrement index Y
        CPY #0          ; Check if all digits have been compared
        BEQ palindrome  ; If yes, the number is a palindrome
        JMP check       ; Repeat the comparison

not_palindrome
        LDA #0          ; Not a palindrome, store 0 in accumulator
        STA result      ; Store the result
        JMP end

palindrome
        LDA #1          ; Palindrome, store 1 in accumulator
        STA result      ; Store the result

end     BRK

number  .byte $21       ; Input number to check
original .byte 0        ; Original input number (for comparison)
result  .byte 0         ; Result: 1 if palindrome, 0 if not

        .end
