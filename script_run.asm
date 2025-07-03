
        .org $0200              ; Start of program memory

start:
        ldx #0                 ; Initialize index to 0
        lda #$00               ; Initialize sum to 0
        
loop:
        lda $0400, x           ; Load element at index X
        clc                    ; Clear carry flag
        adc 1                  ; Increment sum by current element
        sta $0301              ; Store partial sum
        inx                    ; Increment index
        cpx $0300              ; Check if end of list
        bne loop               ; If not, continue looping
        
        lda $0301              ; Load partial sum
        ldx $0300              ; Load number of elements
        jsr divide             ; Divide sum by number of elements
        
        jmp $fffc              ; End program

divide:
        clc                    ; Clear carry flag
        ldy #0                 ; Initialize counter to 0
        
loop2:
        sbc #$01               ; Subtract 1 from sum
        iny                    ; Increment counter
        cpy $0300              ; Check if all elements have been divided
        bne loop2              ; If not, continue looping
        
        rts                    ; Return from subroutine
