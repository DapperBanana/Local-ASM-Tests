
; Program to find the shortest path in a graph using Dijkstra's algorithm
; Assume the graph is represented as an adjacency matrix

graph .ds 8     ; Define an 8x8 adjacency matrix graph
distances .ds 8 ; Array to store the distances from source node

start:
    lda #0
    sta distances, x   ; Initialize distances to infinity
    inx

    lda #1             ; Start from node 0
    sta distances, x   ; Set the distance to 0 for the source node

    lda #0
    sta x              ; Initialize loop counter

loop:
    lda #0
    sta y              ; Initialize y to 0

inner_loop:
    lda distances, x      ; Load current distance
    cmp #0                ; Check if distance is 0 (infinity)
    beq skip_update       ; Skip updating if distance is 0

    lda graph, x, y       ; Load the weight of the edge
    cmp #0                ; Check if the edge exists
    beq skip_update       ; If not, skip updating the distance

    clc
    lda distances, x
    adc graph, x, y       ; Add edge weight to current distance
    sta temp              ; Store the new distance temporarily

    lda distances, y
    cmp temp              ; Compare new distance with current distance
    bcc update_distance   ; If new distance is smaller, update the distance

skip_update:
    iny
    cpy #8
    bne inner_loop

    inx
    cpx #8
    bne loop

    rts

update_distance:
    sta distances, y
    jmp skip_update

temp .ds 1
y .ds 1
x .ds 1
