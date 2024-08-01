
ORG $0200     ; Starting address of program

start:
    LDX #$00    ; Initialize X as string index
    LDY #$01    ; Initialize Y as punctuation flag (0 = no punctuation, 1 = punctuation)
    STY punctuation_flag

loop:
    LDA input_string,X    ; Load character from input string
    CMP #'.'              ; Compare character with '.'
    BEQ skip_punctuation  ; Branch if character is punctuation
    CMP #'!'              ; Compare character with '!'
    BEQ skip_punctuation
    CMP #'?'              ; Compare character with '?'
    BEQ skip_punctuation
    CMP #','              ; Compare character with ','
    BEQ skip_punctuation
    CMP #';'              ; Compare character with ';'
    BEQ skip_punctuation
    CMP #':'              ; Compare character with ':'
    BEQ skip_punctuation
    CMP #'"'              ; Compare character with '"'
    BEQ skip_punctuation
    CMP #'('              ; Compare character with '('
    BEQ skip_punctuation
    CMP #')'              ; Compare character with ')'
    BEQ skip_punctuation
    CMP #0                ; Check for null terminator
    BEQ end_of_string

    STA output_string,X   ; Store character in output string
    INX                   ; Increment X
    BNE loop              ; Branch to loop (avoid page boundary issue)

skip_punctuation:
    INX                   ; Increment X
    LDY #$01              ; Set punctuation flag to 1
    BNE loop              ; Branch to loop (avoid page boundary issue)

end_of_string:
    LDY #$00              ; Clear punctuation flag
    STY output_string,X   ; Add null terminator to output string

    RTS                   ; Return from subroutine

input_string:
    .ASCII "Hello, World!"   ; Input string with punctuation

output_string:
    .BLKW 20               ; Allocate space for output string

punctuation_flag:
    .BYTE $00              ; Punctuation flag (0 = no punctuation, 1 = punctuation)

    .END                   ; End of program
