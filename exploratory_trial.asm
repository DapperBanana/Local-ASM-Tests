
    .org $0200    ; start address of the program

start:
    LDX #$09      ; 9 sides in a nonagon
    LDA #$03      ; each side has length 3
    CLC
    ASL A         ; calculate the area by multiplying number of sides by side length squared
loop:
    DEX
    BPL loop
    STA result    ; store the result in the memory address "result"
    BRK

result: .byte 0

    .org $FFFA    ; set the program entry point
    .word start   ; the program starts at the label "start"
