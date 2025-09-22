
    .org    $0200

start:
    LDX     #0             ; Initialize index register to 0
    LDY     #$0300         ; Load the starting address of the input string
loop:
    LDA     (Y),X          ; Load character from memory
    CMP     #$20           ; Check for end of string
    BEQ     end            ; Exit loop if end of string
    CMP     #$21           ; Check for punctuation characters
    BCC     skip           ; Skip the punctuation characters
    CMP     #$2F
    BCS     skip
    CMP     #$3A
    BCC     skip
    CMP     #$3F
    BCS     skip
    CMP     #$40
    BCC     skip
    CMP     #$5B
    BCS     skip
    CMP     #$5F
    BCC     skip
    CMP     #$60
    BCS     skip
    CMP     #$7B
    BCC     skip
    CMP     #$7F
    BCS     skip
    STA     $0400,X        ; Store non-punctuation character in output string
    INX                   ; Increment index register
skip:
    INX                   ; Increment index register
    JMP     loop           ; Continue looping
end:
    STX     $0400          ; Store null terminator at end of output string
    BRK

    .org    $FFFA
    .word   start           ; Reset vector
    .word   start           ; IRQ vector
    .word   start           ; NMI vector
