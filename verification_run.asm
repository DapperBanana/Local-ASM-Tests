
    .org $0200
    
start:
    lda string1,x    ; Load character from string1
    beq end          ; If end of string1, jump to end
    ora string2,x    ; OR with character from string2
    bne compare      ; If characters are equal, jumps to compare
    inc distance     ; Increment distance if characters are different
compare:
    inx              ; Increment index
    bra start        ; Continue looping

end:
    rts

distance:
    .byte $00        ; Variable to store the edit distance

string1:
    .ascii "hello"
    
string2:
    .ascii "world"
