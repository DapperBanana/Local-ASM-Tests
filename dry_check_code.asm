
    .org $0200

start:
    lda #0      ; Initialize sum to 0
    sta sum
    
    lda number  ; Load the number into the accumulator
    ldx #0      ; Initialize index to 0
    
calculate_digit:
    lsr         ; Shift the number to the right to isolate the least significant digit
    bcc skip_increment   ; If carry flag is not set, skip the increment instruction
    inx         ; Increment index
    clc
    adc sum     ; Add the isolated digit to the sum
    sta sum     ; Store the updated sum
skip_increment:
    cpx #4      ; Check if all digits have been processed
    bne calculate_digit   ; If not, repeat the process
    
    ; The sum of digits is now stored in the 'sum' variable
    
    ; Your code here
    
number:
    .byte $F2    ; This is the number whose digits need to be summed
    
sum:
    .byte 0      ; This variable will store the sum of digits
    
    .end
