
        .text
        lda #0       ; set max_length to 0
        sta max_length
        lda #0       ; set current_length to 0
        sta current_length
        lda #0       ; set current_number to 0
        sta current_number
        lda list     ; load the first number from the list
loop:   cmp current_number  ; compare current_number with the current list item
        beq increment        ; if they are the same, increment current_length
        lda current_length  ; check if current_length is greater than max_length
        cmp max_length
        bgt update_max_length   ; if current_length is greater, update max_length
        sta current_length
        lda list            ; load new list item
        sta current_number
        jmp next
increment:
        inc current_length  ; increment the current_length
next:
        lda list            ; load the next list item
        beq done            ; if list item is 0, we have reached the end
        jmp loop            ; otherwise, loop back
update_max_length:
        lda current_length  ; update max_length with current_length
        sta max_length
        jmp next
done:
        lda max_length     ; load the final max_length
        ; now max_length contains the length of the longest consecutive sequence
