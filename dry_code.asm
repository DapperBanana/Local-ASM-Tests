
        .org $1000

start:
        lda input ; load the first character of the input string
        beq end ; check for end of string
        cmp #"a" ; compare with 'a'
        bcc next ; skip conversion if character is before 'a'
        cmp #"z" ; compare with 'z'
        bcs next ; skip conversion if character is after 'z'
        sec
        sbc #$20 ; convert lowercase letter to uppercase letter
        sta output ; store the converted character in output string
next:
        inx ; increment index to next character
        lda input, x ; load next character of the input string
        bne start ; loop until end of string
end:
        lda #$00 ; add null terminator to end of output string
        sta output, x
        rts

input:
        .text "hello, world"
output:
        .text ""

        .end
