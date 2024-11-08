
;************************************
; Longest Common Prefix Program
;************************************

.data
strings: .asciiz "apple","app","apartment","application"
numStrings: .word 4

.text
.globl _start
_start:
    
    lda numStrings            ; Load the number of strings
    cmp #0                    ; Compare with 0 to check if there are any strings
    beq end                   ; If there are no strings, end the program

    lda #0                    ; Initialize index to 0
    sta currentIndex          ; Store current index in currentIndex variable
    
    ldx #0                    ; Initialize index to 0 for iterating over strings
    lda strings,x             ; Load the first string
nextString:
    sta currentString         ; Store the current string in currentString variable
    
    lda currentIndex          ; Load the current index
    clc
    adc #1                    ; Increment the current index
    sta currentIndex          ; Store the new current index
    
    inc x                     ; Increment x for accessing the next string
    lda strings,x             ; Load the next string
    cmp #0                    ; Check if we have reached the end of strings
    bne nextString            ; If not, process the next string
    
    ldx #0                    ; Initialize index to 0 for comparing characters in strings
nextChar:
    
    lda currentString,x       ; Load the character from the first string
    
    ldx #1
nextStringChar:
    lda strings,x             ; Load the next string
    cmp #0                    ; Check if we have reached the end of strings
    beq endLoop               ; If we have reached the end, end the loop
    
    cmp currentString,x       ; Compare the character with the current string character
    beq match                 ; If characters match, continue to next character
    
endLoop:
    jmp printResult           ; Jump to printResult if no match is found
    
match:
    inc x                     ; Increment x for comparing with the next character
    jmp nextStringChar        ; Continue comparing characters
    
printResult:
    lda currentIndex          ; Load the current index
    cmp #1                    ; Check if there is only one string
    ble end                   ; If there is only one string, end the program
    
    lda currentIndex          ; Load the current index
    dec currentIndex          ; Decrement to the last valid index
    
    ldx #0                     ; Initialize index to 0 for printing the common prefix
printChar:
    
    lda currentString,x        ; Load the character from the first string
    
    ldx #1
printStringChar:
    lda strings,x              ; Load the next string
    cmp #0                     ; Check if we have reached the end of strings
    beq endProgram             ; If we have reached the end, end the program
    
    cmp currentString,x        ; Compare the character with the current string character
    bne endProgram              ; If characters do not match, end the program
    
    jsr $ffd2                  ; Print the character
    inc x                      ; Increment x for printing the next character
    jmp printStringChar        ; Continue printing characters
    
endProgram:
    jmp end                    ; End the program

end:
    ; End of program
