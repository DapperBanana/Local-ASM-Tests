
        .org $0200
start   LDX #0
        LDY #0
        
main    LDA $0200,Y   ; print spaceship
        CMP #0
        BEQ game_over
        JSR $ffd2      ; print character
        INY
        JMP main
        
game_over
        LDX #0
print   LDA message,X
        CMP #0
        BEQ end
        JSR $ffd2
        INX
        JMP print

end     BRK

message .byte "Game Over!",0
        
        .org $fffc
        .word $0200
