
                .org $0200
start           lda #0           ; Load accumulator with 0
                sta n            ; Store 0 in n (nth term)
                lda #1           ; Load accumulator with 1
                sta result       ; Store 1 in result (Fibonacci value)
                jmp getNthTerm   ; Jump to getNthTerm subroutine

getNthTerm      lda n            ; Load nth term into accumulator
                cmp #1            ; Compare to 1
                beq endFibonacci  ; If equal, jump to endFibonacci subroutine

                lda memo1        ; Load memo1 into accumulator
                bne updateMemo1  ; If not 0, jump to updateMemo1 subroutine

                lda result       ; Load result into accumulator
                sta memo1        ; Store result in memo1
                jmp calculateFib  ; Jump to calculateFib subroutine

updateMemo1     lda memo2        ; Load memo2 into accumulator
                bne updateMemo2  ; If not 0, jump to updateMemo2 subroutine
                
                lda result       ; Load result into accumulator
                sta memo2        ; Store result in memo2
                jmp calculateFib  ; Jump to calculateFib subroutine

updateMemo2     lda result       ; Load result into accumulator
                sta memo1        ; Store result in memo1
                lda n            ; Load nth term into accumulator
                sta memo2        ; Store nth term in memo2
                jmp calculateFib  ; Jump to calculateFib subroutine

calculateFib    lda memo1        ; Load memo1 into accumulator
                clc
                adc memo2        ; Add memo2 to accumulator
                sta result       ; Store sum in result
                lda n            ; Load nth term into accumulator
                dec                ; Decrement nth term
                sta n            ; Store decremented nth term back in n
                jmp getNthTerm   ; Jump back to getNthTerm subroutine

endFibonacci    lda result       ; Load result into accumulator
                sta $0201        ; Store result in memory location $0201
                rts                ; Return from subroutine

                .org $023C
n               .byte 0          ; nth term
result          .byte 0          ; Fibonacci value
memo1           .byte 0          ; Memoization value 1
memo2           .byte 0          ; Memoization value 2

                .end
