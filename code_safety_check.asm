
; Program to calculate the average of elements in a list.

        .org    $0200               ; Start address
        .word   $0000               ; Placeholder for average
        .word   $2000               ; Start address of list
        .word   $200A               ; End address of list

        ldx     #0                  ; Initialize index to 0
        ldy     #0                  ; Initialize sum to 0
loop    lda     ($2000),x          ; Load element at index into accumulator
        clc                        ; Clear carry flag
        adc     y                  ; Add accumulator to sum
        sta     y                  ; Store sum
        inx                        ; Increment index
        cpx     $200A              ; Compare index with end address
        bne     loop               ; Loop until end of list is reached

        ldx     #0                  ; Initialize index to 0
        ldy     #0                  ; Initialize sum to 0
        lda     ($2000),x          ; Load element at index into accumulator
        beq     end                ; Exit if list is empty

average ldx     $200A              ; Load end address
        cmp     #1                  ; Check if list has only one element
        beq     end                ; If only one element, exit

        lda     #$00                ; Clear accumulator
        ldx     #0                  ; Initialize index to 0
loop2   lda     ($2000),x          ; Load element at index into accumulator
        clc                        ; Clear carry flag
        adc     y                  ; Add accumulator to sum
        sta     y                  ; Store sum
        inx                        ; Increment index
        cpx     $200A              ; Compare index with end address
        bne     loop2              ; Loop until end of list is reached

        lda     #$00                ; Clear accumulator
        ldx     #0                  ; Initialize index to 0
loop3   lda     ($2000),x          ; Load element at index into accumulator
        clc                        ; Clear carry flag
        adc     #$00                ; Add accumulator to sum
        adc     y                  ; Add accumulator to sum
        tax                        ; Copy sum to X
        cpx     $200A              ; Compare index with end address
        bmi     skip               ; Check for negative number
        sec                        ; Set carry flag if positive
skip    adc     #0                  ; Calculate sum = sum + 0
        sta     y                  ; Store sum
        inx                        ; Increment index
        cpx     $200A              ; Compare index with end address
        bne     loop3              ; Loop until end of list is reached

        lda     #$00                ; Clear accumulator
        clc                        ; Clear carry flag
        adc     y                  ; Add accumulator to sum
        ldx     $200A              ; Load end address
        cpx     #1                  ; Check if list has only one element
        bne     notsingle          ; If not, continue
end     jsr     print_avg          ; Jump to subroutine to print average
        jmp     done               ; Exit program

notsingle lda     #$00                ; Clear accumulator
        inx                        ; Increment index
        ldx     #0                  ; Initialize index to 0
        ldy     #0                  ; Initialize sum to 0
        jmp     average             ; Jump to calculate average

print_avg
        ldy     $0000              ; Load sum
        ldx     $200A              ; Load end address
        lsr                        ; Divide by number of elements
        sta     $0000              ; Store average
        lda     $0000              ; Load average
        jsr     print              ; Print average

done    rts                        ; Return from subroutine

print   ; Subroutine to print value in accumulator
        sta     $D020              ; Store value in VIC-II memory
        lda     #$EA               ; Syscall for print
        jsr     $FFD2              ; Call Kernal routine
        rts                        ; Return from subroutine

        .org    $FFFC              ; Reset vector
        .word   $0200              ; Start address

        .end
