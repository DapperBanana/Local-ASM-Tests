
        .org $0200      ; Start address

LIST    .byte $02, $05, $09, $0A, $0F, $07, $03    ; List of elements
SUM     .byte $00        ; Sum of elements

        LDX #$00         ; Initialize index to 0
LOOP    LDA LIST, X     ; Load element from list
        CLC             ; Clear carry flag
        ADC SUM         ; Add element to sum
        STA SUM         ; Store sum
        INX             ; Increment index
        CPX #7          ; Check if end of list
        BNE LOOP        ; If not, continue looping

        BRK             ; End program
