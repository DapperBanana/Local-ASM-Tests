
    .org $2000

start:
    ; Initialize variables
    LDX #0          ; Initialize X to index the string from left to right
    LDY #0          ; Initialize Y to index the string from right to left

get_input:
    ; Read input string from memory
    LDA input_string,X
    CMP #0         ; Check for null terminator
    BEQ check_palindrome
    INX
    BNE get_input

check_palindrome:
    DEX             ; Move X back one step
    CMP Y           ; Compare characters from both ends of the string
    BNE not_palindrome
    INX             ; Move X ahead one step
    DEY             ; Move Y back one step
    CPX Y           ; Compare the indexes of X and Y
    BCC get_input   ; Continue checking if X is less than Y

is_palindrome:
    ; Print message that the string is a palindrome
    LDX #0          ; Load index for printing message
print_message:
    LDA palindrome_message,X
    CMP #0          ; Check for null terminator
    BEQ end_program
    JSR $ffd2       ; Print character
    INX
    JMP print_message

not_palindrome:
    ; Print message that the string is not palindrome
    LDX #0          ; Load index for printing message
print_not_palindrome:
    LDA not_palindrome_message,X
    CMP #0          ; Check for null terminator
    BEQ end_program
    JSR $ffd2       ; Print character
    INX
    JMP print_not_palindrome

end_program:
    RTS

input_string:   .asciiz "A man a plan a canal Panama"
palindrome_message:  .asciiz "The string is a palindrome"
not_palindrome_message:  .asciiz "The string is not a palindrome"
