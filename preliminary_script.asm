
; Program to find the sum of all elements in a list

    .org $0200

start:
    LDA #$00        ; Initialize sum to 0
    STA sum
    LDX #$00        ; Initialize index to 0

loop:
    LDA list,X      ; Load element from list
    CLC
    ADC sum         ; Add element to sum
    STA sum
    INX             ; Increment index
    CPX #len        ; Check if reached end of the list
    BNE loop        ; Loop until end of list

done:
    ; The sum is now stored in the 'sum' variable

    ; End of program
    NOP
    BRK

    .org $FFFA
    ; NMI and Reset vectors
    .word  start
    .word  start

    ; Data
    .org $0300
list:   .byte $05, $0A, $15, $20, $25   ; List of elements
len:    .byte 5                           ; Length of the list

    .org $0320
sum:    .byte $00                          ; Variable to store sum
