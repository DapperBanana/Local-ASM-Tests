
    .org $0200

    ; Strings to compare
str1    .byte "listen",0
str2    .byte "silent",0

    ; Frequency arrays
freq1   .res 26
freq2   .res 26

start   lda #$00            ; Initialize index to 0
        sta $fb             ; Save index to zero page
        ldx #$00            ; Initialize frequency index to 0
        stx $fc             ; Save frequency index to zero page

loop    lda str1,x          ; Load character from string 1
        beq done            ; Branch if end of string
        jsr count_freq1     ; Count frequency of character in string 1

        lda str2,x          ; Load character from string 2
        jsr count_freq2     ; Count frequency of character in string 2

        inx                 ; Increment index
        lda $fb
        clc
        adc #$01
        sta $fb             ; Save index to zero page
        bne loop            ; Branch back to loop 

done    jsr compare_freqs    ; Compare frequency arrays

        ; Exit program
        rts

count_freq1
        cmp #"a"            ; Compare character to 'a'
        bcc not_alpha1       ; Branch if not alphabetical
        cmp #"z"            ; Compare character to 'z'
        bcs not_alpha1       ; Branch if not alphabetical

        sec
        sbc #"a"            ; Calculate frequency index
        sta $fd

        lda freq1,x         ; Load current frequency count
        clc
        adc #$01            ; Increment frequency count
        sta freq1,x         ; Save updated count

        rts

not_alpha1
        rts

count_freq2
        cmp #"a"            ; Compare character to 'a'
        bcc not_alpha2       ; Branch if not alphabetical
        cmp #"z"            ; Compare character to 'z'
        bcs not_alpha2       ; Branch if not alphabetical

        sec
        sbc #"a"            ; Calculate frequency index
        sta $fd

        lda freq2,x         ; Load current frequency count
        clc
        adc #$01            ; Increment frequency count
        sta freq2,x         ; Save updated count

        rts

not_alpha2
        rts

compare_freqs
        ldx #$00            ; Initialize index to 0

loop2   lda freq1,x
        cmp freq2,x         ; Compare frequencies
        bne not_anagrams    ; Branch if not equal

        inx                 ; Increment index
        cpx #$1A            ; Check if end of frequency array
        bne loop2           ; Branch back to loop2

        rts

not_anagrams
        lda #"0"            ; Print '0' for not anagrams
        jsr $ffd2           ; Output character
        rts
