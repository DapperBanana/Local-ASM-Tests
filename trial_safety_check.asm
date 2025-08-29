
        .org $1000

        LDA #$00                    ; Initialize accumulator
        STA arraySum                ; Initialize sum of numbers
        LDA #$00                    ; Initialize counter
        STA count                   ; Initialize count of numbers

readLoop
        LDA #$00                    ; Initialize digit read
        LDA (filePointer),Y         ; Read data from file
        CMP #$2C                   ; Check if comma delimiter
        BEQ updateSum              ; If comma, update sum
        CMP #$0A                    ; Check if end of line
        BEQ endProgram              ; If end of line, end program
        CLC                         ; Clear carry flag
        ADC #$30                    ; Convert ASCII to number
        STA temp                    ; Store temporary digit
        LDA arraySum                ; Load sum of numbers
        CLC                         ; Clear carry flag
        ADC temp                    ; Add digit to sum
        STA arraySum                ; Update sum of numbers
        INC count                   ; Increment count of numbers
        BCC readLoop                ; Repeat loop

updateSum
        LDA #$00                    ; Clear temporary register
        STA temp

endProgram
        BRK

arraySum    .byte $00            ; Memory location for sum of numbers
count       .byte $00            ; Memory location for count of numbers
filePointer .byte $2000
temp        .byte $00

        .org $2000                  ; Start of data section

        .incbin "data.csv"         ; Include CSV file
