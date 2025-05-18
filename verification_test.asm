
        .org    $0200

num1    .byte   12     ; first number
num2    .byte   18     ; second number
gcd     .byte   0      ; result variable (GCD)

start   lda     num1   ; load first number
        sta     $00    ; store it in memory location $00
        lda     num2   ; load second number
        sta     $01    ; store it in memory location $01

loop    lda     $00    ; load first number
        cmp     $01    ; compare it with second number
        beq     done   ; if equal, GCD is found
        bcc     first_smaller ; if first number is smaller, jump to first_smaller
        lda     $00    ; otherwise, load first number
        sbc     $01    ; subtract second number from it
        sta     $00    ; store the result back in first number
        bra     loop   ; restart loop

first_smaller
        lda     $01    ; load second number
        sbc     $00    ; subtract first number from it
        sta     $01    ; store the result back in second number
        bra     loop   ; restart loop

done    lda     $00    ; load final GCD
        sta     gcd    ; store it in GCD variable

end     lda     gcd    ; load GCD variable
        sta     $fe    ; store it in memory location $fe

        rts             ; return from subroutine

        .end
