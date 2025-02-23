
    .org $0200

start:
    LDX #0          ; Initialize index for input string
    LDY #0          ; Initialize index for output string

countWords:
    LDA input,X     ; Load character from input string
    CMP #0          ; Check for end of string
    BEQ end         ; If end of string, exit loop
    CMP #32         ; Check for space character
    BEQ nextWord    ; If space, move to next word

    INX             ; Move to next character in input string
    JMP countWords  ; Continue counting words

nextWord:
    STX currentChar ; Save index of first character of new word
    LDX #0          ; Initialize index for current word
    
checkCurrentWord:
    LDA output,X    ; Load character from output string
    CMP #0          ; Check for end of string
    BEQ newWord     ; If end of output string, new word
    CMP input,currentChar,X  ; Compare characters of input and output strings
    BNE notMatch    ; If characters don't match, go to next word
    INX             ; Move to next character in current word
    JMP checkCurrentWord ; Continue checking characters

notMatch:
    INX             ; Move to next character in output string
    JMP checkCurrentWord ; Continue checking characters

newWord:
    LDA output+1    ; Load next free space in output string
    CMP #0          ; Check for end of string
    BEQ end         ; If end of output string, exit loop
    STA output,X    ; Store character to output string
    LDY #0          ; Initialize counter for number of occurrences of word
    JSR increaseCounter ; Increase counter for the new word
    PHA             ; Save counter value
    LDX currentChar ; Load index of start of current word
    INX             ; Move to first character of word
    STX currentChar ; Save index of word
    PLA             ; Restore counter value
    TAX             ; Load counter into X register
    INY             ; Move to next free space in output string
    JMP countWords  ; Continue counting words

increaseCounter:
    LDA wordCounter,Y ; Load counter for the word
    INY                 ; Move to next word counter
    STA wordCounter,Y   ; Store updated counter
    RTS             

end:
    BRK            ; End of program

input:
    .byte "apple orange banana apple banana apple apple orange",0
    .byte " ",0

output:
    .byte "apple",0
    .byte "banana",0
    .byte "orange",0
    .byte 0

wordCounter:
    .byte 0,0,0

currentChar:
    .byte 0

    .end
