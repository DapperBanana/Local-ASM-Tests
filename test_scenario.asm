
; Program to calculate the sum of the digits of a number until it becomes a single-digit number

        .org $0200     ; Start address of the program

start   lda number    ; Load the number into the accumulator
        sta temp      ; Save the number in a temporary variable

loop    clc           ; Clear the carry flag
        lsr           ; Divide the number by 10
        sta number    ; Save the new number
        adc number    ; Add the last digit to the sum
        bcc loop      ; Repeat until carry flag is set

        lda number    ; Load the final sum into the accumulator
        cmp #10       ; Check if the sum is a single-digit number
        bcc done      ; If sum is a single-digit number, jump to done

        jsr clear     ; If sum is not a single-digit number, clear the carry flag

        bra loop      ; Continue the loop until sum becomes a single-digit number

done    lda number    ; Load the single-digit sum into the accumulator
        sta result    ; Save the result
        rts           ; Return from subroutine

clear   sec           ; Set the carry flag
        rts           ; Return from subroutine

number  .byte $23     ; Change the number here

temp    .byte $00     ; Temporary variable to store the number

result  .byte $00     ; Variable to store the final result

        .end
