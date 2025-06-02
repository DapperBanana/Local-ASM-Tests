
; Factorial program in 6502 Assembly

        .org $0200

START   LDX #$06       ; Initialize counter to 6
        LDA #$01       ; Initialize factorial to 1

LOOP    STA $FB        ; Store the current factorial in memory
        DEX            ; Decrement counter
        BNE NEXT       ; If counter is not zero, continue loop

DONE    LDA $FB        ; Load the final factorial value
        BRK            ; End program

NEXT    SEC            ; Clear carry bit
        LDA $FB        ; Load the current factorial value
        CLC            ; Clear carry bit
        ADC #$01       ; Add 1 to the current factorial value
        STA $FB        ; Store the updated factorial value

        DEX            ; Decrement counter
        BNE LOOP       ; If counter is not zero, continue loop

        JMP DONE       ; Jump to done if counter is zero

        .org $FC
        .byte $00      ; Initialize memory location to store factorial

        .end
