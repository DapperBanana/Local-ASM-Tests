
; Merge two sorted lists into a single sorted list
; Assume list1 is stored starting at $2000 and list2 is stored starting at $3000
; The merged list will be stored starting at $4000

LDA #$00         ; Initialize index for list1
STA idx1
LDA #$00         ; Initialize index for list2
STA idx2
LDA #$2000       ; Load address of list1
STA ptr1
LDA #$3000       ; Load address of list2
STA ptr2
LDA #$4000       ; Load address of merged list
STA ptr3

merge:
    LDA (ptr1),Y       ; Load value from list1
    STA temp
    LDA (ptr2),Y       ; Load value from list2
    STA temp2
    CMP temp,temp2     ; Compare values
    BCC copy1          ; Branch if value from list1 is smaller
    STA (ptr3),Y       ; Store value from list2 in merged list
    INY
    INC idx2           ; Increment index for list2
    CPY #$05           ; Check if end of list2 is reached
    BEQ end            ; Branch if end of list2 is reached
    JMP merge
copy1:
    STA (ptr3),Y       ; Store value from list1 in merged list
    INY
    INC idx1           ; Increment index for list1
    CPY #$05           ; Check if end of list1 is reached
    BEQ end            ; Branch if end of list1 is reached
    JMP merge

end:
    RTS

ptr1:
    .DW $2000         ; Pointer for list1
ptr2:
    .DW $3000         ; Pointer for list2
ptr3:
    .DW $4000         ; Pointer for merged list
idx1:
    .DB $00           ; Index for list1
idx2:
    .DB $00           ; Index for list2
temp:
    .DB $00           ; Temporary variable for list1
temp2:
    .DB $00           ; Temporary variable for list2
