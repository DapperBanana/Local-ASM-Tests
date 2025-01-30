
    LDX #0       ; Initialize index for looping through list
    LDY #0       ; Initialize sum of elements
    LDA #10      ; Initialize number of elements in list
    STA counter  ; Store the number of elements in the counter variable

loop:
    LDA num_list, X  ; Load element from list
    CLC             ; Clear carry flag
    ADC sum         ; Add element to sum
    STA sum         ; Store new sum
    INX             ; Increment index
    CPX counter     ; Compare index with number of elements
    BNE loop        ; If not done, go to next element

    LDA sum         ; Load sum
    CMP #$00        ; Check if sum is 0
    BEQ end         ; If sum is 0, division by 0 is not allowed

    LDA counter     ; Load number of elements
    CLC             ; Clear carry flag
    ADC #0          ; Add 0 to avoid overflow
    LSR             ; Divide by 2 (to calculate average)
    STA result      ; Store the average

end:
    BRK             ; End program

num_list:   .byte 5, 7, 3, 9, 4, 6, 8, 2, 10, 1
sum:        .byte $00
result:     .byte $00
counter:    .byte $00
