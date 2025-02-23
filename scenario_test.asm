
        .org $0200       ; define start address

number  .byte $65       ; replace $65 with the number you want to check for palindrome
len     = 1             ; length of number
is_pal  = $ff          ; 1 if palindrome, 0 otherwise

        LDX #0
        STX index

        LDA #len
        STA end_index
        DEC end_index

check_digit:
        LDA number,X
        STA temp1

        LDX end_index
        LDA number,X
        STA temp2

        CMP temp1
        BEQ equal
        LDA #0
        STA is_pal
        JMP end_prog

equal:
        INX
        DEX
        CPX index
        BCC check_digit

end_prog:
        BRK

index   .byte 0
temp1   .byte 0
temp2   .byte 0
end_index .byte 0
