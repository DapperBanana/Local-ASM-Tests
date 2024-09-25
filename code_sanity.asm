
; Program to convert a binary number to decimal

        ORG $0200      ; Start program at address $0200

START   LDX #7         ; Load X register with the number of bits in the binary number

CONVERT LDY #0         ; Initialize Y register to hold the decimal result
        LDA $0200,X    ; Load a byte from memory starting at address $0200
        ASL            ; Shift the bits left
        BCC SKIP       ; Check if carry bit is set
        INY            ; Increment Y register if carry is set

SKIP    DEX            ; Decrement X register
        BPL CONVERT    ; Loop until all bits have been processed

        ; Output the result
        LDA #$FE        ; Load X register with the output device code
        LDX #$00        ; Start output at address $0100
        STA $FFD2       ; Set output device code
        STX $FFD3       ; Set output starting address
        LDX #$02        ; Set output length to 2 bytes
        STA $FFD4       ; Set output length
        JSR $FFD7       ; Trigger output routine

        BRK            ; End program

        ; Binary number stored in memory starting at address $0200
        .DA %10110010   ; Example binary number to convert to decimal

        .ORG $FFD2      ; Output device code
        .DA $00         ; Output device code
        .DA $01         ; Output device address
