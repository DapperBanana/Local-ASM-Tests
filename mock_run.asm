
; Program to calculate the area of a regular icosahedron

    .text
    .org $0200

    LDA #20      ; Number of faces in an icosahedron
    STA $01      ; Store in memory location $01

    LDA #5       ; Number of vertices in an icosahedron
    STA $02      ; Store in memory location $02

    LDA #1       ; Length of side of icosahedron
    STA $03      ; Store in memory location $03

    LDA $03      ; Load the side length into accumulator
    STA $04      ; Store in memory location $04

    LDA $01      ; Load number of faces into accumulator
    CLC          ; Clear the carry
    ADC $02      ; Add number of vertices
    ASL          ; Multiply by 2 for each face has 3 verts
    STA $01      ; Store result in memory location $01

    LDA $03      ; Get side length
    LDY $04      ; Get side length again
    STY $07      ; Store in memory location $07
    JSR MULT     ; Call subroutine to multiply
    STA $05      ; Store result in memory location $05
    
    LDA $05      ; Get product
    STA $07      ; Move to memory location $07
    INY          ; Increment side length
    STY $03      ; Store in memory location $03
    LDA $03      ; Load side length
    JSR MULT     ; Call the subroutine to multiply
    STA $06      ; Store result in memory location $06

    LDA $01      ; Get number of faces
    LDY $06      ; Get product
    STY $07      ; Store in memory location $07
    JSR MULT     ; Call subroutine to multiply
    STA $08      ; Store result in memory location $08

    LDA $08      ; Load result
    LDX $07      ; Get value
    JSR DIV       ; Call subroutine to divide
    STA $09      ; Store result in memory location $09

    ; The area of an icosahedron is given by: 5 * (3 + sqrt(5)) * (side length)^2
    ; The value of sqrt(5) is approximately 2.23606798
    
    LDA $09
    STA $FD      ; Store result in memory location $FD

    JMP $0280     ; End of program

MULT:
    LDX #0
    LDA $05
    CLC
MULT_LOOP:
    ADC $07
    DEX
    BNE MULT_LOOP
    RTS

DIV:
    LDX #0
    LDA $08
    CLC
DIV_LOOP:
    SBC $07
    DEX
    BNE DIV_LOOP
    RTS

    .end
