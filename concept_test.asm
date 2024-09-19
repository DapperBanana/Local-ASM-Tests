
            .org $0200

start       lda numbers      ; load first number into accumulator
            sta result       ; store it in result
            ldx #1           ; initialize index to 1

loop        lda numbers, x   ; load next number into accumulator
            jsr calculate_lcm ; calculate LCM of accumulator and result
            sta result       ; store result in memory
            inx              ; increment index
            cpx #5           ; check if all numbers have been processed
            bne loop         ; if not, loop back

            ; print result
            lda result
            sta $ffd2        ; write result to screen
            rts              ; end program

; Subroutine to calculate LCM of accumulator and memory location with result
calculate_lcm
            ldx #0           ; initialize index to 0

lcm_loop    lda result       ; load result into accumulator
            clc              ; clear carry flag
            adc numbers, x   ; add number to accumulator
            tax              ; transfer accumulator to index
            lda result       ; load result back into accumulator
            jsr gcd          ; calculate GCD of result and index
            pha              ; push result onto stack
            pla              ; load GCD back into accumulator
            adc numbers, x   ; add number back to accumulator
            sec              ; set carry flag
            sbc result       ; subtract result from accumulator
            sta result       ; store result back in memory
            lda $00           ; load next byte in result into accumulator
            bpl lcm_loop     ; continue loop if positive

            rts

; Subroutine to calculate GCD of accumulator and memory location given by X
gcd
            cmp $00, x       ; compare GCD argument to current byte of result
            beq done         ; if equal, return with accumulator as GCD
            bcc gcd          ; if accumulator is larger, loop back
            ldx $00           ; if accumulator is larger, change index to current byte
            rts

done        rts

numbers     .byte 2, 3, 4, 6, 8   ; list of numbers
result      .byte 0

            .end
