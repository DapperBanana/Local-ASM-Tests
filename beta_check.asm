
; Binary Search program in 6502 Assembly

ORG $0200

; Define the sorted list (array) of numbers
LDA #0
STA ARRAY,X
LDA #3
STA ARRAY+1,X
LDA #6
STA ARRAY+2,X
LDA #9
STA ARRAY+3,X
LDA #12
STA ARRAY+4,X
LDA #15
STA ARRAY+5,X
LDA #18
STA ARRAY+6,X
LDA #21
STA ARRAY+7,X

LDX #0           ; Start index of the array
LDY #7           ; End index of the array
LDA #9           ; Number to search for

SearchLoop:
    CPX, Y        ; Compare start and end index
    BCS NotFound  ; If start index > end index, number not found
    
    LDA X         ; Calculate mid index
    CLC
    ADC Y
    LSR            ; Divide by 2
    STA MID_IDX
    
    LDA ARRAY, X  ; Load the middle element
    CMP #NUM      ; Compare with the number
    BEQ Found     ; If equal, number found
    
    BCC UpdateStartIndex ; If element < number, set start index to mid index + 1
    JMP UpdateEndIndex

UpdateStartIndex:
    LDA MID_IDX
    CLC
    ADC #1
    STA X
    JMP SearchLoop
    
UpdateEndIndex:
    LDA MID_IDX
    SEC
    SBC #1
    STA Y
    JMP SearchLoop

Found:
    LDA MID_IDX
    STA RESULT
    RTS

NotFound:
    LDA #-1
    STA RESULT
    RTS

ARRAY: .DS 8      ; The sorted array
MID_IDX: .DB 0    ; Mid index variable
RESULT: .DB 0     ; Result variable
NUM: .DB 9        ; Number to search for

