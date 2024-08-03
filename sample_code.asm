
        .include "6502.ops"
        
start:
        ; Clear memory
        LDA #$00
        STA $1000, X
        INX
        CPX #$ff
        BNE start
        
        ; Load string into memory
        LDX #$00
        LDY #$2000      ; Start address of string
readloop:
        LDA (Y), X
        STA $1100, X
        INX
        INY
        CPX #$ff
        BNE readloop
        DEC X
        
        ; Check if string is a palindrome
        LDX #$00
        LDY #$ff
checkloop:
        LDA $1100, X
        CMP $1100, Y
        BEQ continue
        LDA #$00
        STA $1200
        JMP endprog
continue:
        INX
        DEY
        CPX Y
        BNE checkloop
        
        ; Set result to 1 if string is a palindrome
        LDA #$01
        STA $1200
endprog:
        ; Halt program
        BRK
