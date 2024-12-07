
.pathstart lda #START_NODE
           sta CURRENT_NODE
           
.loop      lda CURRENT_NODE
           sta QUEUE,X
           inx
           lda #1
           sta QUEUE_LENGTH
           
           lda #0
           sta VISITED, X
           
.process   lda QUEUE, X
           sta CURRENT_NODE
           inx
           
           lda NEIGHBORS, X
           beq .done
           
           sta NEIGHBOR
           
.check_neighbors lda CURRENT_NODE
                cmp NEIGHBOR
                beq .skip
                lda VISITED, X
                bne .skip
                lda NEIGHBOR
                sta QUEUE, Y
                iny
                lda QUEUE_LENGTH
                clc
                adc #1
                sta QUEUE_LENGTH
                inx
                
.skip          inx
              lda NEIGHBORS, X
              bne .check_neighbors
              
.done         lda VISITED, Y
              beq .process
              rts
              
; Data
QUEUE        .block 10
QUEUE_LENGTH .byte 0
VISITED      .block 10
START_NODE   .byte 0
CURRENT_NODE .byte 0
NEIGHBOR     .byte 0
NEIGHBORS    .byte 0, 1, 2
