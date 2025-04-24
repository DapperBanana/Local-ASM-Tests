
        .text
        .globl _start

_start:
        lda #0          ; Initialize index i to 0
        sta index
        lda #0          ; Initialize index j to 0
        sta j

loop:
        lda list,x      ; Load the value at index i
        cmp #0          ; Check if it is the end of the list
        beq end

        ldx #0          ; Initialize index k to 0
        lda duplicates,x  ; Load the value at index k
        cmp list,x         ; Check if the value is already in the duplicates list
        beq next

        inx             ; Increment k
        cpx #SIZE       ; Check if we have reached the end of the duplicates list
        bne loop        ; If not, continue to the next element

        sta duplicates,j  ; If the element is not in the duplicates list, add it
        iny              ; Increment j

next:
        inx             ; Increment i
        jmp loop        ; Continue to the next element

end:
        rts

.index: .byte 0
j:  .byte 0

list:   .byte 5, 3, 2, 3, 4, 2, 1, 0, 5, 0
duplicates: .byte 0, 0, 0, 0, 0
SIZE = 5
