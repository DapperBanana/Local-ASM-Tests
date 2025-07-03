
    .org $1000
    
    LDA #4        ; Length of the base side of the tetrahedron
    STA side
    
    LDA side
    JSR square    ; Calculate the square of the side
    
    LDX #3        
    LDY #2        ; Three sides of the base and height of the tetrahedron
    
    LDA side
    CLC
loop:
    ADC side,X   ; Sum of three sides
    DEX
    DEY
    
    BNE loop
    
    ASL height    
    ASL height    ; Multiply height by 4
    ASL height
    ASL height
    
    LDA #1
    STA multiplier
    
    LDA temp1
    JSR multiply  ; Multiply sum by 4
    
    STA area
    
    NOP
    NOP           ; Breakpoint
    
square:
    ASL A         ; Square of a value
    STA temp1
    RTS
    
multiply:
    CLC
    ADC area
    DEX
    BNE multiply
    
    RTS
    
side:    .BYTE 0
height:  .BYTE 0
multiplier: .BYTE 0
area:    .BYTE 0
temp1:   .BYTE 0
temp2:   .BYTE 0
