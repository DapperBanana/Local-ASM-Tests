
; Random Sentence Generation using Markov Chains

START:
    LDA #MARKOV_TABLE
    STA CURRENT_STATE
    LDA #0
    STA RANDOM_SEED
    
LOOP:
    LDA CURRENT_STATE
    CLC
    ADC RANDOM_SEED
    AND #$7F
    STA INDEX
    LDA (CURRENT_STATE),Y
    STA RANDOM_SEED
    STA CURRENT_STATE
    CPY #4
    BEQ OUTPUT
    JMP LOOP

OUTPUT:
    LDA CURRENT_STATE
    JSR $FFD2
    JMP LOOP

MARKOV_TABLE:
    .byte TABLE1
    .byte TABLE2
    .byte TABLE3
    .byte TABLE4

TABLE1:
    .byte 'The', 'quick', 'brown', 'fox'
    
TABLE2:
    .byte 'jumps', 'over', 'the', 'lazy'
    
TABLE3:
    .byte 'dog'
    
TABLE4:
    .byte '!'
