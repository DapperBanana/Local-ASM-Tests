
        .org $0200

main    ldx #0                  ; Initialize index X to 0
        ldy #0                  ; Initialize index Y to 0
        
        ; Load first string into memory
load1   lda str1,x             ; Load character from first string
        sta $0400,y            ; Store character in memory
        inx                     ; Increment index X
        cpx #len1               ; Check if end of first string
        bne load1               ; Loop if not end of first string
        
        ; Load second string into memory
        ldx #0                  ; Reset index X to 0
load2   lda str2,x             ; Load character from second string
        sta $0500,y            ; Store character in memory
        inx                     ; Increment index X
        cpx #len2               ; Check if end of second string
        bne load2               ; Loop if not end of second string
        
        ; Sort first string
        ldx #0                  ; Reset index X to 0
sort1   lda $0400,x            ; Load character from first string
        cmp $0400+1,x          ; Compare character with next character
        bcc skip1              ; Skip if in order
        jsr swap               ; Swap characters if out of order
        ldx #0                 ; Reset index X to 0
        bne sort1              ; Continue sorting

        ; Sort second string
        ldx #0                 ; Reset index X to 0
sort2   lda $0500,x           ; Load character from second string
        cmp $0500+1,x         ; Compare character with next character
        bcc skip2             ; Skip if in order
        jsr swap              ; Swap characters if out of order
        ldx #0                ; Reset index X to 0
        bne sort2             ; Continue sorting

        ; Compare sorted strings
        ldx #0                 ; Reset index X to 0
compare lda $0400,x           ; Load character from first sorted string
        cmp $0500,x           ; Compare character with corresponding character from second sorted string
        bne not_anagram       ; Branch if characters do not match
        inx                   ; Increment index X
        cpx #len1              ; Check if end of strings
        bne compare           ; Loop if not end of strings

        ; Strings are anagrams
        lda #$01
        jmp done

not_anagram:
        lda #$00

done    rts

swap    ; Routine to swap characters in memory
        lda $0400,x
        sta temp
        lda $0400+1,x
        sta $0400,x
        lda temp
        sta $0400+1,x
        rts

        ; Data section
str1    .byte "listen",0
len1    = * - str1 - 1
str2    .byte "silent",0
len2    = * - str2 - 1
temp    .byte 0

        .org $fffc
        .word main
