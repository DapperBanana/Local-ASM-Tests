
        .org $0200
start   LDX #$00                ; Initialize index
loop    LDA input,X             ; Load character from input string
        CMP #$41                ; Check if character is a punctuation (ASCII code for '@')
        BEQ remove_punctuation  ; Branch if character is a punctuation
        CMP #$5B                ; Check if character is a punctuation (ASCII code for '_')
        BEQ remove_punctuation  ; Branch if character is a punctuation
        CMP #$61                ; Check if character is a punctuation (ASCII code for '`')
        BEQ remove_punctuation  ; Branch if character is a punctuation
        CMP #$7B                ; Check if character is a punctuation (ASCII code for '{')
        BEQ remove_punctuation  ; Branch if character is a punctuation
        STA output,X            ; Store character in output string
        INX                     ; Increment index
        INY                     ; Increment index
        BNE loop                ; Repeat loop
remove_punctuation:
        INX 
        INY
        BNE loop
input   .asciiz "Hello, World!"  ; Input string with punctuation
output  .ds 20                   ; Output string without punctuation

        .end start
