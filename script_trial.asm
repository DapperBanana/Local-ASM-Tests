
    LDA #0        ; Initialize word count to 0
    STA word_count
    LDA #0        ; Initialize index to 0
    STA index
    
loop:
    LDA message, X    ; Load character at current index into A register
    CMP #0            ; Check if end of string
    BEQ end
    
    CMP #" "          ; Check if current character is a space
    BEQ increment
    
    INX               ; Increment index
    JMP loop
    
increment:
    LDA word_count
    CLC
    ADC #1            ; Increment word count
    STA word_count
    INX               ; Move to next character
    JMP loop
    
end:
    LDA word_count    ; Display word count
    JSR display_count
    BRK
    
display_count:
    ; Code to display word count (e.g. store in memory, print to screen, etc.)
    RTS
    
message:
    .byte "hello world", 0  ; Input string

word_count:
    .byte 0                ; Word count variable
index:
    .byte 0                ; Index variable
