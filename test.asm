
        .org $0200

start   ldx #$00              ; Initialize index X to 0
        ldy #$00              ; Initialize index Y to 0
        lda $2000,x          ; Load first element into A register
        sta $2100            ; Store first element as largest
        lda $2000,x          ; Load next element into A register
        sta $2101            ; Store next element as second largest
        
loop    inx                   ; Increment index X
        lda $2000,x          ; Load next element into A register
        cmp $2100            ; Compare with largest element
        bcs larger           ; Branch if greater
        cmp $2101            ; Compare with second largest element
        bcs update           ; Branch if greater
        
        jmp next             ; Jump to next element

larger  lda $2100            ; Load largest element into A register
        sta $2101            ; Store largest element as second largest
        lda $2000,x          ; Load new largest element into A register
        sta $2100            ; Store new largest element
        jmp next             ; Jump to next element

update  lda $2000,x          ; Load new second largest element into A register
        sta $2101            ; Store new second largest element

next    cpx #$1F              ; Check if end of list is reached
        bcs done             ; Branch if end of list
        jmp loop             ; Jump back to loop

done    rts                   ; Return from subroutine
