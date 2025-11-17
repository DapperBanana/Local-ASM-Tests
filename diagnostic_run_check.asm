
    .org $0200

start:
    lda #0        ; Initialize counter for number of edges
    sta edgeCount
    lda #0        ; Initialize counter for number of vertices
    sta vertexCount

getEdge:
    lda edgeList, x    ; Load edge from list
    beq checkVertices  ; If edge is 0, go to checkVertices
    
    inc edgeCount      ; Increment edge counter
    inx               ; Move to next edge
    bne getEdge       ; Check next edge

checkVertices:
    lda #0        ; Initialize counter for vertices while checking for cycles
    sta vertexCheckCount
    
checkVertex:
    lda vertexList, y     ; Load vertex from list
    beq checkTree         ; If vertex is 0, go to checkTree
    
    inc vertexCount       ; Increment vertex counter
    lda vertexCheckList, y    ; Load vertex check list
    cmp #1               ; Check if vertex has already been seen
    beq cycleDetected    ; If vertex has already been seen, cycle detected
    
    lda #1               ; Mark vertex as visited 
    sta vertexCheckList, y
    
    inc vertexCheckCount  ; Increment vertex check counter
    iny                   ; Move to next vertex
    bne checkVertex       ; Check next vertex

cycleDetected:
    lda #0       ; Set flag to indicate cycle detected
    jmp end

checkTree:
    cmp vertexCount     ; Compare number of vertices with number of edges
    bne notTree         ; If not equal, not a tree

    lda #1        ; Set flag to indicate it is a tree
    jmp end

notTree:
    lda #0        ; Set flag to indicate it is not a tree

end:
    rts

vertexList:
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0    ; List of vertices

edgeList:
    .byte 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 0    ; List of edges

vertexCheckList:
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Initialize list for checking visited vertices

edgeCount:
    .byte 0

vertexCount:
    .byte 0
    
vertexCheckCount:
    .byte 0

    .end
