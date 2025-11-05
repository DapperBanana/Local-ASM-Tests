
        .org $0600

string1  .text "ABCD"
string2  .text "ACD"

result   .block 1       ; Variable to store the result

start:
        lda #0          ; Initialize result to zero
        sta result
        ldx #0          ; Initialize counter for string1 index

loop1:
        lda string1,x   ; Load character from string1
        cmp #0           ; Check for null terminator
        beq done        ; If null terminator, end of string1

        ldy #0          ; Initialize counter for string2 index

loop2:
        lda string2,y   ; Load character from string2
        cmp #0           ; Check for null terminator
        beq next_char   ; If null terminator, check next character in string1

        cmp string1,x   ; Compare character from string1 with character from string2
        beq match       ; If characters match, increment result and indexes
        iny
        bne loop2

match:
        inc result      ; Increment result
        iny             ; Increment string2 index
        bne loop2

next_char:
        inx             ; Increment string1 index
        bne loop1

done:
        rts

        .end
