
; Program to find the median of a list of numbers
    .org $0200

start:
    LDA #10                 ; Number of elements in list
    STA count

    LDX #0                  ; Initialize index
    LDA #0                  ; Initialize sum
    STA sum

loop:
    LDA numbers, X          ; Load number at index X
    CLC
    ADC sum                 ; Add number to sum
    STA sum

    INX
    CPX count               ; Check if end of list
    BNE loop

    LDA #0                  ; Initialize median
    STA median

    LDX #0                  ; Initialize index
    LDA count
    ASL                     ; Multiply by 2
    CLC
    ADC #1                  ; Add 1
    TAX
    LDA sum
    STA temp

divide:
    LDA temp
    SEC
    SBC numbers, X          ; Subtract number at index X
    BCS greater
    DEC temp
    JMP divide

greater:
    DEX
    CPX median              ; Check if median reached
    BNE greater

    STX median

    ; Median value is now stored in the 'median' variable
    ; Additional code can be added to display the median value or store it in memory

    BRK

numbers:
    .byte 2, 5, 3, 7, 8, 1, 6, 4, 9, 10

count:
    .byte 0

sum:
    .word 0

median:
    .byte 0

temp:
    .byte 0
