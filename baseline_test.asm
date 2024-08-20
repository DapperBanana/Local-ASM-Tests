
        .org $0801      ; BASIC start address
        .word $0801
        .word $080d      ; program start address
        .byte $0b, $08, $0a, $00, $9e, $32, $30, $36, $34

        .org $080d      ; program start
start
        JSR $FFD2      ; print message
        LDA #$0a      ; newline
        JSR $FFD2

        LDA #<message
        STA $2f
        LDA #>message
        STA $30
        JSR $FFD2      ; print message

        LDA #$01      ; input buffer
        STA $2f
        LDA #$ffb1
        STA $30
        JSR $FFCC      ; input

        LDA #$0a      ; newline
        JSR $FFD2

        LDA #$a4      ; wait for key press
        JSR $FFD2

        JMP start

message
        .text "Welcome to the Space Exploration Game!"
        .byte $0a, 0

        .end start
