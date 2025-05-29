
        .org $2000
        .word start

matrix1     .byte   1, 2, 3
            .byte   4, 5, 6
            .byte   7, 8, 9

matrix2     .byte   9, 8, 7
            .byte   6, 5, 4
            .byte   3, 2, 1

result      .byte   0, 0, 0
            .byte   0, 0, 0
            .byte   0, 0, 0

start       LDX #0      ; initialize loop counters
            LDY #0

outer_loop  CPY #3      ; check if outer loop is done
            BEQ done_outer

            LDA #0      ; initialize accumulator

inner_loop  CMP #3      ; check if inner loop is done
            BEQ done_inner

            LDA matrix1, X  ; load element from matrix1
            STA temp1       ; store it in temporary variable

            LDA #0          ; initialize accumulator

            LDX #0          ; reset inner loop counter

            inner_loop2 CMP #3  ; check if inner loop2 is done
            BEQ done_inner2

            LDA matrix2, X  ; load element from matrix2
            STA temp2       ; store it in temporary variable

            LDA temp1       ; load element from temp1
            CLC
            ADC temp2       ; add element from temp2
            STA temp3       ; store it in temporary variable

            LDA result, Y   ; load element from result
            CLC
            ADC temp3       ; add temp3 to accumulator
            STA result, Y   ; store result element

            INX             ; increment inner loop counter
            INY
            INY

            JMP inner_loop2 ; repeat inner loop

done_inner2 INX
            INY
            INY

            INY             ; increment outer loop counter
            INX

            JMP outer_loop  ; repeat outer loop

done_inner  INY             ; increment outer loop counter

            JMP inner_loop

done_outer  BRK

temp1       .byte   0
temp2       .byte   0
temp3       .byte   0

        .end
