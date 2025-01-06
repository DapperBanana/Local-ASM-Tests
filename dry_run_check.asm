
STACK_SIZE = 10
STACK_START = $0200      ; Start of stack memory

    .org $0200
stack   .ds STACK_SIZE   ; Stack memory

    .org $0400
start
    ; Initialize stack pointer
    ldx #STACK_SIZE - 1  ; Set X to point to the top of the stack
    ldy #stack           ; Load the address of the stack into Y
    stx $0100            ; Store X in the stack pointer register, starting at $0100

    ; Push values onto the stack
    lda #10
    jsr push

    lda #20
    jsr push

    ; Pop values from the stack
    jsr pop
    jsr pop

    ; Halt program
    brk

push
    ; Check if stack is full
    lda $0100
    cmp #stack
    bcc push_error

    ; Store value on stack
    sta ( $0100, x )
    dex

    rts

push_error
    lda #0
    sta $FFFC ; error code for 'Stack Full' error
    brk

pop
    ; Check if stack is empty
    lda $0100
    cmp #STACK_SIZE - 1
    bcs pop_error

    ; Load value from stack
    lda ( $0100, x )
    inx

    rts

pop_error
    lda #1
    sta $FFFC ; error code for 'Stack Empty' error
    brk
