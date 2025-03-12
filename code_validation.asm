
        .org $0600

start   lda #0        ; Set up random number generator seed
        sta $02       ; Low byte of seed
        sta $03       ; High byte of seed
        
        ldx #0        ; Initialize loop counter
loop1   ldy #0        ; Initialize inner loop counter
loop2   lda $02       ; Get random number
        and #$0F      ; Mask low 4 bits to get random letter
        clc
        adc #'A'      ; Convert to ASCII letter
        sta output, x ; Store letter in grid
        
        iny            ; Increment inner loop counter
        inx            ; Increment outer loop counter
        cpx #10        ; Check if end of row
        bne loop2      ; If not, continue inner loop
       
        cpy #10        ; Check if end of grid
        bne loop1      ; If not, continue outer loop
        
        jmp $FFD2      ; End program

output  .ds 100        ; 10x10 grid for crossword puzzle

        .end
