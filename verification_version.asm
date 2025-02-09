
; Check if a given matrix is a magic torus
; Input: A 3x3 matrix stored in memory starting from address $2000
; Output: Carry flag is set if the matrix is a magic torus, cleared otherwise

LDA #$00          ; Initialize sum counter to 0
STA $00
STA $01
STA $02

; 1st row sum
LDA $2000
CLC
ADC $2001
ADC $2002
CMP $00
BNE end

; 2nd row sum
LDA $2003
CLC
ADC $2004
ADC $2005
CMP $01
BNE end

; 3rd row sum
LDA $2006
CLC
ADC $2007
ADC $2008
CMP $02

; If all sums are equal, set carry flag
end:
BCS is_magic
CLC

; Check if the first row is equal to the column 1 sum
; 1st column sum
LDA $2000
CLC
ADC $2003
ADC $2006
CMP $00
BNE not_magic

; Check if the second row is equal to the column 2 sum
; 2nd column sum
LDA $2001
CLC
ADC $2004
ADC $2007
CMP $01
BNE not_magic

; Check if the third row is equal to the column 3 sum
; 3rd column sum
LDA $2002
CLC
ADC $2005
ADC $2008
CMP $02
BNE not_magic

; If all checks passed, set carry flag
is_magic:
SEC
JMP done

not_magic:
CLC

done:
RTS
