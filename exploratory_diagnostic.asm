
; Check if a given string is a valid JSON

    .text
    .globl _start

_start:
    lda #0              ; Initialize counter
    sta counter
    lda #0              ; Initialize flag
    sta is_valid_json

loop:
    lda str, x         ; Load character at index x
    beq end            ; If end of string, exit loop
    
    cmp #'{'           ; Check if character is an opening curly brace
    beq increment      ; If opening curly brace, increment counter
    
    cmp #'}'           ; Check if character is a closing curly brace
    beq decrement      ; If closing curly brace, decrement counter
    
    inx                ; Increment index
    bne loop           ; Branch to loop
    
increment:
    lda counter        ; Load counter
    clc                ; Clear carry
    adc #1             ; Increment counter
    sta counter        ; Store counter
    bne loop           ; Branch to loop
    
decrement:
    lda counter        ; Load counter
    sec                ; Set carry
    sbc #1             ; Decrement counter
    sta counter        ; Store counter
    bne loop           ; Branch to loop

end:
    lda counter        ; Load final counter value
    beq valid_json     ; If counter is 0, it is a valid JSON
    
invalid_json:
    lda #0             ; Set flag to invalid
    sta is_valid_json
    jmp finish         ; Jump to finish
    
valid_json:
    lda #1             ; Set flag to valid
    sta is_valid_json
    
finish:
    ; Do something with the flag value stored in is_valid_json
    
    .data
str:    .asciiz "{ \"name\": \"Alice\", \"age\": 30 }"   ; Example JSON string
counter: .byte 0        ; Counter for opening and closing curly braces
is_valid_json: .byte 0  ; Flag to store if the string is a valid JSON
