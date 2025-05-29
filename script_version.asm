
        .org    $0200
        .include "vcs.h"
        
str1    .asciiz "listen"
str2    .asciiz "silent"
    
start
        LDX     #0              ; Initialize X register for indexing
        LDA     str1,X          ; Load character from first string
        CMP     #0              ; Check if end of string
        BEQ     end1            ; Branch if end of string
next1
        STA     $FB             ; Store current character in zero page
        
        LDX     #0              ; Reinitialize X register for second string
        LDA     str2,X          ; Load character from second string
        CMP     #0              ; Check if end of string
        BEQ     end2            ; Branch if end of string
next2
        STA     $FC             ; Store current character in zero page
        
        LDA     $FB             ; Load current character from first string
        CMP     $FC             ; Compare with current character from second string
        BNE     not_anagram     ; Branch if not equal
        
        INX                     ; Increment X register to move to next character
        LDA     str1,X          ; Load next character from first string
        CMP     #0              ; Check if end of string
        BEQ     end1            ; Branch if end of string
        JMP     next1           ; Jump back to compare next character
        
not_anagram
        LDA     #$00            ; Set result to false
        JMP     done
        
end1
        LDA     #$01            ; Set result to true
        
done
        BRK                     ; Halt
        
end2
        STA     result          ; Store result in memory
        
        LDA     result          ; Load result
        BEQ     not_anagram_msg ; Branch if not anagram
        LDA     #$00            ; Load ASCII value of 'Y' to display 'YES'
        JMP     display_result
        
not_anagram_msg
        LDA     #$01            ; Load ASCII value of 'N' to display 'NO'
        
display_result
        STA     COLUP0          ; Set background color
        STA     COLUPF          ; Set foreground color
        
        LDA     #$1D
        STA     WSYNC
        STA     rowpos+1        ; Set row position of message
        
        LDX     #$20
        LDA     #$0D            ; Load end of text ASCII value to print message
        STA     TEXT
        STA     rowpos
        
        LDA     #$0E            ; Load start of text ASCII value to print message
        
print_str        
        LDA     (rowpos),Y      ; Load character of message to display
        AND     #$7F
        SUB     #$20
        STA     RESP0
        
        LDX     rowpos
        INX
        TXA
        STX     WSYNC
        
        INY
        LDA     (rowpos),Y      ; Load next character of message to display
        ORA     #$80
        STA     WSYNC
        
        LDA     RESP0
        CPX     #$00
        BNE     print_str
        
        JMP     start
        
result  .byte   $00
rowpos  .byte   $00
        .bank   0
        .org    $FFFC
        .word   $0200
