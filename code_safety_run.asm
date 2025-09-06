
        .org $0200          ; Start program at memory address $0200

        LDX #5              ; Number of elements in list
        LDY #0              ; Initialize sum to zero
        STX COUNT           ; Store the count in memory
        STY SUM             ; Store the sum in memory

LOOP    LDA LIST, X         ; Load element at index X
        CLC
        ADC SUM             ; Add element to sum
        STA SUM             ; Store the updated sum
        DEX                 ; Decrement X
        BNE LOOP            ; Loop until X is zero

        LDA SUM             ; Load the sum
        SEC
        SBC COUNT           ; Subtract the count (to exclude it from the sum)
        LSR                 ; Calculate average by dividing by the count
        STA AVERAGE         ; Store the average
        
        BRK                 ; End program

COUNT   .byte 0             ; Memory location to store count
SUM     .byte 0             ; Memory location to store sum
AVERAGE .byte 0             ; Memory location to store average
LIST    .byte $01, $02, $03, $04, $05    ; List of elements

        .end
