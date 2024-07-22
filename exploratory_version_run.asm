
; 6502 Assembly program to check if a given matrix is symmetric

; Set up the matrix in memory
        .org $2000      ; Start address of program
matrix  .byte $01,$02,$03,$04
        .byte $02,$05,$06,$07
        .byte $03,$06,$08,$09
        .byte $04,$07,$09,$10

        lda #0          ; Initialize counter i to 0
        sta counter_i

        lda #0          ; Initialize counter j to 0
        sta counter_j

top:
        lda counter_i   ; Load the value of i
        clc
        adc counter_j   ; Add the value of j to i
        tax             ; Store the result in X register

        lda matrix,x    ; Load element matrix[i][j]
        cmp matrix,x    ; Compare with element matrix[j][i]
        bne end         ; If not equal, matrix is not symmetric

        inc counter_j   ; Increment j

        lda counter_j
        cmp #4          ; Check if j is 4
        beq outer_end   ; If j is 4, go to outer loop
        jmp top         ; Else, continue inner loop

end:
        lda #0          ; Set return value to false (not symmetric)
        sta result

outer_end:
        lda counter_i   ; Increment i
        inc counter_i

        lda counter_i
        cmp #4          ; Check if i is 4
        beq finish      ; If i is 4, finish the program
        lda #0          ; Reset j to 0
        sta counter_j
        jmp top         ; Else, continue outer loop

finish:
        lda #1          ; Set return value to true (symmetric)
        sta result

        rts             ; Return from subroutine

counter_i .byte 0      ; Counter for i
counter_j .byte 0      ; Counter for j
result   .byte 0       ; Result variable
