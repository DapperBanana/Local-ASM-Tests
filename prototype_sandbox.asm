
; Convert a number to Roman numeral

    .text

num_to_roman:
    LDX #0          ; Initialize index for Roman numeral array
loop:
    LDA num         ; Load the number to be converted
    CMP roman_vals,X ; Compare with the current value in Roman numeral array
    BCC next        ; Branch to the next value if the number is smaller
    STA num         ; Store the remaining number for next iteration
    LDA roman_nums,X ; Load the Roman numeral character
    JSR print_char  ; Print the Roman numeral character
    JMP loop        ; Repeat the loop
next:
    INX             ; Increment index for Roman numeral array
    CPX #13         ; Check if all Roman numerals have been processed
    BEQ done        ; If yes, exit the loop
    JMP loop        ; Otherwise, repeat the loop
done:
    RTS             ; Return from subroutine

    .data
num: .byte 128      ; Number to be converted

roman_vals:
    .byte 100, 90, 50, 40, 10, 9, 5, 4, 1
roman_nums:
    .byte 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'
