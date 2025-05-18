
.word_counts    .block  26       ; array to store word counts
.buffer         .block  80       ; input string buffer

Start:
    LDX #0                      ; initialize loop counter
    LDY #0                      ; initialize word counter
    JSR ReadString              ; read input string into buffer

CountWords:
    LDA buffer,X                ; get character from buffer
    BEQ End                     ; end of string

    CMP #" "                    ; check if character is space
    BEQ SkipSpace               ; skip spaces
    INY                         ; increment word counter
    STA buffer,X                ; replace space with null terminator

SkipSpace:
    INX                         ; move to next character
    BNE CountWords              ; repeat loop
    JMP CountWords              ; repeat loop

End:
    STY #word_counts            ; store total word count

PrintCounts:
    LDX #0                      ; initialize loop counter
PrintLoop:
    LDA word_counts,X           ; get count of word
    JSR PrintDigit              ; print count
    INX                         ; move to next word
    CPX #26                     ; check if end of word counts array
    BNE PrintLoop               ; repeat loop

    RTS

ReadString:
    LDA #buffer                 ; load buffer pointer
    STA $D4                     ; set the input buffer
    LDY #80                     ; load buffer length
    LDA #8                      ; set input routine
    STA $D2
    STA $D2
    JSR $FFBD                   ; call Kernal routine to input a string
    RTS

PrintDigit:
    CMP #$0A                    ; check if digit is newline character
    BEQ Newline                 ; print newline
PrintLoop:
    CMP #$00                    ; check if end of string
    BEQ EndPrint                ; end of string
    SEC
    SBC #$30                    ; convert ASCII character to decimal digit
    JSR $FFD2                   ; call Kernal routine to output a character
    CLC
    INX                         ; move to next digit
    JMP PrintDigit

Newline:
    LDA #$0D                    ; load carriage return character
    JSR $FFD2                   ; call Kernal routine to output a character
    LDA #$0A                    ; load line feed character
    JMP PrintLoop

EndPrint:
    RTS
