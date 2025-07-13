
; 6502 Assembly program to extract hashtags from a given text

START:
    ; Initialize variables
    LDX #0          ; Index for text
    LDY #0          ; Index for hashtags
    LDZ #0          ; Counter for hashtags found
    LDA #$80        ; Start address of input text
    STA TEXT

CHECK_CHAR:
    LDA (TEXT), X   ; Load character from text
    CMP #0          ; Check for end of text
    BEQ DONE        ; If end of text, exit

    CMP #' '        ; Check for space
    BEQ INC_INDEX   ; If space, move to next character
    CMP #'#'        ; Check for hashtag
    BNE INC_INDEX   ; If not hashtag, move to next character

    INY             ; Increment index for hashtags
    LDX #0          ; Reset index for hashtag
    STA HASHTAGS, Y ; Store hashtag in array

    ; Copy the hashtag from text to hashtags array
COPY_HASHTAG:
    INX             ; Increment index for text
    LDA (TEXT), X   ; Load character from text
    CMP #' '        ; Check for space
    BEQ SAVE_HASHTAG ; If space, save hashtag
    STA HASHTAGS, Y ; Store character in array
    INY             ; Increment index for hashtags
    JMP COPY_HASHTAG

SAVE_HASHTAG:
    INY             ; Increment index for hashtags
    LDA #0          ; Null terminate hashtag
    STA HASHTAGS, Y ; Store null terminator

INC_INDEX:
    INX             ; Increment index for text
    JMP CHECK_CHAR  ; Check next character

DONE:
    ; Print out all hashtags found
    LDX #0          ; Reset index for hashtags
PRINT_HASHTAGS:
    LDA HASHTAGS, X ; Load character from hashtags array
    CMP #0          ; Check for null terminator
    BEQ END         ; If null terminator, exit
    JSR PRINT_CHAR  ; Print character
    INX             ; Increment index for hashtags
    JMP PRINT_HASHTAGS

END:
    BRK             ; Exit program

; Print character subroutine
PRINT_CHAR:
    ; Output character in A
    RTS

; Variables
TEXT: .BYTE "Sample text with #hashtags and #morehashtags", 0
HASHTAGS: .BLKW 50   ; Array to store extracted hashtags

    .END
