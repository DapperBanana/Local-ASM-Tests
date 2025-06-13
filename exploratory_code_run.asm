
        .org $2000

START   LDX #0          ; Initialize index register to 0
LOOP    LDA INPUT,X     ; Load the next character from the input string
        CMP #0          ; Check if we have reached the end of the string
        BEQ END         ; If end of string, exit loop

        CMP #60         ; Check if character is '<' (ASCII value for '<' is 60)
        BNE ERROR       ; If not '<', error
        
        JSR CHECK_END_TAG ; Check if it's an end tag
        BCC LOOP         ; If not end tag, continue checking

        INX             ; Increment index register
        JMP LOOP        ; Continue looping

CHECK_END_TAG
        INX             ; Skip '<'
        LDA INPUT,X     ; Load next character
        CMP #47         ; Check if it's '/'
        BNE CHECK_START_TAG ; If not '/', check if it's a start tag

        INX             ; Skip '/'
        LDA INPUT,X     ; Load next character
        CMP #62         ; Check if it's '>'
        BEQ CHECK_END_TAG_RETURN ; If is '>', return
        BNE CHECK_END_TAG ; If not '>', continue checking

CHECK_START_TAG
        CMP #62         ; Check if it's '>'
        BEQ CHECK_END_TAG_RETURN ; If is '>', return
        BNE CHECK_START_TAG ; If not '>', continue checking

CHECK_END_TAG_RETURN
        RTS             ; Return from subroutine

ERROR   JMP $FFFE       ; Error handling routine

END     BRK             ; End of program

INPUT   .byte "<xml>hello</xml>", 0

        .end
