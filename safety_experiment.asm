
    ; Constants
    TERMINATOR = $00
    SPACE = $20
    HASHTAG = $23
    
    ; Variables
    textBuffer = $2000
    hashtagBuffer = $3000

    ; Initialize text buffer
    LDX #0
initLoop:
    STX textBuffer, X
    INX
    BNE initLoop

    ; Initialize hashtag buffer
    LDX #0
initHashtagBuffer:
    STX hashtagBuffer, X
    INX
    BNE initHashtagBuffer

    ; Load starting address of text buffer
    LDX #0
    LDY textBuffer

    ; Loop through text buffer
loop:
    LDA (Y), X
    BEQ done
    CMP HASHTAG
    BNE notHashtag
    JSR processHashtag
    
notHashtag:
    INX
    BNE loop

    ; Done
done:
    RTS

processHashtag:
    ; Copy hashtag to hashtag buffer
    STX hashtagBuffer
    LDX #1
copyLoop:
    LDA (Y), X
    STA hashtagBuffer, X
    INX
    CMP SPACE
    BEQ hashtagFound
    BNE copyLoop

hashtagFound:
    ; Print hashtag
    LDX #0
printLoop:
    LDA hashtagBuffer, X
    BEQ donePrinting
    ; Output the character
    ; You will need to implement this part based on your specific system
    INX
    BNE printLoop

donePrinting:
    ; Add terminating character to hashtag buffer
    STX hashtagBuffer, X

    ; Clear hashtag buffer
    LDX #0
clearHashtagBuffer:
    STX hashtagBuffer, X
    INX
    BNE clearHashtagBuffer
    
    RTS
