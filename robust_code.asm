
    .org $0200        ; Start address for the program

start:
    LDX #10          ; Number of integers in the list
loop:
    LDA numbers,X    ; Load the current number
    STA temp         ; Store it in a temporary location

inner_loop:
    DEX              ; Decrement X register
    BEQ next         ; If X is 0, go to next iteration

    LDA numbers,X    ; Load the number before the current one
    CMP temp         ; Compare it with the current number
    BCC no_swap      ; If the previous number is smaller, don't swap

    STA numbers+1,X  ; Swap the numbers
    STA numbers,X
    STA temp         ; Store the previous number in temp

no_swap:
    JMP inner_loop   ; Continue inner loop

next:
    INX              ; Increment X to point to the next integer
    DEX              ; Move back to the current integer
    DEX              ; Move back one more to adjust for the increment
    BNE loop         ; If X is not 0, go back to the loop

    BRK              ; End the program

    .org $0300        ; Start address for the data

numbers:
    .byte $0F, $09, $07, $0B, $02, $05, $03, $08, $04, $0A
temp:
    .byte $00

