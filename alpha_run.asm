
; Program to calculate the area of a trapezoid

    .org $0200                ; Start program at memory location $0200
    
; Variables
base1   .byte $00            ; Base 1 of the trapezoid
base2   .byte $00            ; Base 2 of the trapezoid
height  .byte $00            ; Height of the trapezoid
area    .word $0000          ; Area of the trapezoid

    .org $c000                ; Start program execution at memory location $c000
    
start:
    lda #base1               ; Load base 1 into accumulator
    sta $0000                ; Store base1 in memory location $0000
    
    lda #base2               ; Load base 2 into accumulator
    sta $0001                ; Store base2 in memory location $0001
    
    lda #height              ; Load height into accumulator
    sta $0002                ; Store height in memory location $0002
    
    lda $0000                ; Load base 1 from memory
    clc
    adc $0002                ; Add height to base1
    sta $0003                ; Store the sum in memory location $0003
    
    lda $0001                ; Load base 2 from memory
    clc
    adc $0003                ; Add the sum of base1 + height to base2
    sta $0004                ; Store the sum in memory location $0004
    
    lda $0003                ; Load the sum of base1 + height from memory
    lda $0004                ; Load the sum of base2 + base1 + height from memory
    clc
    adc $0004                ; Add the two base sums together
    asl                      ; Multiply the sum by 2
    sta area                 ; Store the area in memory location "area"
    
end:
    jmp end                  ; End program execution
    
    .end
