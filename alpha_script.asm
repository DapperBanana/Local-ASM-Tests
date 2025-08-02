
        .org $0200

number  .byte $23    ; Change this value to the number you want to check

start   lda number    ; Load the number into the accumulator
        clc          ; Clear the carry flag
loop    adc #$00      ; Add the digit to the accumulator
        bcc not_harshad ; If there was a carry, jump to not_harshad
        cmp number    ; Compare the sum with the original number
        beq is_harshad  ; If they are equal, jump to is_harshad
        inx          ; Increment X register for next digit
        inc number    ; Increment the number by 1 for next iteration
        bne loop      ; Branch always back to loop

is_harshad
        lda #$01      ; Load 1 into accumulator to indicate the number is Harshad
        sta $0201     ; Store the result in memory location $0201
        jmp end       ; Jump to end of program

not_harshad
        lda #$00      ; Load 0 into accumulator to indicate the number is not Harshad
        sta $0201     ; Store the result in memory location $0201

end     brk          ; Break to end program

        .end
