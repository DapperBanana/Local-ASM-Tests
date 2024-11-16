
; Common Characters Program

.segment "MAIN"

Start:
    LDX #0          ; Initialize index for first string
    LDY #0          ; Initialize index for second string
    LDA str1,X      ; Load character from first string into A
Compare:
    CMP str2,Y      ; Compare character with corresponding character from second string
    BEQ FoundCommon ; If characters match, jump to FoundCommon
NextChar:
    INX             ; Move to next character in first string
    LDA str1,X      ; Load next character from first string into A
    CMP #0           ; Check if end of first string
    BNE Compare     ; If not end of string, compare next character
End:
    RTS             ; Return from subroutine

FoundCommon:
    JSR PrintCharacter ; Print common character
    INX             ; Move to next character in first string
    INY             ; Move to next character in second string
    LDA str1,X      ; Load next character from first string into A
    CMP #0          ; Check if end of first string
    BEQ End         ; If end of first string, exit program
    BRA Compare     ; Otherwise, compare next character

.segment "DATA"

str1: .text "hello"  ; First string
str2: .text "world"  ; Second string

.segment "RODATA"

PrintCharacter:
    ; Output common character
    STA $FF         ; Store character in output register
    ; Add code here to output character to screen or console
    RTS             ; Return from subroutine

