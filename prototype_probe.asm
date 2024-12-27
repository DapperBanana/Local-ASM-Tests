
; Constants
.equ WIDTH, 4
.equ HEIGHT, 4

; Memory locations
.equ GRAPH, $2000

; Graph definition (1 = connected, 0 = disconnected)
graph_data:
    .byte 0, 1, 1, 1
    .byte 0, 0, 1, 0
    .byte 0, 0, 0, 1
    .byte 0, 0, 0, 0

start_x:
    .byte 0
start_y:
    .byte 0
end_x:
    .byte 3
end_y:
    .byte 3

; Starting point for breadth-first search
    ldx #start_x
    ldy #start_y
    jsr bfs

; Breadth-first search algorithm
bfs:
    lda #WIDTH
    sta start_idx
    lda #HEIGHT
    sta start_idy
    
next_level:
    ldx start_idx
    ldy start_idy
    
next_node:
    jsr visit_node
    
    inx
    cpx #WIDTH
    bne next_node
    
    iny
    cpy #HEIGHT
    bne next_level
    
    rts
    
visit_node:
    lda GRAPH, y
    lsr
    bcc visited
    
    sta GRAPH, y
    inx
    bcc skip_right
    inc skip_right
    dex
skip_right:
    dex
    bcs skip_left
    clc
    adc #HEIGHT
    bcs skip_down
    inc skip_down
    sbc #HEIGHT
skip_down:
    
    cpy #HEIGHT
    bcc visited
    dec y
    jsr enqueue
visited:
    rts

enqueue:
    ; Implement queue data structure to store nodes to visit
    rts
