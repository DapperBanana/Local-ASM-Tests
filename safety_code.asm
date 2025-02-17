
    .text
    .org $0200

isIsogram:
    lda #$00        ; Initialize index to 0
    sta index
    
checkIsogramLoop:
    lda str, x     ; Load character at index x
    beq isIsogram     ; If end of string, then it is an isogram
    
    ; Check for repeated character
    lda index     ; Load current index
    clc
    adc #$01     ; Add 1 to index
    sta tempIndex     ; Store new index
    
    lda str, x     ; Load character at new index
checkRepeatingChar: 
    cmp str, x     ; Compare characters
    beq notIsogram     ; If characters are equal, not an isogram
    
    lda tempIndex     ; Load new index
    clc
    adc #$01    ; Add 1 to index
    sta tempIndex
    
    cmp #strlen    ; Compare new index with length of string
    beq isIsogram    ; If end of string, then it is an isogram
    
    jmp checkRepeatingChar    ; Repeat loop
    
notIsogram:
    lda #$00    ; Load 0 to accumulator
    rts    ; Return
    
isIsogram:
    lda #$01    ; Load 1 to accumulator
    rts    ; Return

    .data
str:    .asciiz "example"
strlen:    .byte 7    ; Length of string
index:    .byte 0    ; Index for comparing characters
tempIndex:    .byte 0    ; Temporary index for loop

    .end
