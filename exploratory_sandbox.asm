
; 6502 Assembly program to calculate the median of a list of numbers

ORG $0200

LDA #10          ; Set the number of elements in the list
STA numElements

LDX #00          ; Initialize the index to 0
LDY #00          ; Initialize the sum to 0

loop:
    LDA list, X   ; Load the current element from the list
    CLC
    ADC sum, Y    ; Add the current element to the sum
    STA sum, Y    ; Store the updated sum
    INX           ; Increment the index
    CPX numElements ; Compare the index with the number of elements
    BNE loop      ; If not equal, loop back

    LDA sum, Y    ; Load the sum
    STA result     ; Store the sum in the result

    LDA numElements
    ASL           ; Multiply the number of elements by 2
    STA numElements
    LDX numElements
    LSR           ; Divide the multiply result by 2

    STX medianIndex  ; Store the median index

getMedian:
    DEC medianIndex ; Decrement the median index
    CPX #$00         ; Check if the median index has reached 0
    BEQ done        ; If zero, exit loop

    LDA list, X     ; Load the element at median index
    STA median, Y    ; Store the element in the median list
    INY             ; Increment the index for the median list
    BNE getMedian  ; Loop back

done:
    BRK            ; Break execution

numElements:     .BYTE 0
sum:             .BYTE 0
result:          .BYTE 0
medianIndex:     .BYTE 0

list:            .BYTE 3, 5, 7, 9, 1, 4, 6, 8, 2

END
