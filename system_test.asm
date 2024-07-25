
        .org $0200

start   lda num1      ; Load the first number into the accumulator
        sta operand1  ; Store it in operand1
        lda num2      ; Load the second number into the accumulator
        sta operand2  ; Store it in operand2

        mul operand1  ; Multiply operand1 and operand2 to get the result
        cmp result    ; Compare the result with the given number
        beq is_vampire ; Branch to is_vampire if the numbers match

not_vampire
        lda #0        ; Load 0 into the accumulator
        sta $0200     ; Store it at $0200 (output location)
        rts           ; Return from subroutine

is_vampire
        lda #1        ; Load 1 into the accumulator
        sta $0200     ; Store it at $0200 (output location)
        rts           ; Return from subroutine

num1    .byte 15      ; First number
num2    .byte 35      ; Second number
operand1 .byte 0      ; Operand 1
operand2 .byte 0      ; Operand 2
result  .byte 0       ; Result

        .end
