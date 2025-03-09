
     ; Graph definition - adjacency matrix
     ;       A   B   C   D   E
     ; A     0   3   1   0   0
     ; B     3   0   0   7   5
     ; C     1   0   0   2   0
     ; D     0   7   2   0   1
     ; E     0   5   0   1   0

RESET:    LDA #0         ; Initialize registers
          STA CURRENT_NODE
          STA UNVISITED
          LDA #5
          STA DISTANCE+1
          LDA #0
          STA DISTANCE
          LDA #3
          STA NODE
          JSR DIJKSTRA    ; Find shortest path
          JMP $          ; Done

DIJKSTRA: LDA NODE        ; Get current node
          STA CURRENT_NODE
          LDA #$FF        ; Set visited flag
          STA UNVISITED, X
          LDX #0          ; Initialize index
          LDA DISTANCE    ; Get current distance
          CLC
          ADC (MATRIX, X) ; Add distance to neighbor
          CMP DISTANCE+1  ; Check if shorter path found
          BCC CHECK_NEXT
          STA DISTANCE+1  ; Update shortest distance
          ADC #0          ; Reset carry
          STA DISTANCE
          STA PATH+X      ; Update path
CHECK_NEXT:
          INX             ; Move to next neighbor
          CPX #5          ; Check if all neighbors checked
          BNE LOOP
          RTS
LOOP:     LDA MATRIX, X  ; Get distance to neighbor
          BEQ NEXT_NODE  ; Skip if neighbor doesn't exist
          LDA UNVISITED, X; Check if visited
          BNE NEXT_NODE
          STA NODE       ; Set neighbor as current node
          JSR DIJKSTRA   ; Recur to find shortest distance
NEXT_NODE:
          INX             ; Move to next neighbor
          CPX #5          ; Check if all neighbors checked
          BNE LOOP
          RTS

MATRIX:   .BYTE 0, 3, 1, 0, 0
          .BYTE 3, 0, 0, 7, 5
          .BYTE 1, 0, 0, 2, 0
          .BYTE 0, 7, 2, 0, 1
          .BYTE 0, 5, 0, 1, 0

NODE:     .BYTE 0          ; Current node
CURRENT_NODE: .BYTE 0      ; Current node index
DISTANCE: .BYTE 0, 0       ; Shortest distance to node
PATH:    .BYTE 0, 0        ; Path to node
UNVISITED: .BYTE $FF, $FF, $FF, $FF, $FF
