
ORG $9000

    START:
        LDX #$00        ; Initialize index register X
        LDY #$00        ; Initialize index register Y
        
    READ_LOOP:
        LDA $2000, Y    ; Load a byte from input file
        BEQ END         ; If end of file, exit loop
        STA $1000, X    ; Store byte in compressed file
        INY             ; Increment Y
        INX             ; Increment X
        
    COMPRESS_LOOP:
        LDA $2000, Y    ; Load a byte from input file
        CMP $1000, X    ; Compare with previous byte in compressed file
        BEQ UPDATE_COUNT    ; If match, update count
        STA $1000, X    ; If no match, store byte in compressed file
        INX             ; Increment X
        LDA #$01        ; Load count of 1
        STA $1000, X    ; Store count in compressed file
        INX             ; Increment X
        JMP READ_LOOP  ; Jump back to read next byte
        
    UPDATE_COUNT:
        LDA ($1000, X)  ; Load current count from compressed file
        INC A           ; Increment count
        STA ($1000, X)  ; Store updated count in compressed file
        INX             ; Increment X
        JMP READ_LOOP  ; Jump back to read next byte
        
    END:
        RTS             ; Return from subroutine
