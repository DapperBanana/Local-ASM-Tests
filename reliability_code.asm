
; File Compression Algorithm in 6502 Assembly

; Inputs:
; Memory starts at $4000 with uncompressed data
; Memory ends with $6000

; Outputs:
; Compressed data is stored in memory starting at $6000

START:
    LDA #$00          ; Set up accumulator for counting repetitions
    STA count

    LDA $4000         ; Load first byte of uncompressed data
    STA previousByte  ; Save it as previousByte

    LDX #$01
LOOP:
    CMP $4000,X       ; Compare next byte with previousByte
    BEQ SAME          ; If they are the same, go to SAME
    JSR STORE         ; If they are not the same, store previousByte and count and continue
    STA count
    LDA $4000,X
    STA previousByte

SAME:
    TAX              ; Increment count
    INX
    INC count

    INX              ; Check if end of data is reached
    CPX #$2000       ; Adjust this value based on the size of your data
    BCC LOOP

    JSR STORE        ; Store the last byte and its count

END:
    BRK

STORE:
    LDA count
    STA $6000        ; Store the count in compressed data
    LDA previousByte
    STA $6001        ; Store the byte in compressed data
    CLC
    ADC #$02         ; Update memory pointer
    STA count
    RTS
