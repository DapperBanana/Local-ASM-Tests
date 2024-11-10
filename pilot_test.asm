
; Remove all punctuation from a given string

        .org $0200

STRING  .asciiz "Hello, world! This is a test."
RESULT  .ds $20

START   lda #<STRING      ; Load low byte of STRING address
        sta $fb           ; Store it in $fb
        lda #>STRING      ; Load high byte of STRING address
        sta $fc           ; Store it in $fc

        ldx #0            ; Initialize index to 0

LOOP    lda ($fb),X       ; Load character from STRING
        cmp #','          ; Check if it is a comma
        beq SKIP_PUNCT    ; If it is a comma, skip it
        cmp #'.'          ; Check if it is a period
        beq SKIP_PUNCT    ; If it is a period, skip it
        cmp #'!'          ; Check if it is an exclamation mark
        beq SKIP_PUNCT    ; If it is an exclamation mark, skip it
        cmp #'"'          ; Check if it is a double quote
        beq SKIP_PUNCT    ; If it is a double quote, skip it
        sta RESULT,X      ; Store character in result
        inx               ; Increment index
SKIP_PUNCT
        inx               ; Increment index for next character
        lda ($fb),X       ; Load next character from STRING
        cmp #0            ; Check for end of string
        beq DONE          ; If end of string, done
        jmp LOOP          ; Otherwise, continue loop

DONE    ldx #0            ; Null-terminate result string
        sta RESULT,X
        rts               ; Return to caller

        .end
