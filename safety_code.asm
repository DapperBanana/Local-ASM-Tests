
        .text
start:
        lda #0            ; Load accumulator with null terminator
        sta dest         ; Set the destination string terminator

        ldx #0            ; Initialize source index to 0

loop:
        lda source,X      ; Load character from source string
        beq end           ; If we reach the end of the string, exit loop

        cmp #'!'          ; Check if character is a punctuation mark
        beq next_char

        cmp #'?'          
        beq next_char

        cmp #','
        beq next_char

        cmp #'.'
        beq next_char

        cmp #';'
        beq next_char

        cmp #':'      
        beq next_char

        cmp #'('
        beq next_char

        cmp #')'
        beq next_char

        cmp #'"'          ; Check for quotation marks
        beq next_char

        cmp #39           ; Check for apostrophe

        bne copy_char     ; If not a punctuation mark, copy character

next_char:
        inx               ; Move to next character in source string
        bra loop          ; Repeat loop

copy_char:
        sta dest,X        ; Copy character to destination string
        inx               ; Move to next character in destination string
        bra loop          ; Repeat loop

end:
        rts

        .data
source: .asciiz "Hello, World! This is a sample string."
dest:   .space 50       ; Destination string with space for 50 characters
