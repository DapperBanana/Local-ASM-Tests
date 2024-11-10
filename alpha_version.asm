
        .org $0200

        LDX #0          ; Initialize index to 0
LOOP    LDA LIST, X    ; Load element at current index
        STA TEMP        ; Store element in temporary register
        JSR SQUARE      ; Call subroutine to calculate square
        STA RESULT, X   ; Store result in the result list
        INX             ; Increment index
        CPX #LENGTH     ; Compare index to length of list
        BNE LOOP        ; Loop until end of list
        BRK             ; Halt program

SQUARE
        LDA TEMP        ; Load element from temporary register
        STA ACC         ; Copy element to accumulator
        CLC             ; Clear carry flag
        ADC TEMP        ; Add element to accumulator
        STA ACC         ; Store result in accumulator
        RTS

LIST    .byte 1, 2, 3, 4, 5    ; List of elements to square
RESULT  .byte 5              ; Result list, initially empty
TEMP    .byte 0              ; Temporary register
ACC     .byte 0              ; Accumulator
LENGTH  .byte 5              ; Length of list
