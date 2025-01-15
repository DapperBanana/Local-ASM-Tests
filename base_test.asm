
        ; Load the address of the string into the accumulator
        LDA     #<STRING
        STA     PTR
        LDA     #>STRING
        STA     PTR+1
        
        ; Initialize variables
        LDA     #00
        STA     MAXLEN
        STA     MAXSTART
        STA     MAXEND
        LDA     #01
        STA     LEN

LOOP:
        ; Find the next palindrome
        JSR     FINDPALINDROME
        
        ; Check if the new palindrome is longer than the previous longest one
        LDA     LEN
        CMP     MAXLEN
        BCC     UPDATE
        
        ; Update the maximum palindrome
        LDX     #00
UPDATE:
        LDA     LEN
        STA     MAXLEN
        LDA     START
        STA     MAXSTART
        LDA     END
        STA     MAXEND
        
        ; Move to the next character in the string
        LDA     PTR
        CLC
        ADC     #01
        STA     PTR
        BCC     NEXT
        INC     PTR+1
NEXT:
        ; Check if we have reached the end of the string
        LDA     PTR
        CMP     #<STRING+SIZE
        BEQ     DONE
        
        ; Increment the length variable and continue
        INC     LEN
        JMP     LOOP
        
FINDPALINDROME:
        ; Initialize variables
        LDX     #00
        LDA     #00
        STA     START
        STA     END
        STA     I
        
LP1:
        ; Check if we have reached the end of the string
        LDA     PTR
        CMP     #<STRING+LEN
        BEQ     LP2
        
        ; Load the character at the current position
        LDA     (PTR),X
        
        ; Compare it with the next character in the string
        LDX     #00
        CLC
        ADC     #01
        CMP     (PTR),X
        BNE     LP2
        
        ; Update the palindrome bounds
        INC     END
        DEC     PTR
        INC     I
        JMP     LP1
        
LP2:
        ; Check if the current palindrome is longer than the previous longest one
        LDA     END
        SEC
        SBC     START
        STA     LEN
        CMP     #00
        BEQ     EXIT
        
        RTS
        
DONE:
        ; Print the longest palindromic substring
        LDX     MAXSTART
LP3:
        LDA     (PTR),X
        JSR     $FFD2 ; Print character
        
        INX
        CPX     MAXEND
        BNE     LP3
        
        ; Halt
        BRK
        
; Define constants and variables
STRING  .asciiz "abacdc"
SIZE    = * - STRING

PTR     .byte  0,0
MAXLEN  .byte  0
MAXSTART .byte 0
MAXEND  .byte 0
LEN     .byte  0
START   .byte  0
END     .byte  0
I       .byte  0
