
ORG $0200
start:  LDX #$00        ; Initialize index
        LDY #$01        ; Initialize second index to compare
        LDA message,X   ; Load first character
check:  CMP message,Y   ; Compare with character at index Y
        BEQ duplicate   ; Branch if characters are the same
        INY             ; Increment secondary index
        CPY #$0A        ; Check if end of string
        BEQ isogram     ; Branch if end of string is reached
        JMP check       ; Continue comparing characters
duplicate: 
        LDA #$00        ; Set flag to 0 to indicate not an isogram
        JMP end
isogram:
        INX             ; Increment primary index
        LDX #$00        ; Reset secondary index
        LDA message,X   ; Load next character
        CPX #$0A        ; Check if end of string
        BEQ end         ; Branch if end of string is reached
        JMP start       ; Continue checking next character
end:    BRK             ; End program execution

message: .BYTE "HELLO", $00  ; Input string to check for isogram
