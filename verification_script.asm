
ORG $0600   ; Start address of the program

LDA #<List1         ; Load low byte of List1's address into A
LDX #>List1         ; Load high byte of List1's address into X
LDY #<List2         ; Load low byte of List2's address into Y
LDZ #>List2         ; Load high byte of List2's address into Z

MainLoop:
    LDA (X),Y        ; Load element from List1
    CMP (Z),Y        ; Compare with element from List2
    BCC InsertList1  ; If element from List1 is smaller, insert it
    LDA (Z),Y
    STA $0200,Y      ; Otherwise, insert element from List2
    INY
    CPY #<ListSize   ; Check if reached end of List2
    BNE MainLoop     ; If not, continue merging

InsertList1:
    STA $0200,X      ; Insert element from List1 into merged list
    INX
    CPX #<ListSize   ; Check if reached end of List1
    BNE MainLoop     ; If not, continue merging

End:
    RTS

List1:
    .BYTE 1, 3, 5, 7   ; Example sorted list 1
List2:
    .BYTE 2, 4, 6, 8   ; Example sorted list 2
ListSize = *-List1     ; Calculate size of lists

ORG $0200   ; Start address of merged list
MergedList:
    .BLOCK 8           ; Reserved space for merged list
