
        .org $0200

num1    .byte $0A        ; first number
num2    .byte $14        ; second number
result  .byte $00        ; variable to store result
temp    .byte $00        ; temporary variable

start   lda num1         ; load first number into accumulator
        cmp num2         ; compare with second number
        bcc swap          ; if first number < second number, swap them

loop    sta temp         ; store first number in temporary variable
        lda num1         ; load first number
        sec
        sbc num2         ; subtract second number from first number
        sta num1         ; store result in first number
        lda num2         ; load second number
        lda temp         ; load temporary variable
        bne loop         ; if not equal to zero, keep looping

        lda num2         ; load second number
        sta result       ; store result in result variable

done    ; program ends here

swap    lda num1         ; load first number
        sta temp         ; store in temporary variable
        lda num2         ; load second number
        sta num1         ; store in first number
        lda temp         ; load temporary variable
        sta num2         ; store in second number
        jmp loop         ; jump to loop

        .end
