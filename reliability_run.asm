
; Prime number calculation program

    .org $0600
    .org $0FFC
    .dw start
    .dw $0000
    
start:
    ; Initialize variables
    lda #START
    sta start
    lda #END
    sta end
    ldx #0
    ldy #0

check_next_number:
    ; Check if number is prime
    lda start
    jsr is_prime
    beq is_not_prime
    
    ; Add prime number to sum
    clc
    adc start
    sta sum
    
is_not_prime:
    ; Increment number
    lda start
    clc
    adc #1
    sta start
    
    ; Check if reached end of range
    cmp end
    beq end_of_range
    
    ; Repeat for next number
    jmp check_next_number

is_prime:
    ; Check if number is prime
    cpx #2
    beq is_prime_exit
    
    cpx #1
    beq is_prime_exit
    
    cpx #0
    beq is_prime_exit
    
    lda #$FF
    
loop:
    inx
    lsr
    bcc end_of_loop
    dec
    jmp loop
    
end_of_loop:
    dex
    bne loop
    sec
    lda #$00
    
is_prime_exit:
    rts

end_of_range:
    ; End of range, output sum
    lda sum
    ; Output sum here
    
    ; End program
    rts
    
START:    .db 1
END:      .db 10
SUM:      .db 0
