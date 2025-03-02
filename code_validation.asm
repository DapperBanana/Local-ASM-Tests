
        .org $0200

start   lda input_ptr    ; Load the address of the input string
        cmp #0           ; Check if end of string is reached
        beq done

        lda (input_ptr),y ; Load the character at the current position
        sta temp,y       ; Store the character in temp
        iny              ; Increment Y to move to the next character
        cmp #0           ; Check if end of string is reached
        beq compare      ; If end of string is reached, compare characters

        jmp start        ; Continue looping through the string

compare lda temp,y       ; Load the character from temp
        cmp (input_ptr),y ; Load the character from the original string
        bne not_palindrome ; If characters don't match, it's not a palindrome

        dey              ; Decrement Y to move back to previous character
        inx              ; Increment X to move to next character

        cmp #0           ; Check if whole string has been compared
        bne compare      ; If not, keep comparing characters

        lda #1           ; Set flag to indicate palindrome
        jmp done

not_palindrome
        lda #0           ; Set flag to indicate not a palindrome

done    sta is_palindrome ; Store the result in is_palindrome
        rts

input_ptr .addr $0300     ; Address of the input string
temp     .ds 1            ; Temporary storage for character comparison
is_palindrome .ds 1       ; Flag to indicate if the string is a palindrome
