
    .org $0200
    
    ; Input values
baseArea    .byte   $10     ; Base area of the pyramid
height      .byte   $05     ; Height of the pyramid
    
    ; Variables
result      .word   0       ; Result of the calculation
    
    ; Code
    lda     baseArea        ; Load base area into accumulator
    sta     result+1        ; Store it in the high byte of result
    ldx     #0              ; Load accumulator with 0
    ldy     #$02            ; Load Y with the exponent 2
    
loop:
    lda     baseArea        ; Load base area into accumulator
    clc                     ; Clear carry flag
    adc     result+0        ; Add it to the low byte of result
    sta     result+0        ; Store the result back
    lda     baseArea        ; Load base area into accumulator
    adc     result+1        ; Add it to the high byte of result
    sta     result+1        ; Store the result back
    dex                     ; Decrement X
    bne     loop            ; Branch back to loop if X is not zero
    
    lda     result+0        ; Load low byte of the result
    sta     $FFF0           ; Store it in memory location $FFF0
    lda     result+1        ; Load high byte of the result
    sta     $FFF1           ; Store it in memory location $FFF1
    
    ; Halt
    lda     #1
    jmp     *
