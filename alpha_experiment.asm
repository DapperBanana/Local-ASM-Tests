
START         LDX #SENTENCE_END     ; Load the end of the sentence into X register
              DEX                    ; Decrement X register to point to the last character
      
LOOP          LDA $4000, X           ; Load a character from memory into the accumulator
              CMP #' '               ; Compare the character with a space
              BEQ SPACE_FOUND        ; Branch if a space is found
              DEX                    ; Decrement X register to move to the previous character
              BNE LOOP               ; Branch back to LOOP if not at the start of the sentence
              JMP DONE               ; Jump to DONE if the start of the sentence is reached

SPACE_FOUND   INX                    ; Increment X register to skip the space
              STA $5000, Y           ; Store the word in reverse order
              DEY                    ; Decrement Y register to move to the previous word
              BPL LOOP               ; Branch back to LOOP if more words are remaining

DONE          RTS

SENTENCE_END  .HEX $4000              ; Address of the end of the sentence
