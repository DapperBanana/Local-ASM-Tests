
; Program to calculate the Greatest Common Divisor (GCD) of two numbers

        .org $0800  ; Start address of program

num1    .byte $00    ; First number to calculate GCD
num2    .byte $00    ; Second number to calculate GCD
result  .byte $00    ; Result of GCD calculation

        lda num1     ; Load first number into accumulator
        sta $00       ; Store it in memory location $00
        lda num2     ; Load second number into accumulator
        sta $01       ; Store it in memory location $01

loop    lda $00       ; Load num1 into accumulator
        cmp $01       ; Compare it with num2
        beq done      ; If equal, num2 is the GCD
        bcc swap       ; If num1 < num2, swap them
        sbc $01       ; Subtract num2 from num1
        sta $00       ; Store the result back in num1
        jmp loop      ; Repeat the loop

swap    lda $00       ; Load num1 into accumulator
        sta $02       ; Store it in memory location $02
        lda $01       ; Load num2 into accumulator
        sta $00       ; Store it in num1
        lda $02       ; Load stored num1 into accumulator
        sta $01       ; Store it in num2
        jmp loop      ; Continue with the loop

done    lda $01       ; Load GCD into accumulator
        sta result    ; Store it in memory location result

        ; End of program
        brk           ; Halt program

        .end          ; End of source code
