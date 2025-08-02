
        .org $0200

start   lda #number       ; load the given number
        sta current       ; store it in current

next    inc current       ; increment the current number

        jsr is_prime      ; check if the current number is prime
        bne next          ; if not prime, try the next number

        lda current       ; load the smallest prime number
        jsr print_number  ; print the result

        rts

is_prime
        ldx #2            ; start with divisor 2
loop    cpx current       ; check if divisor is greater than current number
        beq is_prime_num  ; if equal, number is prime
        cpx #1            ; check if divisor is greater than 1
        beq is_prime_num  ; if equal, number is prime
        cpx #0            ; check if divisor is zero
        beq not_prime     ; if equal, number is not prime
        cpx #$ff          ; check if divisor is 255 (end of iterations)
        beq is_prime_num  ; if equal, number is prime
        lda current       ; load current number
        cmp #0            ; check if divisible by divisor
        beq not_prime     ; if equal, number is not prime
        ldx current       ; load current number
        dex               ; decrement divisor
        bne loop          ; repeat if not zero
        jmp is_prime

is_prime_num
        ldx #0            ; load 0 to indicate prime
        rts

not_prime
        ldx #1            ; load 1 to indicate not prime
        rts

print_number
        tax               ; transfer number to X register
        jsr print_digit   ; print the first digit
        lda #',            ; load the ASCII comma character
        jsr $ffcc         ; store character to the screen
        lda #$20          ; load the ASCII space character
        jsr $ffcc         ; store character to the screen
        lda x             ; load the number
        jsr print_digit   ; print the second digit
        rts

print_digit
        asl               ; multiply the number by 2
        tax               ; store the result in X register
        ldy $08           ; initialize counter
loop2   lda digit_table,y ; load the digit from the table
        ldx #$ff          ; load the cursor
        jsr $ffcc         ; store character to the screen
        dey               ; decrement counter
        bpl loop2         ; repeat until counter is negative
        rts

digit_table
        .byte '0','1','2','3','4','5','6','7','8','9'

number  .byte 42        ; the given number
current .byte 0         ; current number being checked
        .end
