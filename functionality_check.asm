
; Hashtag extractor program in 6502 Assembly

RESET = $FFFC
VECTOR = $FFFE

.org RESET
    jmp START

.org VECTOR
    .word START

START:
    lda #$00              ; Initialize variables
    sta index
    lda #$01
    sta lastCharIsSpace

LOOP:
    lda text, x           ; Load next character from text
    beq DONE              ; If end of string, exit loop
    cmp #" "              ; Check if character is a space
    beq NEXT_CHAR         ; If space, go to next character

    cmp #"#"              ; Check if character is a hashtag
    bne NEXT_CHAR
    lda #$01              ; If hashtag found, set flag to true
    sta isHashtag
    jmp NEXT_CHAR

NEXT_CHAR:
    inx
    jmp LOOP

DONE:
    lda isHashtag        ; Check if last character was a hashtag
    beq END_PROGRAM       ; If not, end program

    lda #$00             ; Clear flag
    sta isHashtag

END_PROGRAM:
    rts

.text:
    .asciiz "This is a #test of the hashtag #extractor program"

.index: 
    .ds 1                 ; Index variable
.isHashtag:
    .ds 1                 ; Flag to check if current character is a hashtag
.lastCharIsSpace:
    .ds 1                 ; Flag to check if the last character was a space
