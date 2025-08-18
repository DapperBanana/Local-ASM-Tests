
QUEUE_START    = $0200
QUEUE_END      = $03FF
QUEUE_MAX_SIZE = $0200

STK_PTR = $FF

* Variables
QUEUE_DATA      .addr QUEUE_START
QUEUE_HEAD      .byte 0
QUEUE_TAIL      .byte 0

* Main program
start:
    lda #STACK_SIZE
    sta STK_PTR

    ; Initialize queue head and tail pointers
    ldx #QUEUE_START
    stx QUEUE_HEAD
    stx QUEUE_TAIL

enqueue:
    lda QUEUE_TAIL
    clc
    adc #1
    cmp #QUEUE_END
    bne enqueue_not_full

enqueue_full:
    ldx QUEUE_START
    stx QUEUE_TAIL
    lda #QUEUE_START
    jmp enqueue

enqueue_not_full:
    sta QUEUE_TAIL
    sta QUEUE_DATA, x
    rts

dequeue:
    lda QUEUE_HEAD
    cmp QUEUE_TAIL
    beq dequeue_empty

    lda QUEUE_DATA, x
    inc QUEUE_HEAD
    rts

dequeue_empty:
    lda #0
    rts
