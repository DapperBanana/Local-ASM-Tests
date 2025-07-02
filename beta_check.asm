
; Initialize variables
List         .byte   1, 2, 3, 5, 6, 7, 8, 10, 11, 12, 14, 15
ListSize     =       * - List

LongestSeq   .byte   0
CurrentSeq   .byte   1
MaxSeq       .byte   1

Start
    LDX     #0              ; Initialize index counter
    LDA     List, X         ; Load first element of list
    STA     LongestSeq      ; Store first element as starting point

NextSeq
    INX
    CPX     #ListSize       ; Check if end of list reached
    BEQ     End             ; If end of list, exit program

    LDA     List, X         ; Load current element of list

    SEC
    CLC
    CMP     LongestSeq      ; Compare with last element in longest sequence
    BEQ     ContSeq         ; If consecutive, continue current sequence
    BCS     NewSeq          ; If not consecutive, start new sequence

ContSeq
    INC     CurrentSeq      ; Increment current sequence length
    BCC     NextSeq         ; Continue with next element

NewSeq
    STX     LongestSeq      ; Save last element of longest sequence
    STX     MaxSeq          ; Save length of current sequence as max sequence
    LDA     #1
    STA     CurrentSeq      ; Reset current sequence length
    BRA     NextSeq         ; Continue with next element

End
    ; Result will be in LongestSeq and MaxSeq
