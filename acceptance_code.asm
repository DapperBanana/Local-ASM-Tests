
ORG $1000

; Define constants
NUM_VERTICES = 5
NUM_EDGES = 6
IS_TREE_FLAG = $FE

; Define adjacency matrix representing the graph
graph_data
    .db %00000
    .db %10100
    .db %01110
    .db %00100
    .db %00000

; Main program
start
    LDA #NUM_VERTICES
    STA NUM_VERTICES

    JSR is_tree

    LDA IS_TREE_FLAG
    BEQ not_tree_output

is_tree_output
    LDA #'Y'
    JSR $FFD2
    JMP end_program

not_tree_output
    LDA #'N'
    JSR $FFD2

end_program
    RTS

; Checks if the given graph is a tree
is_tree
    LDA #NUM_VERTICES
    CLC
    ADC #1
    STA NUM_EDGES

    LDX #0
check_edges
    LDY #0
check_next_edge
    LDA (graph_data, X), Y
    CMP #$01
    BEQ set_tree_flag

    INY
    CPY NUM_VERTICES
    BNE check_next_edge

    INX
    CPX NUM_VERTICES
    BNE check_edges

    LDA NUM_EDGES
    CMP #NUM_VERTICES
    BEQ set_tree_flag

    LDA IS_TREE_FLAG
    STA IS_TREE_FLAG

    RTS

set_tree_flag
    LDA #'N'
    STA IS_TREE_FLAG

    RTS
