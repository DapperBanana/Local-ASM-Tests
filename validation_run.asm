
ORG $8000

; Load the first string into memory starting at address $2000
LDA #$20
STA $FC
LDA #$00
LDX #$00

load_string1:
    LDA string1,X
    STA $2000,X
    INX
    CPX #length1
    BNE load_string1

; Load the second string into memory starting at address $3000
LDA #$30
STA $FD
LDA #$00
LDX #$00

load_string2:
    LDA string2,X
    STA $3000,X
    INX
    CPX #length2
    BNE load_string2

; Check if the two strings are anagrams
LDA #$00
LDX #$00

check_anagram:
    LDA $2000,X
    STA temp1

    LDA $FC
    INX
    STA $FC
    LDA temp1

    LDX #$00
    LDA $3000,X
    STA temp2

    LDA $FD
    INX
    STA $FD
    LDA temp2

    CMP temp1
    BNE not_anagram

    CPX #length2
    BNE check_anagram

    LDA #$01   ; Strings are anagrams
    JMP end

not_anagram:
    LDA #$00   ; Strings are not anagrams

end:
    STA result

loop:
    JMP loop
