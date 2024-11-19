
    .org $0200

buffer .ds 3
result .ds 3

start
    lda #$00         ; Clear accumulator
    sta result       ; Clear result (decimal number)

    ldx #$02         ; Set index X to 2 (buffer index)
    
    loop
 
    lda buffer,x     ; Load the current digit from the buffer
    cmp #$30         ; Compare with ASCII code for '0'
    beq skip_digit   ; If the digit is '0' skip digit processing

    lda result       ; Load the current result
    asl              ; Shift left to make room for the new digit
    adc #$00         ; Clear carry
    adc buffer,x     ; Add the new digit
    sta result       ; Store the new result

skip_digit
    dex              ; Decrement index X
    dex              ; Decrement index X again

    cpx #$00         ; Check if we have processed all digits
    bne loop         ; If not, loop

    ; Your code to output the decimal result here
    
    rts              ; Return from subroutine

    .end
