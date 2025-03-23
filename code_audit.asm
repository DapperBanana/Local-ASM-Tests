
    .org $0200

start:
    lda #0            ; Initialize the index register
    sta $00           ; Store it in memory location $00
    ldx #0            ; Initialize the offset for storing the modified string
    lda input,x       ; Load the first character of the input string
    beq end           ; If it's null, then terminate the program

loop:
    cmp #32           ; Check if the character is a space
    beq skip_punc     ; If yes, skip it
    cmp #44           ; Check if the character is a comma
    beq skip_punc     ; If yes, skip it
    cmp #46           ; Check if the character is a period
    beq skip_punc     ; If yes, skip it
    cmp #33           ; Check if the character is an exclamation mark
    beq skip_punc     ; If yes, skip it
    cmp #63           ; Check if the character is a question mark
    beq skip_punc     ; If yes, skip it
    cmp #40           ; Check if the character is a left parenthesis
    beq skip_punc     ; If yes, skip it
    cmp #41           ; Check if the character is a right parenthesis
    beq skip_punc     ; If yes, skip it
    cmp #10           ; Check if the character is a newline
    beq skip_punc     ; If yes, skip it
    
store_char:
    sta output,x      ; Store the character in the output string
    inx               ; Increment the offset
    lda input,x       ; Load the next character
    beq end           ; If it's null, then terminate the program
    jmp loop          ; Repeat the process

skip_punc:
    inx               ; Increment the offset
    lda input,x       ; Load the next character
    beq end           ; If it's null, then terminate the program
    jmp loop          ; Repeat the process

end:
    lda #0            ; Store null terminator at the end of the output string
    sta output,x
    rts

input:
    .asciiz "Hello, World! This is a test. (123)"
output:
    .blank 256

    .end start
