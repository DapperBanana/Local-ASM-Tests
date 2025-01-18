
; Fibonacci sequence calculation using memoization
; Input: N (n-th term to calculate)
; Output: Fibonacci number at N

; Start of program
    .org $0200      ; Start program at address $0200

start:
    LDX #0          ; Initialize X register to 0
    LDY #0          ; Initialize Y register to 0

    LDA #6          ; Input the desired n-th term (e.g., N=6)
    STA n

    JSR fibonacci   ; Calculate the Fibonacci number at N

    ; Output result
    LDA result
    STA $FD         ; Store the result in memory location $FD (can be changed to any other memory location)
    
    NOP             ; Halt program
    
fibonacci:
    ; Check if N is 0 or 1
    LDA n
    CMP #$02
    BCS continue

    ; Set Fibonacci for 0 and 1
    LDA #0
    STA result
    STA +1
    INC +1
    RTS

continue:
    ; Initialize memoization table
    LDA #0
    STA memo
    STA memo + 1

    ; Initialize loop counters
    LDX #2
    LDA #1
    STA result
    STA +1

loop:
    ; Calculate Fibonacci number at N
    LDA result
    CLC
    ADC +1
    STA temp
    LDA +1
    STA temp + 1
    LDA temp
    ADC memo
    STA result
    LDA temp + 1
    ADC memo + 1
    STA +1

    ; Memoize the result
    LDA result
    STA memo
    LDA +1
    STA memo + 1

    ; Update loop counters
    INX
    CMP n
    BNE loop

    RTS

; Variables
n:  .byte 0         ; Input N (n-th term to calculate)
memo: .word 0       ; Memoization table for Fibonacci numbers
result: .word 0     ; Result of Fibonacci(n)
temp: .word 0       ; Temporary variable for calculations

    .end
