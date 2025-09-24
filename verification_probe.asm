
    ; Calculate the area of a regular icosahedron

    ; Define constants
    FIVE   = $05
    FIFTY  = $32
    ROOT3  = $c6
    
    ; Load the side length of the icosahedron into register A
    LDA #FIVE
    STA SIDE_LENGTH
    
    ; Calculate the area of one equilateral triangle
    LDA SIDE_LENGTH
    CLC
    ADC SIDE_LENGTH
    ASL
    STA TRIANGLE_AREA
    
    ; Calculate the area of one face
    LDA TRIANGLE_AREA
    LSR
    STA FACE_AREA
    
    ; Calculate the area of the icosahedron
    LDA FIFTY
    JSR MULTIPLY_BY_ROOT3
    STA ICOSAHEDRON_AREA
    
    ; Exit program
    BRK
    
; Multiply a value in A by the square root of 3
MULTIPLY_BY_ROOT3:
    PHA
    LDX #3
    
MUL_LOOP:
    ASL
    ROL
    DEX
    BNE MUL_LOOP
    
    PLA
    RTS

SIDE_LENGTH      .BYTE 0
TRIANGLE_AREA    .BYTE 0
FACE_AREA        .BYTE 0
ICOSAHEDRON_AREA .BYTE 0
