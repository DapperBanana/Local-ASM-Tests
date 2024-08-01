
        .org    $1000       ; Start address of the program

start   lda     $2000       ; Load the first character of the string
        beq     end         ; If the character is null, end the program
        lda     $2001       ; Load the second character of the string
        beq     end         ; If the character is null, end the program
        jsr     checkIsogram ; Check if the current pair of characters are the same
        bcs     notIsogram  ; If they are the same, it is not an isogram
        
        inx                 ; Increment X to move to the next character
        inx                 ; Increment again to move to the next character
        jmp     start       ; Continue checking the next pair of characters
          
notIsogram:
        lda     #1          ; Set flag to indicate that it is not an isogram
        rts

checkIsogram:
        cmp     ($00),x     ; Compare the current characters
        beq     isogram     ; If they are the same, it is an isogram
        clc
        rts

isogram:
        sec
        rts

end:    lda     #0          ; Set flag to indicate that it is an isogram
        rts

        .org    $2000       ; Start address of the input string
        .text   "hello"     ; Input string to check if it is an isogram
