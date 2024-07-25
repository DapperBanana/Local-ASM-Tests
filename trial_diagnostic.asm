
; Breadth-first search algorithm in 6502 Assembly

graph   .byte 0, 1, 1, 0, 0, 0, 0, 0   ; adjacency matrix representing graph
        .byte 1, 0, 0, 1, 1, 0, 0, 0
        .byte 1, 0, 0, 0, 0, 1, 0, 0
        .byte 0, 1, 0, 0, 0, 0, 1, 0
        .byte 0, 1, 0, 0, 0, 0, 1, 1
        .byte 0, 0, 1, 0, 0, 0, 0, 0
        .byte 0, 0, 0, 1, 1, 0, 0, 0
        .byte 0, 0, 0, 0, 1, 0, 0, 0

start   .equ 0   ; starting node
end     .equ 6   ; target node
size    .equ 8   ; number of nodes in graph

        lda #start
        sta start_node

        lda #size
        sta queue_end
        sta queue_head

        lda start_node
        jsr enqueue
        
loop    lda queue_head
        cmp #size
        beq end_search
        
        jsr dequeue
        sta current_node
        
        lda current_node
        cmp #end
        beq end_search
        
        lda #0
        sta neighbor
        
neighbors_loop
        lda graph, x
        beq next_neighbor
        
        lda neighbor
        cmp current_node
        beq next_neighbor
        
        lda neighbor
        jsr enqueue
        
next_neighbor
        inx
        inc neighbor
        cmp #size
        bne neighbors_loop
        
        jmp loop

end_search
        rts

enqueue lda neighbor
        sta queue, y
        iny
        lda queue_end
        clc
        adc #1
        sta queue_end
        rts

dequeue lda queue_head
        sta current_node
        lda queue, x
        sta queue_head
        inx
        rts

queue   .byte 0, 0, 0, 0, 0, 0, 0, 0
queue_head  .byte 0
queue_end   .byte 0
current_node  .byte 0
start_node  .byte 0
neighbor    .byte 0
x           .byte 0
y           .byte 0
