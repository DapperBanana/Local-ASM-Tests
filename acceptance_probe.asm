
START   LDX #0         ; Initialize index pointer
        LDY #0         ; Initialize character pointer
LOOP    LDA TEXT,Y     ; Load next character from text
        BEQ DONE       ; If end of text, done
        CMP #'#'       ; Check for hashtag symbol
        BNE CONTINUE   ; If not a hashtag symbol, continue
        INY             ; Increment character pointer
GETTAG  LDA TEXT,Y     ; Load next character from text
        BEQ ADDTAG     ; If end of text, add tag
        CMP #' '       ; Check for space
        BEQ ADDTAG     ; If space, add tag
        STA TAG,X      ; Store character in tag
        INX             ; Increment tag index
        INY             ; Increment character pointer
        JMP GETTAG      ; Get next character
ADDTAG  LDA #0          ; Null-terminate tag
        STA TAG,X
        JSR PRINTTAG   ; Print tag
        LDX #0         ; Reset tag index
        JMP LOOP       ; Continue parsing text
CONTINUE
        INY             ; Increment character pointer
        JMP LOOP       ; Continue parsing text
DONE    BRK             ; End of program

PRINTTAG
        LDX #0         ; Initialize tag index
PRINTLOOP
        LDA TAG,X      ; Load character from tag
        BEQ PRINTDONE   ; If end of tag, done
        JSR PRINTCHAR   ; Print character
        INX             ; Increment tag index
        JMP PRINTLOOP   ; Print next character
PRINTDONE
        RTS

PRINTCHAR
        ; Implement subroutine to print character to output (e.g. screen)
        RTS

TEXT    .BYTE "This is a #sample text with #hashtags", $00
TAG     .BLKW 15        ; Buffer to store extracted tag
