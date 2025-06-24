
        .org $c000

START   lda TEXT          ; Load address of text in register A
        sta PTR
        ldx #0            ; Initialize index to 0

LOOP    lda (PTR),X       ; Load character from text
        beq END           ; If end of string, exit loop
        cmp #$23          ; Compare character to '#'
        bne NEXT_CHAR     ; If not '#', go to next character
        
        lda #0            ; Load null terminator in end of hash string
        sta HASH+1        ; Place null terminator in end of hash string
        sta (HASH),Y      ; Store hash string in result buffer
        iny               ; Increment result buffer index
        inc COUNT         ; Increment count of hashtags
        
NEXT_CHAR
        inx               ; Increment text index
        jmp LOOP          ; Continue looping

END     rts

COUNT   .byte 0
PTR     .word TEXT
HASH    .ds 32            ; Buffer to store extracted hashtags
TEXT    .asciiz "This is a #sample text with #hashtags #inside."

        .end
