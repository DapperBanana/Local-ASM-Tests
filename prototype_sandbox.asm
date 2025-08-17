
        ORG $0200

        LDA #$0
        STA $10        ; Initialize index of largest element
        LDA #$80
        STA $11        ; Initialize largest element

Next:   INX             ; Increment index by 1
        LDA $2000,X     ; Load next element into accumulator
        CMP $11         ; Compare with current largest element
        BCC NotLargest  ; If element is smaller, skip update
        STA $11         ; Update largest element
        TXA
        STA $10         ; Update index of largest element

NotLargest:
        CPX #$09        ; Check if end of list is reached
        BEQ Done        ; If so, end program
        JMP Next        ; Otherwise, continue to next element

Done:   BRK             ; End program

        ORG $2000
Data:   .BYTE $0F, $07, $12, $05, $1A, $09, $04, $03, $1E, $0B
