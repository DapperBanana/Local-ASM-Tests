
; Check if a given string is an isogram
;
; Input:
; - Memory location $2000 points to the start of the string
; - Memory location $2001 contains the length of the string
;
; Output:
; - Carry flag set if the string is an isogram, cleared otherwise

    LDA #$00            ; Initialize counter
    STA $2002

check_isogram:
    LDA $2001           ; Load string length
    CLC
    ADC $2002           ; Add counter
    CMP $2001           ; Compare with string length
    BCS done            ; If counter >= string length, done

    LDA $2002           ; Load counter
    TAX                 ; Transfer to index register
    LDA $2000, X        ; Load character of string at index
    BEQ duplicate_found ; If null terminator, done checking

    LDY #$00            ; Initialize inner counter
    LDA $2002           ; Load counter
    STA $2003           ; Store outer counter in temp
    LDA #$01            ; Assume no duplicates at first
find_duplicate:
    LDX $2003           ; Load temp counter
    CPY X               ; Compare inner and outer counters
    BEQ next_character  ; If inner counter == outer counter, move to next character

    LDA $2000, Y        ; Load character of string at inner counter
    CMP $2000, X        ; Compare with character of string at outer counter
    BEQ duplicate_found ; If duplicate found, set carry flag

    INY                 ; Increment inner counter
    BNE find_duplicate  ; Repeat until inner counter overflows

next_character:
    LDA $2003           ; Load temp counter
    INX                 ; Increment counter
    STA $2002           ; Store in counter
    JMP check_isogram   ; Check next character

duplicate_found:
    SEC                 ; Set the carry flag to indicate a duplicate was found
    RTS

done:
    CLC                 ; Clear carry flag to indicate the string is an isogram
    RTS
