
        .org $1000
start   lda $1000      ; Load number of elements in the list
        tax            ; Transfer to X register
        inx            ; Increment X register to account for zero-based indexing
        ldy #0         ; Initialize counter
        lda #0         ; Initialize sum of the list
next    lda $2000,x   ; Load next number in the list
        clc            ; Clear carry flag
        adc $1002,x   ; Add it to the sum
        sta $1002,x   ; Store the updated sum back in memory
        inx            ; Increment index
        iny            ; Increment counter
        cpx $1000      ; Check if end of list
        bne next       ; Loop back if not at the end

        ldx $1000      ; Load number of elements again
        lsr            ; Divide by 2 to get middle element index
        tax            ; Transfer to X register
        lda $1002,x   ; Load the middle element
        sta $2001      ; Store the median in memory

        rts            ; Return from subroutine
