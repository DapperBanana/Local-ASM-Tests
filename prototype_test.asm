
LDX #0           ; Initialize index for reading the sentence
LDA sentence,X   ; Load the first character of the sentence
CMP #0            ; Check for end of the sentence
BEQ end

init:
   LDA #0       ; Initialize variables
   STA wordLength
   STA longestWordLength
   
loop:
   BEQ nextWord ; If current character is space, move to next word
   INC wordLength ; Increment word length
   INX            ; Move to the next character
   LDA sentence,X ; Load the next character
   CMP #0         ; Check for end of the sentence
   BNE loop       ; Continue processing the sentence

nextWord:
   LDA wordLength        ; Load the length of the current word
   CMP longestWordLength ; Compare with the length of the longest word found so far
   BCC updateLongest    ; If current word is longer, update longest word length

updateLongest:
   STA longestWordLength ; Update longest word length
   LDY #0               ; Reset index for the current word
   LDA #0               ; Reset word length
   INX                  ; Move to the next character after the space
   LDA sentence,X       ; Load the next character after the space
   CMP #0               ; Check for end of the sentence
   BEQ end              ; If end of the sentence, exit the program
   JMP loop             ; Continue processing the next word

end:
   ; The length of the longest word is stored in longestWordLength variable

sentence:
   .asciiz "This is a sample sentence" ; Input sentence

wordLength:
   .byte 0

longestWordLength:
   .byte 0
