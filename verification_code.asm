
; Program to calculate the square of each element in a list using 6502 assembly language.

    .org $0200        ; Start address of program
    .memory $0200,$02FF    ; Define memory range for variables
    ; Define variables
list    .byte $02, $04, $06, $08, $0A             ; List of numbers
result  .byte $00, $00, $00, $00, $00            ; List to store square of each number

    LDX #0              ; Initialize index register X to 0
loop    LDA list, X        ; Load element from list
    STA $00           ; Store the element in memory location $00
    ASL $00           ; Multiply the element by itself (square)
    STA result, X      ; Store the result in result list
    INX               ; Increment index register
    CPX #5            ; Check if end of list reached
    BNE loop          ; If not, repeat loop
    BRK               ; End of program

    .end
