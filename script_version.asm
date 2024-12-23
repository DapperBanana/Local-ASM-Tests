
        .org $2000
        
; Variables
graph_buffer    .ds $100   ; Buffer for storing the graph
visited         .ds 8      ; Array to keep track of visited nodes
is_tree         .ds 1      ; Flag to store whether the graph is a tree

; Main program
start   lda #$00         ; Initialize variables
        sta is_tree
        ldx #$00
        ldy #$00

; Read the graph from input
read_loop
        lda graph_buffer, x  ; Read node from graph
        cmp #$ff        ; Check for end of graph marker
        beq end_loop
        jsr visit_node  ; Visit the node
        inx
        bne read_loop   ; Continue reading

end_loop
        lda is_tree
        beq not_tree    ; Branch if not a tree

        ; Check if all nodes are visited
        ldx #$00
all_visited
        lda visited, x
        cmp #$01
        beq next_node   ; Branch to check next node
        lda is_tree
        lda #$00
        bne not_tree    ; Branch if not a tree

next_node
        inx
        cpx #$08
        bne all_visited

        lda #$01
        sta is_tree     ; Set flag to indicate graph is a tree

not_tree
        ; Output result
        lda is_tree
        jsr output_result

        ; End program
        rts

; Subroutine to visit a node in the graph
visit_node
        lda visited, x
        beq bkn

        lda is_tree
        sta is_tree
        lda #$00        ; Not a tree
        rts

bkn
        sta visited, x
        rts

; Subroutine to output the result
output_result
        cmp #$01
        beq is_tree_msg
        jmp not_tree_msg

is_tree_msg
        lda #$54
        jsr $ffd2
        lda #$72
        jsr $ffd2
        lda #$65
        jsr $ffd2
        lda #$65
        jsr $ffd2
        lda #$0d
        jsr $ffd2
        lda #$0a
        jsr $ffd2
        rts

not_tree_msg
        lda #$4e
        jsr $ffd2
        lda #$6f
        jsr $ffd2
        lda #$74
        jsr $ffd2
        lda #$20
        jsr $ffd2
        lda #$61
        jsr $ffd2
        lda #$20
        jsr $ffd2
        lda #$74
        jsr $ffd2
        lda #$72
        jsr $ffd2
        lda #$65
        jsr $ffd2
        lda #$65
        jsr $ffd2
        lda #$0d
        jsr $ffd2
        lda #$0a
        jsr $ffd2
        rts
