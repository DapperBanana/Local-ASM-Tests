
.org $1000

GRAPH_SIZE = 5
MAX_DISTANCE = 255

MAIN:
    LDX #0          ; Initialize source vertex
INITIALIZE:
    LDA #MAX_DISTANCE
    STA DISTANCE, X   ; Initialize distance to all vertices as infinity
    INX
    CPX GRAPH_SIZE
    BNE INITIALIZE

    LDX #0          ; Initialize source vertex
LOOP:
    LDA DISTANCE, X
    CMP #MAX_DISTANCE
    BEQ NEXT_VERTEX  ; Skip vertex if already visited

    LDA X, Y        ; Get weight of current edge
    CLC
    ADC DISTANCE, X   ; Calculate new distance
    STA DISTANCE, Y

NEXT_VERTEX:
    INX
    CPX GRAPH_SIZE
    BNE LOOP

    RTS

DISTANCE:
    .byte 0  ; Array to hold distances from source vertex to each vertex in the graph
GRAPH:
    .byte  0,  7,  9,255,255
    .byte  7,  0,255,  6,255
    .byte  9,255,  0,  5,255
    .byte255,  6,  5,  0,  8
    .byte255,255,255,  8,  0

    .end
