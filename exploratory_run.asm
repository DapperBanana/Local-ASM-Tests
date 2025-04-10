
    LDX #$00    ; Initialize index for list1
    LDY #$00    ; Initialize index for list2
    LDZ #$00    ; Initialize index for result list
    
compareLists:
    LDA list1,X    ; Load element from list1
    CMP list2,Y    ; Compare with element from list2
    BEQ addToIntersection    ; If they are equal, add to intersection
    INX            ; Increment list1 index
    BNE endCompareLists    ; Branch if not at the end of list1
    INY            ; Increment list2 index
    CPY #list2Size    ; Check if end of list2 is reached
    BNE compareLists    ; Loop to compare the next element
    
endCompareLists:
    RTS            ; Exit subroutine
    
addToIntersection:
    STA intersection,Z    ; Add element to intersection list
    INZ            ; Increment intersection index
    INX            ; Increment list1 index
    BNE compareLists    ; Branch if not at the end of list1
    
list1:
    .byte $01, $02, $03, $04    ; First list of elements
list2:
    .byte $03, $04, $05, $06    ; Second list of elements
intersection:
    .byte $00, $00, $00, $00    ; Intersection list
    
list1Size = * - list1    ; Calculate size of list1
list2Size = * - list2    ; Calculate size of list2
intersectionSize = * - intersection    ; Calculate size of intersection

    JSR compareLists    ; Call subroutine to find intersection
