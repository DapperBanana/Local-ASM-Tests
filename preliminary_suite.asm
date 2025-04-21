
; Fibonacci sequence using memoization

    .org $0200

first:  .byte 0     ; Stores the first Fibonacci number
second: .byte 1     ; Stores the second Fibonacci number
n:      .byte 0     ; Stores the value of n
result: .byte 0     ; Stores the result of the nth Fibonacci number

    ; Main code section
start:
    lda #8         ; Load the desired Fibonacci term (n) into A register
    sta n          ; Store the value of n into n variable
    lda #0
    sta first      ; Initialize first Fibonacci number with 0
    sta second     ; Initialize second Fibonacci number with 1

    lda n
    bne loop       ; If n is not equal to 0, jump to loop

    lda first
    sta result     ; If n = 0, result is the first Fibonacci number
    jmp end

loop:
    lda n
    cmp #2
    beq calc      ; If n = 2, calculate the next Fibonacci number
    
    ldx n
    inx           ; Increment n by 1
    stx n

    lda first
    clc
    adc second
    sta result
    sta first

    lda second
    sta second_old
    lda result
    sta second

    lda second_old
    jmp loop

calc:
    lda first
    clc
    adc second
    sta result

end:
    ; End of program
    rts

    .end
