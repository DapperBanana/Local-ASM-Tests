
        ; Initialize pointers and counters
        LDA #0        ; Load accumulator with counter
        STA $10       ; Store counter to memory location $10
        LDX $00       ; Load X register with length of string
        LDA $01,X     ; Load accumulator with first character of string
        LDY $00       ; Load Y register with offset

reverse_loop:
        STA $20,Y     ; Store character in reversed string
        INY           ; Increment Y register
        DEX           ; Decrement X register
        BNE reverse_loop ; Branch if not at the beginning of the string
        LDA #$FF      ; Load accumulator with end of string marker
        STA $20,Y     ; Store end of string marker

        ; Increment pointers and counters
        INX           ; Increment X register
        LDA $10       ; Load accumulator with counter
        CMP $00       ; Compare counter to length of string
        BEQ done      ; Branch if counter equals length of string
        INY           ; Increment Y register
        INC $10       ; Increment counter
        LDA $01,X     ; Load accumulator with next character of string
        JMP reverse_loop

done:
        RTS           ; Return from subroutine

        .ORG $0200
input_string:
        .BYTE "Hello, World!",0
reversed_string:
        .BLKB 20       ; Reserve space for reversed string
