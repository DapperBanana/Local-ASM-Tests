
           .org $0200
start:     LDX $f0      ; Initialize X register with first Fibonacci number
           LDY $f1      ; Initialize Y register with second Fibonacci number
           LDA #$00     ; Initialize accumulator for sum of even Fibonacci numbers
next_num:  STA $f_temp  ; Store current Fibonacci number in f_temp
           CLC          ; Clear carry flag
           ADC $f0      ; Add first Fibonacci number to the second Fibonacci number
           STA $f_sum   ; Store sum in f_sum
           LDX $f1      ; Update X register with second Fibonacci number
           LDY $f_sum   ; Update Y register with sum
           BCS not_even  ; Check if sum is an even number
           CLC          ; Clear carry flag
           ADC $accumulator ; Add current Fibonacci number to sum
           STA $accumulator ; Store updated sum in accumulator
           BCS not_even  ; Check if sum is an even number
           RTS          ; Return from subroutine
not_even:  LDX $f1      ; Update X register with second Fibonacci number
           STX $f0      ; Store second Fibonacci number in f0
           STY $f1      ; Store sum in f1
           JMP next_num ; Jump to next_num
           
f0:        .byte 00    ; First Fibonacci number (0)
f1:        .byte 01    ; Second Fibonacci number (1)
f_temp:    .byte 00    ; Temporary storage for current Fibonacci number
f_sum:     .byte 00    ; Storage for sum of current Fibonacci number
accumulator: .byte $00 ; Accumulator for sum of even Fibonacci numbers

           .end
