
; Set A: {1, 2, 3, 4}
; Set B: {3, 4, 5, 6}
; Union: {1, 2, 3, 4, 5, 6}

        .org $0200 ; Start address

        LDX #$00   ; Initialize index for set A
loopA   LDA setA,X ; Load element from set A
        STA result,X ; Store in result
        INX        ; Increment index
        CPX #4     ; Check if end of set A
        BNE loopA  ; If not, continue

        LDX #$04   ; Initialize index for set B
loopB   LDA setB,X ; Load element from set B
        CMP result,X ; Compare with result
        BEQ nextB  ; Skip if already in the result
        STA result,X ; Store in result
nextB   INX        ; Increment index
        CPX #8     ; Check if end of set B
        BNE loopB  ; If not, continue

        BRK        ; End program

setA    .byte 1, 2, 3, 4
setB    .byte 3, 4, 5, 6
result  .byte 0, 0, 0, 0, 0, 0, 0, 0

        .end

