
    .org $0200

    LDA #0                 ; Initialize index n
    STA curr_index
    LDA #0                 ; Initialize memoization table
    STA memo, X
    STA memo + 1, X
    LDA #1
    STA memo + 2, X
    STA memo + 3, X
    STA memo + 4, X
    LDA #5
    STA memo + 5, X

loop:
    LDA curr_index         ; Load index n
    STA index

    LDA memo + 2, X        ; Load memo[i-1]
    STA f1
    LDA memo, X            ; Load memo[i-2]
    STA f2

    CMP #2                 ; Check if index is less than 2
    BCC base_case

    CLC
    LDA f1
    ADC f2                 ; Calculate fibonacci
    STA temp
    LDA f1
    STA f2
    LDA temp
    STA f1

    STA memo + 4, X        ; Store memo[i-2]
    STA memo + 5, X        ; Store memo[i-1]
    INX
    INX
    
base_case:
    LDA f1
    STA memo + 2, X        ; Store memo[i]

    LDA curr_index
    CMP #n                  ; Check if n has been reached
    BEQ done

    INC curr_index          ; Increment index
    JMP loop

done:
    LDA memo + 2, X         ; Load result
    BRK

    .org $0300

    curr_index: .byte 0
    index: .byte 0
    f1: .byte 0
    f2: .byte 0
    temp: .byte 0
    memo: .byte 0, 0, 0, 0, 0, 0
    n: .byte 10               ; Enter the value of n here
