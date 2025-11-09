
        .text
        .globl _start
        
_start:
        ; Load the year to be checked into the A register
        LDA #$19    ; Load the first two digits of the year
        STA year
        LDA #$93    ; Load the last two digits of the year
        STA year + 1

        ; Reverse the digits of the year
        LDA year + 1
        STA temp
        LDA #0
        STA year + 1
        LDA temp
        STA year

        ; Test if the year is a palindrome
        LDA year
        CMP year + 1
        BEQ palindrome    ; If the year is a palindrome, jump to the palindrome label
        BRA not_palindrome    ; Otherwise, jump to the not_palindrome label

palindrome:
        ; Display message that the year is a palindrome
        LDA #12
        JSR $FFD2    ; Print "Year is a palindrome"
        BRK

not_palindrome:
        ; Display message that the year is not a palindrome
        LDA #13
        JSR $FFD2    ; Print "Year is not a palindrome"
        BRK

        .data
year:    .byte 0, 0
temp:    .byte 0
