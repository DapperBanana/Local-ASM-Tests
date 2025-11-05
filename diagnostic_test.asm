
; This program checks if a given matrix is a magic square

; Input:
; A 3x3 matrix in memory starting at address $2000
; Matrix elements should be stored row-wise

; Output:
; Accumulator = 0 if not a magic square, 1 if a magic square

        ORG $1000

START   LDA #$00
        STA $FE        ; Initialize sum to zero
        LDX #$09        ; Loop counter
        LDA #$09        ; Initialize magic constant

LOOP    LDA $2000, X  ; Load matrix element
        CLC
        ADC $FE        ; Add to sum
        STA $FE        ; Save new sum

        DEX
        BPL LOOP        ; Repeat until all elements processed

        LDA $FE        ; Load sum into accumulator

        CMP #$1E        ; Check if sum is equal to magic constant
        BEQ IS_MAGIC    ; If equal, it's a magic square

        LDA #$00        ; Not a magic square
        RTS

IS_MAGIC
        LDA #$01        ; Magic square
        RTS

        END START
