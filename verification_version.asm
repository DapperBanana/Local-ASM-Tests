
; This program checks if a given 2x2 matrix is invertible
; The matrix needs to be stored in memory starting at location $0200
; The program assumes the matrix is in the form:
; | a b |
; | c d |

        .org $0200

a       .byte 1
b       .byte 2
c       .byte 3
d       .byte 4

        .org $0300
        
        LDA a        ; Load a
        STA $00      ; Store a in memory location $00
        
        LDA d        ; Load d
        STA $01      ; Store d in memory location $01
        
        LDA b        ; Load b
        STA $02      ; Store b in memory location $02
        
        LDA c        ; Load c
        STA $03      ; Store c in memory location $03
        
        LDA $00      ; Load a
        STA $04      ; Store a in memory location $04
        
        LDA $01      ; Load d
        STA $05      ; Store d in memory location $05
        
        LDA $02      ; Load b
        STA $06      ; Store b in memory location $06
        
        LDA $03      ; Load c
        STA $07      ; Store c in memory location $07
        
        LDX #0
        
check:
        LDA $00      ; Load a
        ADC $01      ; Add d
        STA $08      ; Store result in memory location $08
        
        LDA $06      ; Load b
        ADC $07      ; Add c
        STA $09      ; Store result in memory location $09
        
        LDX $08      ; Load result of (a+d)
        CMP #$00     ; Compare with 0
        
        BNE not_invertible ; If not 0, matrix is invertible
        
        LDX $09      ; Load result of (b+c)
        CMP #$00     ; Compare with 0
        
        BNE not_invertible ; If not 0, matrix is invertible
        
        INX          ; Increment X
        CPX #1       ; Check if X = 1
        
        BCC check    ; If not, continue checking
        
invertible:
        ; Matrix is invertible
        JMP done
        
not_invertible:
        ; Matrix is not invertible
        JMP done
        
done:
        BRK          ; Exit program
