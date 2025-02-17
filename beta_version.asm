
; 6502 Assembly program to find the shortest path in a graph using breadth-first search

GRAPH_START   = $1000  ; Start address of the graph
NUM_NODES     = 5      ; Number of nodes in the graph

; Node struct definition
NODE_START    = $2000  ; Start address of the node struct
NODE_ADJACENT = 0      ; Offset to the adjacent nodes
NODE_VISITED  = 1      ; Offset to the visited flag
NODE_PARENT   = 2      ; Offset to the parent node
NODE_DISTANCE = 3      ; Offset to the distance from the start

; Main program
START:
    LDA #NUM_NODES     ; Initialize the number of nodes
    STA NUM_NODES_LEFT 
    
    LDA #0             ; Clear memory for visited array
    STA VISITED_ARRAY, X
    INX
    CPX NUM_NODES
    BNE -

-:
    STA VISITED_ARRAY, X
    INX
    CPX NUM_NODES
    BNE -
    
    LDA GRAPH_START     ; Set start node to node 0
    STA START_NODE
    
    LDA #0              ; Initialize the queue
    STA QUEUE_START
    STA QUEUE_END
    
    LDA START_NODE      ; Mark start node as visited
    STA VISITED_ARRAY, X
    
LOOP:
    LDA QUEUE_START  
    
    CMP QUEUE_END        ; Check if queue is empty
    BEQ DONE

    STA CURRENT_NODE
    
    LDA (QUEUE_START), Y  ; Get current node distance
    STA CURRENT_DISTANCE
    
    INY
    BEQ SKIP_NEXT
    
    TYA
    ADC #1
    STA Y
    
SKIP_NEXT:
    LDA GRAPH_START
    LDX CURRENT_NODE
    CLC
    ADC X
    STA NODE_PTR

    LDA #0
    STA ADJACENT_NODE
    STA NEXT_DISTANCE
    
SEARCH_ADJACENT:
    LDA (NODE_PTR), X
    BEQ DONE_SEARCH_ADJACENT
    STA ADJACENT_NODE
    
    LDA ADJACENT_NODE
    STA NEXT_NODE
    
    LDA VISITED_ARRAY, Y
    TAX
    LDA NODE_ADJACENT, X
    CLC
    ADC X
    CMP #0
    BEQ VISIT_ADJACENT
    
    LDA VISITED_ARRAY, Y
    TAX
    LDA NODE_DISTANCE, X
    CLC
    ADC X
    PHA
    PLA
    
    LDA CURRENT_DISTANCE
    CLC
    ADC #1
    TAX
    
    LDA NODE_DISTANCE, X
    CLC
    ADC X
    STA NEXT_DISTANCE
    
VISIT_ADJACENT:
    LDA VISITED_ARRAY
    TAX
    LDA NEXT_NODE
    STA VISITED_ARRAY, X
    
    LDA NEXT_NODE
    STA (QUEUE_END)
    
    LDA NEXT_DISTANCE
    STA (QUEUE_END), Y
    
    CLD
    INC QUEUE_END
    INY

    JMP SEARCH_ADJACENT

DONE_SEARCH_ADJACENT:
    INC QUEUE_START
    INC Y
    JMP LOOP
    
DONE:
    RTS

; Data section
GRAPH_DATA:
    .byte $03, $02 ; Node 0: Adjacent nodes
    .byte $01       ; Node 1: Adjacent nodes
    .byte $03, $04 ; Node 2: Adjacent nodes
    .byte $00       ; Node 3: Adjacent nodes
    .byte $02       ; Node 4: Adjacent nodes
    
VISITED_ARRAY:
    .ds NUM_NODES   ; Visited array
    
QUEUE_START:
    .byte 0         ; Queue start index
QUEUE_END:
    .byte 0         ; Queue end index

START_NODE:
    .byte 0         ; Start node index

CURRENT_NODE:
    .byte 0         ; Current node index
CURRENT_DISTANCE:
    .byte 0         ; Current node distance
    
ADJACENT_NODE:
    .byte 0         ; Adjacent node index
NEXT_NODE:
    .byte 0         ; Next node index
NEXT_DISTANCE:
    .byte 0         ; Distance of next node
