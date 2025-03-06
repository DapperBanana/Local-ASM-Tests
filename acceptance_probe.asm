
; 6502 Assembly program to find the longest palindromic substring in a given string

        .org $0200

start   LDX #$00            ; Initialize index to 0
        LDY #$00            ; Initialize length to 0
    
next    LDA str,X          ; Load character from string
        BEQ done            ; If end of string, done
        JSR extendPalindrome ; Try to extend palindrome with character
        INX                 ; Increment index
        BNE next            ; Continue until end of string
        
done    STY maxLength       ; Store length of longest palindrome
    
        ; Add code here to handle the longest palindromic substring found
    
end     BRK

; Extend or find palindrome with the current character
;
; Input: A = current character
;        X = current index
extendPalindrome
        LDX #$01            ; Initialize length to 1
        
        ; Extend palindrome to the left
left    DEX                 ; Decrement index
        CPX #$FF            ; If reached beginning of string, exit
        BEQ endExtend
        
        LDA str,X          ; Load character from left
        CMP A               ; Compare with current character
        BNE endExtend       ; If not equal, exit
        
        INX                 ; Increment length
        DEX                 ; Decrement index
        BNE left            ; Continue until beginning of string
        
endExtend
        CPX maxLength       ; Compare current length with max length found
        BCC notLongest      ; If shorter, not longest palindrome
        
        STX maxLength       ; Store new max length
        STX longestIndex    ; Store index of longest palindrome
        STX longestLength   ; Store length of longest palindrome
      
notLongest
        RTS

maxLength    .byte $00
longestIndex .byte $00
longestLength .byte $00

str         .asciiz "abacdcdeed"

        .end
