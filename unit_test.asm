
; Reverse the order of words in a sentence using 6502 Assembly

          .org   $0200

START     lda    #$00         ; Initialize index register
          sta    $00           ; Clear temporary storage
          lda    #$ff         ; Initialize pointer to end of sentence
          sta    $01           ; End of sentence marker
          ldx    #$ff         ; Initialize pointer to start of sentence
          stx    $02           ; Start of sentence marker

LOOP      lda    $01,X         ; Load character from end of sentence
          cmp    #$20         ; Check for space character
          beq    FOUND_SPACE   ; If found, skip to reverse word
          dex                    
          bpl    LOOP          ; Continue looping until start of sentence
          
          lda    $00           ; Load temporary storage
          sta    $03           ; Save current word
          lda    $02           ; Load start of sentence marker
          sta    $00           ; Update temporary storage
          lda    #$ff         ; Reset pointer to end of sentence
          sta    $01           ; Update end of sentence marker
          
FOUND_SPACE
          lda    $03           ; Load reversed word
          sta    $02           ; Save reversed word into start of sentence
          inx                    ; Increment pointer to start of next word
          cpx    $01           ; Check for end of sentence
          bne    LOOP          ; If not, continue looping
          
          lda    $01           ; Load last word from end of sentence
          sta    $02           ; Save last word into start of sentence

END       brk

          .org   $FDFF
          .word  START
