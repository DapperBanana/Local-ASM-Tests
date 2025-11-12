
; 6502 Assembly program to find the union of two sets

        .text
        .org $0200

start:
        lda setA        ; Load value of setA to accumulator
        ora setB        ; Perform logical OR operation with setB
        sta setResult   ; Store the result in setResult

end:
        jmp end         ; End of program

        .data
setA:   .byte %00000001   ; Set A: {1}
setB:   .byte %00000100   ; Set B: {4}
setResult: .byte 0        ; Initialize union set to 0
