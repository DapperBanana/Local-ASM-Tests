
        lda #10            ; lower range limit
        sta range_low
        lda #50            ; upper range limit
        sta range_high
        
        lda #0             ; initialize sum to 0
        sta sum
        
loop    iny                ; increment current number
        cpy range_high     ; check if current number is within range
        bcc check_prime
        
        lda sum            ; output sum
        ldx sum + 1
        jsr output_sum
        
        rts
        
check_prime
        cmp #2            ; check if current number is 2
        beq prime_found
        
        cpx #2            ; check if current number is 3
        beq prime_found
        
        lda #2            ; initialize divisor to 2
        sta divisor
        
next_divisor
        lda divisor       ; check if divisor is equal to current number
        cmp iny
        beq prime_found
        
        lda iny           ; check if current number is divisible by divisor
        lsr
        lsr
        cmp divisor
        beq not_prime
        
        inc divisor       ; increment divisor
        jmp next_divisor
        
prime_found
        lda iny           ; add prime number to sum
        clc
        adc sum
        sta sum
        lda #0
        adc sum+1
        sta sum+1
        
not_prime
        jmp loop
        
output_sum
        ; code to output sum goes here
        
range_low    .byte 0
range_high   .byte 0
sum          .word 0
divisor      .byte 0
