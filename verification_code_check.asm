
START:
    LDX #NUM_ELEMENTS        ; Load the number of elements in the list
    SEC                      ; Set carry to perform division
    LDA #0                   ; Initialize sum to zero
    STA SUM
SUM_LOOP:
    LDA NUMBERS, X           ; Load the number at the current index
    CLC                      ; Clear carry before adding
    ADC SUM                  ; Add the number to the sum
    STA SUM                  ; Store the updated sum
    DEX                      ; Decrement X to move to the next number
    BNE SUM_LOOP             ; Branch if X is not zero to process next number
    
    LDX #NUM_ELEMENTS        ; Reload number of elements
    LSR                      ; Divide sum by 2 to find the midpoint
    ROR
    STA MIDPOINT
    LDA SUM                  ; Load the sum
    CMP MIDPOINT             ; Compare with midpoint
    BCS MEDIAN               ; Branch if carry set, indicating the sum is greater   
    LDY MIDPOINT             ; Load the midpoint
    LDA NUMBERS, Y           ; Load the number at the midpoint
    STA MEDIAN               ; Store it as the median
    JMP END

MEDIAN:
    LDX #0                   ; Load index for comparisons
    LDA #0                   ; Initialize count to zero
COUNT_LOOP:
    LDA NUMBERS, X           ; Load the number at the current index
    CMP MEDIAN               ; Compare with the median
    BEQ INCREMENT            ; Branch if equal to median
    INX                      ; Increment index
    BNE COUNT_LOOP           ; Branch if X is not zero to continue counting
INCREMENT:
    INC COUNT                ; Increment count
    INX                      ; Move to the next number
    CPX NUM_ELEMENTS         ; Compare with number of elements
    BNE COUNT_LOOP           ; Branch if X is not equal to number of elements
    LSR                      ; Divide count by 2 to find the midpoint
    ROR
    LDX #0                   ; Reset index
FIND_MEDIAN:
    LDA NUMBERS, X           ; Load the number at the current index
    CMP MEDIAN               ; Compare with the median
    BEQ UPDATE_MEDIAN        ; Branch if equal to median
    INX                      ; Move to the next number
    BNE FIND_MEDIAN          ; Branch if X is not zero to continue searching
UPDATE_MEDIAN:
    STA MEDIAN               ; Store the new median
    
END:
    ; Your code here
    
    NUMBERS:
    .byte 10, 15, 20, 25, 30 ; List of numbers
    NUM_ELEMENTS = * - NUMBERS
    SUM: .byte 0
    MIDPOINT: .byte 0
    MEDIAN: .byte 0
    COUNT: .byte 0

    JMP START
