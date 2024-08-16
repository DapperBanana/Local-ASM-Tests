
; Input:
; A: Address of the first string
; X: Address of the second string

    LDX #0 ; Initialize edit distance to 0
    LDY #0 ; Initialize index to 0

loop:
    LDA (A),Y ; Load character from first string
    CMP #0     ; Check for null terminator
    BEQ done   ; If reached end of string, exit loop
    STA $02    ; Store character in temp location
    
    LDA (X),Y ; Load character from second string
    CMP #0     ; Check for null terminator
    BEQ done   ; If reached end of string, exit loop
    STA $03    ; Store character in temp location
    
    CMP $02    ; Compare characters
    BEQ next   ; If characters are equal, move to next index
    
    INC X ; Increment X index
    INC Y ; Increment Y index
    
    JSR calc_distance ; Calculate edit distance
    JMP loop ; Continue loop

next:
    INC Y ; Increment index
    JMP loop ; Continue loop

done:
    RTS ; Return from subroutine

; Subroutine to calculate edit distance
calc_distance:
    ; Load characters from first string
    LDA (A),Y
    STA $01
    LDX $01
    
    ; Load characters from second string
    LDA (X),Y
    STA $01
    LDA $02
    STA $00
    
    ; Compare characters
    CMP $01
    BEQ skip
    INC $00 ; Increment edit distance
    
skip:
    RTS ; Return from subroutine
