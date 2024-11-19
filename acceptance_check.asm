
is_isogram:
    LDX #0          ; Initialize index to 0
loop:
    LDA str, X      ; Load character from string into A register
    BEQ is_isogram  ; If end of string is reached, return isogram
    STA $00         ; Store current character for comparison
    LDY #0          ; Initialize inner loop index to 0
inner_loop:
    INY             ; Increment inner loop index
    LDA str, Y      ; Load next character from string into A register
    BEQ not_repeated_char  ; If end of string is reached, break inner loop
    CMP $00         ; Compare current character with stored character
    BEQ not_isogram ; If characters are the same, string is not an isogram
    BNE inner_loop  ; If characters are different, continue inner loop
not_repeated_char:
    INX             ; Increment outer loop index
    JMP loop        ; Continue outer loop
not_isogram:
    LDA #$00        ; Set result to 0, indicating not an isogram
    RTS             ; Return from subroutine
is_isogram:
    LDA #$01        ; Set result to 1, indicating is an isogram
    RTS             ; Return from subroutine

str:
    .asciiz "example"  ; Input string to check for isogram
