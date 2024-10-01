
; Find common characters between two strings
;
; Input:
;   - String1: Address of the first string (null-terminated)
;   - String2: Address of the second string (null-terminated)
; Output:
;   - CommonChars: Address of the common characters between the two strings (null-terminated)

        .org $0200

Start:
        LDX #$00        ; Initialize index for String1
Loop1:
        LDA String1, X ; Load character from String1
        BEQ EndLoop1   ; Check for null terminator
        LDY #$00        ; Initialize index for String2
Loop2:
        LDA String2, Y ; Load character from String2
        BEQ EndLoop2   ; Check for null terminator
        CMP String1, X ; Compare characters
        BEQ Found      ; Found common character
        INY             ; Increment index for String2
        JMP Loop2      ; Continue looping through String2
Found:
        STA CommonChars, X ; Store common character
        INX             ; Increment index for CommonChars
EndLoop2:
        INX             ; Skip null terminator
        INY             ; Increment index for String2
        LDA String2, Y ; Load next character from String2
        BEQ EndLoop1   ; Check for null terminator
        JMP Loop1      ; Continue looping through String1
EndLoop1:
        STX CommonChars ; Null-terminate CommonChars
        RTS

String1:
        .asciiz "hello"
String2:
        .asciiz "world"
CommonChars:
        .res 10         ; Reserve space for common characters

        .end
