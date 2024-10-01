
; Breadth-First Search Algorithm in 6502 Assembly

GRAPH_SIZE = 5

START_NODE = 0
END_NODE = 4

NODE_QUEUE = $20                   ; Queue to store nodes to visit
DISTANCES = $30                    ; Array to store distance from start node
PARENTS = $38                      ; Array to store parent node
VISITED = $40                      ; Array to keep track of visited nodes

; Initialize graph adjacency matrix
    .org $8000
graph    .byte %00000
         .byte %10100
         .byte %01010
         .byte %00101
         .byte %00000

start:
    lda #START_NODE
    sta NODE_QUEUE
    lda #0
    sta DISTANCES,X
    sta PARENTS,X
    sta VISITED,X
    inx
    cpx #GRAPH_SIZE
    bne start

    lda #START_NODE
    jsr bfs

    lda END_NODE
    jsr print_path

    rts

; Breadth-First Search Algorithm
bfs:
    lda #0
    sta X
    lda NODE_QUEUE
    sta (NODE_QUEUE,X)
    lda #1
    sta NODE_QUEUE+1
    ldx #0

bfs_loop:
    lda (NODE_QUEUE),X
    cmp END_NODE
    beq found_path

    lda DISTANCES,X
    clc
    adc #1
    sta Y
    lda (NODE_QUEUE),X
    tax

    lda #0
    sta Y

explore_neighbors:
    lda GRAPH,X
    sta Z
    lda #0
    cpx #GRAPH_SIZE
    beq update_parents

    lda (NODE_QUEUE),X
    cmp VISITED,X
    beq skip_node

    lda Z,X
    beq skip_node
    lda DISTANCES,X
    bne skip_node

    clc
    lda Y
    adc #1
    sta (NODE_QUEUE),Y
    lda Y
    sta PARENTS,X
    lda #1
    sta DISTANCES
    clc
    adc #1
    sta Y

skip_node:
    inx
    cpx #GRAPH_SIZE
    bne explore_neighbors

update_parents:
    lda #1
    sta VISITED,X
    lda DISTANCES
    inc X
    lda NODE_QUEUE+1
    cpx #0
    beq bfs_loop

    lda Y
    sta X
    lda #0
    jsr bfs_loop

found_path:
    rts

print_path:
    lda END_NODE
    cmp START_NODE
    beq print_node
    lda PARENTS,X
    pha
    jmp print_path

print_node:
    lda #START_NODE
    jsr print_digit
    pla
    cmp #0
    beq end_print
    jsr print_dash
    jmp print_node

print_digit:
    tax
    lda #$30
    clc
    adc X
    jsr $FFD2
    rts

print_dash:
    lda #'-'
    jsr $FFD2
    rts

end_print:
    lda #0
    jmp $FFCF

    .end
