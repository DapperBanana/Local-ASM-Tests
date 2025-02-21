
        .org $0200  ; start program at memory address $0200
        
number  .byte $3A  ; change this value to test different numbers

        LDA number  ; load number into accumulator
        AND #$01    ; bitwise AND with 1
        
        BEQ isEven ; if result is zero, number is even
        JMP isOdd
        
isEven  LDA #$00    ; load 0 into accumulator (even)
        STA $0201    ; store result at memory address $0201
        JMP end
        
isOdd   LDA #$01    ; load 1 into accumulator (odd)
        STA $0201    ; store result at memory address $0201
        JMP end
        
end     ; end of program
        BRK         ; halt program execution
