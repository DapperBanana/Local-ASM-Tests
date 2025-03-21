
start     ldx #$01              ; load x register with starting number
          lda #$00              ; load accumulator with 0
loop      jsr is_prime         ; check if number in x register is prime
          bne not_prime        ; branch if not prime
          clc                  ; clear carry flag
          adc x                ; add number in x register to accumulator
not_prime inx                   ; increment x register
          cpx #$0A             ; compare x register to end of range
          bne loop             ; branch to loop if not at end of range
          rts                   ; return from subroutine

is_prime  ldx #$02              ; load x register with 2
          cpx x                ; compare x register to accumulator
          beq is_prime_not_prime ; branch if equal
          cpx #$02             ; compare x register to 2
          beq is_prime_not_prime ; branch if equal
          dex                  ; decrement x register
          bne is_prime         ; branch to loop if not at end of range
          rts

is_prime_not_prime
          lda #$01             ; load accumulator with 1 (indicating not prime)
          rts
