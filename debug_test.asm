
.org $0200

LDA #$00    ; Initialize index for sentence string
STA index

LDA #$FF    ; Initialize index for reversed sentence string
STA revIndex

LDX #$00    ; Initialize index for current word
STX currentWord

LDY #$00    ; Initialize index for current character

loadChar:
    LDA sentence, Y  ; Load the character at current index
    CMP #0          ; Check if the character is null
    BEQ end         ; If null, finish
    
    CMP #" "        ; Check if the character is a space
    BEQ copyWord    ; If space, move to next word
    
    INY             ; Increment character index
    JMP loadChar    ; Load next character

copyWord:
    STY len          ; Store length of current word
    LDA len
    DEX              ; Decrement X as current word length
    TAY              ; Copy length to Y
    
    LDX revIndex     ; Load index for reversed sentence string
    TXS              ; Transfer X to stack pointer
    
copyChar:
    LDX currentWord  ; Load index for current word
    TXA              ; Transfer X to A
    STA revSentence, X   ; Store current character in reversed sentence
    INX              ; Increment index for reversed sentence
    LDA sentence, Y  ; Load character in current word
    DEX              ; Decrement index
    DEY              ; Decrement length
    BNE copyChar     ; Copy the characters of the word

    INC currentWord  ; Move to next word
    INY              ; Increment index for next character
    
    LDX revIndex  ; Load index for reversed sentence string
    LDA #" "      ; Store space between words
    STA revSentence, X
    DEX           ; Decrement index

    LDA currentWord  ; Load index for current word
    SEC
    SBC len          ; Calculate new index for current word
    STA currentWord

    LDX revIndex   ; Load index for reversed sentence string
    STX revIndex   ; Store new index for reversed sentence string
    JMP loadChar   ; Load next character

end:
    BRK
    
len: .BYTE 0     
index: .BYTE 0
revIndex: .BYTE 0
currentWord: .BYTE 0
sentence: .BYTE "This is a sample sentence to be reversed! ", 0
revSentence: .BLKW 100

