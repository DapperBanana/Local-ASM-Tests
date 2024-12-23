
; Simple Random Sentence Generator in 6502 Assembly
START    LDA #$00        ; Initialize random seed
         STA SEED       
         LDX #$00        ; Initialize loop counter
LOOP     LDA RANDOM,X    ; Load random number from lookup table
         STA INDEX       ; Store index for sentence selection
         LDA SENTENCES,X ; Load sentence from lookup table
         JSR PRINT       ; Print sentence
         INX             ; Increment loop counter
         CPX #NUM_SENTENCES ; Check if all sentences have been printed
         BNE LOOP        ; If not, loop back to pick another sentence
END      BRK             ; End program

PRINT    LDY #$00        ; Initialize counter
PRINT_LOOP LDA (INDEX),Y ; Load character from sentence
          CMP #$00       ; Check for end of sentence
          BEQ EOL        ; If end of sentence, exit loop
          JSR $ffd2      ; Print character to screen
          INY            ; Increment counter
          JMP PRINT_LOOP ; Loop back to print next character
EOL       RTS            ; Return from subroutine

; Random number lookup table
RANDOM   .byte $0a, $12, $3f, $26, $5e, $ff, $2b, $1a
         .byte $38, $49, $67, $78, $4c, $1e, $02, $a5

; Sentences lookup table
SENTENCES .byte "This is a random sentence.$00"
          .byte "Assembly programming is fun!$00"
          .byte "I love coding in 6502 assembly.$00"

NUM_SENTENCES = * / 2
INDEX       .byte $00
SEED        .byte $00

         .org $fffa
         .word START
