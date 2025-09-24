
QUEUE_SIZE = 10

.data
queue: .ds QUEUE_SIZE
front: .byte 0
rear: .byte 0

.text
start:
    ; Initialize queue
    lda #queue
    sta front
    lda #queue
    sta rear

    ; Enqueue elements into the queue
    lda #1
    jsr enqueue
    lda #2
    jsr enqueue
    lda #3
    jsr enqueue

    ; Dequeue elements from the queue
    jsr dequeue
    jsr dequeue

done:
    ; Stop execution
    jmp done

enqueue:
    lda front
    clc
    adc #1
    and #QUEUE_SIZE-1
    sta front

    lda rear
    cmp front
    beq enqueue_full

    sta (front), y
    rts

enqueue_full:
    ; Error: Queue is full
    rts

dequeue:
    lda front
    cmp rear
    beq dequeue_empty

    lda rear
    clc
    adc #1
    and #QUEUE_SIZE-1
    sta rear

    lda (rear), y
    rts

dequeue_empty:
    ; Error: Queue is empty
    rts
