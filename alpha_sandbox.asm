
    .org $1000

start:
    LDX #$00      ; Initialize word counter
    STX wordCount
    
    LDA $2000     ; Load the first character of the string
    BEQ end       ; If the string is empty, exit
    
loop:
    CMP #$20      ; Check if the current character is a space
    BEQ skipSpace ; If it is, skip to the next character
    
    INX           ; Increment the word counter
    
    JSR findWord  ; Call subroutine to find the end of the current word
    JSR countWord ; Call subroutine to count the current word
    
skipSpace:
    INX           ; Move to the next character
    LDA $2000, X  ; Load the next character
    BNE loop      ; If the character is not null, continue looping
    
end:
    RTS           ; Return from the program
    
findWord:
    INY           ; Move to the next character
    
    LDA $2000, Y  ; Load the next character
    BEQ endWord   ; If it is null, end the word
    
    CMP #$20      ; Check if the current character is a space
    BNE findWord  ; If it is not, continue searching for the end of the word
    
endWord:
    DEY           ; Move back to the last character of the word
    RTS           ; Return from the subroutine
    
countWord:
    DEY           ; Move back to the start of the word
    
countLoop:
    LDA wordCount ; Load the current word counter
    STA $3000, Y  ; Store the count in memory
    
    LDA $1000, Y  ; Load the current character of the word
    STA $4000, Y  ; Store the character in memory
    
    INY           ; Move to the next character
    LDA $2000, Y  ; Load the current character of the next word
    
    CPY $2000     ; Check if the end of the word has been reached
    BEQ endCount  ; If it has, end the counting
    
    JMP countLoop ; Otherwise, continue counting the word
    
endCount:
    LDA wordCount ; Load the current word count
    ADC #$01      ; Increment the word count by 1
    STA wordCount ; Store the updated word count
    
    RTS           ; Return from the subroutine
    
.wordCount: .res $01
.word: .res $20
    
    .end
