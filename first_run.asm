
; 6502 Assembly Program to Calculate Hamming Distance Between Two Strings

        ; Constants
        STRING1      .byte "Hello"
        STRING2      .byte "Halxo"
        STR_LEN      = * - STRING1
        
        ; Program Start
        LDA #0                  ; Initialize distance counter
        STA DISTANCE
        LDY #0                  ; Initialize index register
        
COMPARE_LOOP:
        LDA STRING1,Y           ; Load character from first string
        CMP STRING2,Y           ; Compare with character from second string
        BEQ NEXT_CHARACTER      ; If characters are same, move on to next character
        INC DISTANCE            ; If characters are different, increment distance counter
        
NEXT_CHARACTER:
        INY                     ; Move to next character
        CPY STR_LEN             ; Check if end of strings reached
        BNE COMPARE_LOOP        ; If not, compare next character
        
        ; Distance calculation complete
        ; The Hamming distance is now stored in DISTANCE
        
        ; End of Program
        
        .org $C000
DISTANCE .byte 0
