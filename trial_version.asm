
; 6502 Assembly program to calculate the nth term of the Fibonacci sequence using memoization

START    LDA #0        ; Initialize n to 0
         STA n
         LDA #1        ; Start with f(1) = 1
         STA f0        ; Store f(0) in memory address 00
         STA f1        ; Store f(1) in memory address 01
         LDA #2
         STA index     ; Start index at 2
         LDA #5
         STA n_max     ; Calculate up to the 5th term of the sequence

LOOP     LDA index     ; Load index
         CMP n_max      ; Compare index to n_max
         BEQ END        ; If index == n_max, we're done
         JSR fib        ; Call fibonacci function
         INC index      ; Increment index
         JMP LOOP       ; Repeat loop

END      BRK            ; End program

; Function to calculate the nth term of the Fibonacci sequence

fib      LDA n         ; Load n
         CLC            ; Clear carry flag
         ADC index      ; Add index
         TAX            ; Store sum in X register
         LDA f0, X      ; Load f0[n]
         STA f_new, X   ; Store f_new[n] to a new memory location
         TYA            ; Transfer index to A register
         SEC            ; Set carry flag
         SBC #1         ; Subtract 1 from index
         TAX            ; Store new index in X register
         LDA f1, X      ; Load f1[n-1]
         CLC
         ADC f1, X      ; Add f1[n-1] and f1[n-2]
         STA f0, X      ; Store the result in f0[n]
         LDA f_new, X   ; Load f_new[n]
         STA f1, X      ; Store f1[n-1] to f1[n-1] for next iteration
         RTS            ; Return from subroutine

; Memory locations
n        .BYTE 0       ; Value of n
f0       .BLKW 256     ; Array to store f0 values
f1       .BLKW 256     ; Array to store f1 values
f_new    .BYTE 0       ; Temporary storage for calculating new memoized value
index    .BYTE 0       ; Index of current Fibonacci term
n_max    .BYTE 0       ; Maximum n value to calculate up to
