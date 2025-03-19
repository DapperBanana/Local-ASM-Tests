
; Program to calculate the average of elements in a list using 6502 assembly language

    .org $0200        ; Start program at address 0200
    
    lda #9            ; Load the number of elements in the list (for example, 9 elements)
    sta numElements
    
    ldx #0            ; Initialize sum to zero
    lda #0            ; Initialize index to zero
    
loop:
    cmp numElements   ; Compare index with number of elements
    beq end          ; If index == number of elements, end loop
    
    lda data, x       ; Load element from data array
    clc               ; Clear carry flag
    adc sum           ; Add element to sum
    sta sum           ; Store sum
    
    inx               ; Increment index
    bne loop          ; Branch back to loop
    
end:
    lda numElements   ; Load number of elements
    clc               ; Clear carry flag
    adc #0            ; Add carry flag (to ensure division by total number of elements)
    sta numElements   ; Store new total number of elements
    
    ora #0            ; Clear A register
    lda sum           ; Load sum
    div numElements   ; Divide sum by total number of elements (averaging)
    
    sta average       ; Store average
    
    jmp $FFFA        ; End program
    
data:
    .byte $01, $02, $03, $04, $05, $06, $07, $08, $09   ; Example list of elements
    
numElements:
    .byte 0           ; Number of elements
sum:
    .byte 0           ; Sum of elements
average:
    .byte 0           ; Average of elements
