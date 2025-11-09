
STACK_START equ $0200

    processor 6502
    org $0200

    lda #$00
    sta STACK_START ; Initialize stack pointer
    lda #$05
    jsr push         ; Push value onto stack
    lda #$0A
    jsr push         ; Push another value onto stack
    jsr pop          ; Pop value from stack
    jsr pop          ; Pop another value from stack

    lda $FE          ; Load accumulator with popped value
    jsr printValue   ; Print value
    lda $FE          ; Load accumulator with popped value
    jsr printValue   ; Print value
    
    rts

push:
    lda $01         ; Load accumulator with value to push
    sta $FE,x       ; Store value on stack
    dex             ; Decrement stack pointer
    rts

pop:
    inx              ; Increment stack pointer
    lda $FE,x        ; Load accumulator with value from stack
    rts

printValue:
    ; Output value in accumulator to screen
    ; (Implement your own code here)
    rts
