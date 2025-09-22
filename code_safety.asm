
    LDA #8        ; Load number of sides (e.g. for an octagon)
    STA sides
    
    LDA #100      ; Load side length
    STA side_length
    
    JSR calculate_area
    
    JMP $
    
calculate_area:
    LDX #0        ; Clear X register for iteration
    STX area      ; Initialize area to 0
    
loop:
    LDA sides     ; Load number of sides
    CLC
    SBC #1        ; Decrement sides
    STA sides
    
    BEQ done      ; If sides = 0, exit loop
    
    LDA area      ; Load current area
    CLC
    ADC side_length ; Add side length to total area
    STA area      ; Store new total area
    
    JMP loop      ; Repeat loop
    
done:
    RTS
    
.area .res 2
.sides .res 2
.side_length .res 2
