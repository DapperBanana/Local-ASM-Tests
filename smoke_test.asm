
        .org    $0200

str1    .asciiz "Hello"
str2    .asciiz "World"
result  .res    32

start   lda     #$00            ; Initialize index
        sta     $00
         
loop    lda     str1, x         ; Load character from first string
        beq     done            ; If end of string, exit loop
        sta     $01             ; Store character in temporary variable

        ldx     #$00            ; Reset index for second string

inner   lda     str2, x         ; Load character from second string
        beq     check           ; If end of string, check characters
        cmp     $01             ; Compare character to first string
        beq     found           ; If characters match, store in result
        inx                     ; Increment index
        bne     inner

check   inx
        bne     loop

done    brk

found   lda     $01             ; Load found character
        sta     result, x       ; Store character in result
        inx
        lda     #$00
        sta     result, x
        inx
        jmp     loop

        .end    start
