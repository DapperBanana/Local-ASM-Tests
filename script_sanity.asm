
; Program to find the longest common subsequence of two strings

.ORG $0200   ; Starting address of program

String1     .BYTE "ABCD"
String2     .BYTE "ACABD"

CommonSubsequence .BYTE "             " ; Space to store common subsequence

LDA #0      ; Initialize index to 0
STA Index

Loop:
    LDX Index ; Load index into X register
    LDA String1,X ; Load character from String1
    STA Temp1
    LDA #0 ; Initialize inner index to 0
    STA InnerIndex
    
InnerLoop:
    LDX InnerIndex ; Load inner index into X register
    LDA String2,X ; Load character from String2
    STA Temp2
    
    CMP Temp1 ; Compare characters
    
    BEQ Match ; If characters are equal, go to Match 
    
    INX ; Increment inner index
    INX ; Increment inner index again
    CPX #5 ; Check if end of String2
    BCC InnerLoop ; If not, continue InnerLoop
    
    JMP NextIndex ; If inner index reaches end of String2, go to next character in String1
    
Match:
    LDX Index ; Load index into X register
    LDA String1,X ; Load character from String1
    
    STA CommonSubsequence,X ; Store character from String1 to CommonSubsequence
    
    INX ; Increment index
    STX Index ; Store updated index
    
NextIndex:
    INX ; Increment index
    CPX #4 ; Check if end of String1
    BCC Loop ; If not, continue Loop
    
    BRK ; End of program

Temp1 .BYTE $00   ; Temporary storage for character from String1
Temp2 .BYTE $00   ; Temporary storage for character from String2
Index .BYTE $00   ; Index to iterate through String1
InnerIndex .BYTE $00 ; Inner index to iterate through String2

.END
