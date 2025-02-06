
    .org $0200
    
    ldx #0        ; Initialize index register X to 0
    lda #0        ; Initialize accumulator to 0
loop:
    lda data,x   ; Load value at index X into accumulator
    clc          ; Clear carry flag
    adc acc       ; Add value to accumulator
    sta acc       ; Store result back in accumulator
    inx          ; Increment index
    cpx #length  ; Compare index to length of the list
    bne loop     ; If not at the end of the list, repeat loop
    
    ; At this point, the sum of all elements in the list is stored in the accumulator
    
    ; Your code here to use or display the sum
    
data:
    .byte $01, $02, $03, $04, $05   ; List of elements to sum
length:
    .byte 5                        ; Length of the list

    .end
