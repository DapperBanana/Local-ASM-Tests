
str1   .asciiz    "apple"
str2   .asciiz    "appetizer"
str3   .asciiz    "apprehension"
str4   .asciiz    "approve"

start:
        ldx #0              ; Initialize index to 0
        lda str1,x          ; Load first character of the first string
        sta prefix,x        ; Store it in the prefix string
        
compare:
        lda str1,x          ; Load character from the first string
        cmp str2,x          ; Compare with character from the second string
        bne done            ; If not equal, done
        
        inx                 ; Increment index
        cmp #0               ; Check for null terminator
        beq done            ; If reached end of string, done
        jmp compare         ; Loop back to compare next character

done:
        cld                 ; Clear decimal mode
        sta prefix+1,x      ; Store null terminator in prefix string
        
        ; Print result
        ldx #0              ; Initialize index to 0
print:
        lda prefix,x        ; Load character from prefix string
        beq end             ; If null terminator, end
        jsr $ffd2           ; Print character to screen
        inx                 ; Increment index
        jmp print           ; Loop back to print next character

end:
        rts

prefix  .blkb 10            ; Buffer to store common prefix
