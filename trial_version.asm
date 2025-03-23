
; 6502 Assembly program to convert a binary number to decimal

        .org $0200

start:
        LDX #7          ; Set X register to the number of bits in the binary number
        LDA #0          ; Initialize accumulator to zero
        STA result      ; Clear the result

loop:
        LDA input,X     ; Load the next bit of the binary number
        ASL             ; Shift accumulator left
        ROL result      ; Rotate carry into result
        DEX             ; Decrement X
        BPL loop        ; Continue looping until all bits are processed

        RTS

input:  .byte %10010110  ; Binary number to convert (in little-endian order)
result: .byte 0         ; Resulting decimal number

        .org $0230
        .byte $00       ; Add padding for program to run correctly
