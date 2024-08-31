
        .addr      $2000
start:  lda        #$00         ; Initialize index register X to 0
        ldx        #$00
getNextWord:
        lda        sentence,x   ; Load character at current position
        beq        endOfSentence ; If we reached end of sentence, go to the end
        cmp        #" "          ; Compare character with space character
        beq        storeWordEnd  ; If we found a space, store the end of the word
        inx                     ; Increment index register
        bne        getNextWord   ; Continue to next character
storeWordEnd:
        sta        wordEnd,X     ; Store end of the word
        dex                     ; Decrement index register (X)
        bne        getNextWord   ; Continue to next character
endOfSentence:
        lda        wordEnd       ; Load last word's end into accumulator
        pha                     ; Push accumulator onto the stack
        lda        #$00          ; Initialize index register X to 0
        ldx        wordEnd       ; Load last word's end into index register X
getPrevWord:
        lda        wordEnd,x     ; Load character at current position
        cmp        #" "          ; Compare character with space character
        beq        storeWordStart ; If we found a space, store the start of the word
        dex                     ; Decrement index register (X)
        bne        getPrevWord   ; Continue to previous character
storeWordStart:
        sta        wordStart,X   ; Store start of the word
        dey                     ; Decrement index register (Y)
        bne        getPrevWord   ; Continue to previous character
        lda        #$00          ; Initialize index register X to 0
        ldx        wordStart     ; Load start of the first word
displayWords:
        lda        wordStart,x   ; Load character at current position
        beq        endOfWords    ; If we reached end of words, go to the end
        jsr        $ffd2         ; Print character to screen (Assuming output is directed to screen)
        inx                     ; Increment index register
        bne        displayWords  ; Continue to next character
endOfWords:
        pla                     ; Pop last word's end from the stack
        cmp        #$00          ; Compare end of last word with null terminator
        beq        endOfProgram  ; If we reached the end of the sentence, end the program
        jsr        $ffd2         ; Print space character to separate words
        bra        getPrevWord   ; Continue with previous word
endOfProgram:
        rts                     ; Return from subroutine

sentence:   .byte      "Hello world! This is a sample sentence.",$00
wordStart:  .byte      $00
wordEnd:    .byte      $00
