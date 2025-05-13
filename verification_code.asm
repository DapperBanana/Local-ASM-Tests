
    .org $0200

list    .byte $0F, $A3, $67, $29, $D4, $82, $5B, $C1, $E9, $3C
size    = 10

start   lda #0              ; Initialize index to zero
        sta index
        lda list,x         ; Load first element into accumulator
        sta largest        ; Set largest as first element
        inx                ; Increment index
loop    cpx size            ; Check if end of list reached
        beq end            ; If end of list, exit loop
        lda list,x         ; Load next element into accumulator
        cmp largest        ; Compare with largest element
        bcc next           ; If current element is smaller, skip
        sta largest        ; Set current element as largest
next    inx                ; Increment index
        jmp loop           ; Repeat loop
end     rts                ; Return

largest .byte 0            ; Variable to store largest element
index   .byte 0            ; Index variable

        .end
