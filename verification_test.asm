
        .org    $0200

        LDX     #$00         ; Initialize accumulator to 0
        LDY     #$07         ; Initialize counter to 7
        
loop    STA     result       ; Store result in memory location "result"
        LDY     #$01         ; Initialize counter to 1
        
loop2   ADC     counter      ; Add counter to accumulator
        INY                  ; Increment counter
        
        CPY     #$07         ; Check if counter has reached 7
        BNE     loop2        ; If not, continue loop
        
        LDA     result       ; Load result back into accumulator
        ASL                  ; Multiplies result by 2
        STA     result       ; Stores result back in memory location "result"
        
        LDA     result       ; Load result into accumulator
        RTS
        
result  .byte   $00          ; Memory location to store result
counter .byte   $00          ; Memory location to store counter
