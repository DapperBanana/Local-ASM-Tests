
        .org $0200      ; start address 

start:  lda #12        ; load first number into accumulator
        sta number1    ; store first number in memory
        lda #18        ; load second number into accumulator
        sta number2    ; store second number in memory

        jsr gcd        ; call gcd subroutine

        ; program ends here

gcd:    lda number1    ; load first number into accumulator
        clc            ; clear carry flag
loop:   sub number2    ; subtract second number from first number
        bcc skip       ; if result is negative, skip next instruction
        jmp loop       ; repeat loop if result is positive
skip:   cmp #0         ; compare result with 0
        beq done       ; if result is 0, we have found the GCD
        bcc swap       ; if result is negative, swap numbers
        lda number2    ; load second number into accumulator
        sta number1    ; store second number as new first number
        lda result     ; load result into accumulator
        sta number2    ; store result as new second number
        jmp loop       ; repeat loop
swap:   lda number1    ; load first number into accumulator
        sta temp       ; store first number in temp variable
        lda number2    ; load second number into accumulator
        sta number1    ; store second number as new first number
        lda temp       ; load temp variable into accumulator
        sta number2    ; store temp variable as new second number
        jmp loop       ; repeat loop
done:   sta result     ; store GCD in result variable
        rts            ; return from subroutine

number1: .byte 0        ; first number
number2: .byte 0        ; second number
result:  .byte 0        ; GCD result
temp:    .byte 0        ; temporary variable

        .end            ; end of program
