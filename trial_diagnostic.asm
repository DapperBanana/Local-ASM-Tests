
    ; 6502 Assembly program to check if a given matrix is symmetric
    
    ; Assume matrix is stored in memory starting at address $2000
    ; Each element of the matrix is a byte
    
    LDA #$00        ; Initialize index i to 0
    STA index_i
    
    LDA #$00        ; Initialize index j to 0
    STA index_j
    
loop_i:
    LDA index_i
    STA temp_i
    
    LDA #$00        ; Reset index j to 0
    STA index_j
    
loop_j:
    LDA index_i
    CLC
    ADC index_j
    TAX             ; Calculate index = 256 * i + j
    
    LDA $2000, X    ; Load element (i, j)
    
    LDA index_j
    CLC
    ADC temp_i
    TAX             ; Calculate index = 256 * j + i
    
    LDA $2000, X    ; Load element (j, i)
    
    CMP $2000, X    ; Compare elements (i, j) and (j, i)
    BNE not_symmetric ; If not equal, matrix is not symmetric
    
    INX             ; Increment index j
    LDA index_j
    STA index_j
    
    CMP #$0A        ; Check if j < 10 (matrix size)
    BCC loop_j
    
    INX             ; Increment index i
    LDA index_i
    STA index_i
    
    CMP #$0A        ; Check if i < 10 (matrix size)
    BCC loop_i
    
symmetric:
    ; Matrix is symmetric
    JMP done
    
not_symmetric:
    ; Matrix is not symmetric
    JMP done
    
done:
    BRK
    
index_i: .BYTE 0
index_j: .BYTE 0
temp_i: .BYTE 0
    
    ; Sample matrix (10x10):
    ; 1 2 3 4 5 6 7 8 9 0
    ; 2 1 2 3 4 5 6 7 8 9
    ; 3 2 1 2 3 4 5 6 7 8
    ; 4 3 2 1 2 3 4 5 6 7
    ; 5 4 3 2 1 2 3 4 5 6
    ; 6 5 4 3 2 1 2 3 4 5
    ; 7 6 5 4 3 2 1 2 3 4
    ; 8 7 6 5 4 3 2 1 2 3
    ; 9 8 7 6 5 4 3 2 1 2
    ; 0 9 8 7 6 5 4 3 2 1
