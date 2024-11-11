
        .org $1000

start   lda message1,x     ; Load characters from the first string
        cmp #0             ; Check if the character is NULL terminator
        beq end            ; If it is, exit the loop

        sta current_char   ; Store the character in current_char
        lda message2,y     ; Load characters from the second string
        cmp #0             ; Check if the character is NULL terminator
        beq end            ; If it is, exit the loop

        sta next_char      ; Store the character in next_char

        cmp current_char   ; Compare the characters
        beq next_chars     ; If they are equal, move to the next characters

        ; Calculate the edit distance
        inc edits          ; Increment the edit distance

next_chars:
        inx                ; Move to the next character in the first string
        iny                ; Move to the next character in the second string
        jmp start          ; Repeat the loop

end     lda edits          ; Load the edit distance into the accumulator
        rts                ; Return from the subroutine

message1 .byte "kitten",0  ; First string
message2 .byte "sitting",0 ; Second string
current_char .byte 0
next_char .byte 0
edits   .byte 0            ; Edit distance counter

        .end
