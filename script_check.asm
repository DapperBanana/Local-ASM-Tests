
; Program to calculate the greatest common divisor (GCD) of two numbers
; Input: X and Y in memory addresses $00 and $01
; Output: GCD in memory address $02

        .org $0200  ; start location
        
start:
        LDA $00     ; load X into accumulator
        BEQ exit    ; if X = 0, GCD is Y, exit program
        STA $02     ; store X into memory address $02
        
gcd_loop:
        LDA $01     ; load Y into accumulator
        CLC         ; clear carry flag
        SBC $02     ; subtract X from Y
        BCC swap    ; Y < X, swap X and Y
        STA $01     ; store result in Y
swap:
        LDA $02     ; load X into accumulator
        STA $01     ; store X in Y
        LDA $01     ; load Y into accumulator
        STA $02     ; store Y in X
        BNE gcd_loop ; loop until Y = 0
        
exit:
        RTS         ; return from subroutine
