
; Input:
; - A list of edges in the graph, represented as pairs of nodes (node1, node2)
;   Each pair should be stored as 4 bytes (2 bytes for node1, 2 bytes for node2), and the list should be terminated with a pair of zeros.
;   For example, a graph with nodes 1, 2, 3 and edges (1, 2), (2, 3) would be represented as:
;   .word 1, 2
;   .word 2, 3
;   .word 0, 0

; Output:
; - Carry flag is set if the graph is a tree, cleared otherwise

; Constants
START_ADDR = $0200

; Initialize pointers
    LDX #$00    ; Source address pointer
    LDY #$00    ; Counter for number of nodes
    CLC         ; Clear carry flag

; Loop through the edges list
LOOP:
    LDA (START_ADDR, X)     ; Load node1
    BEQ END                 ; If node1 is 0, end of list
    INX                     ; Move to next word (node2)
    
; Check if node2 is already connected to another node
    LDX #$00                ; Reset source address pointer
CHECK_LOOP:
    LDA (START_ADDR, X)     ; Load first node in current pair
    BEQ ADD_EDGE            ; If node is 0, end of list, add edge
    CMP (START_ADDR, X)     ; Compare with node2
    BEQ NOT_TREE            ; If nodes are the same, not a tree
    INX                     ; Move to next pair
    BNE CHECK_LOOP          ; Go to next pair
    
ADD_EDGE:
    INY                     ; Increase node counter
    JMP LOOP                ; Continue with next edge

NOT_TREE:
    SEC                     ; Set carry flag
    RTS

END:
    CPY #$02                ; A tree should have at least 2 nodes
    BCC NOT_TREE            ; If less than 2 nodes, not a tree
    CLC                     ; Clear carry flag
    RTS
