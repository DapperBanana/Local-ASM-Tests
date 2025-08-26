
START
    LDX #0         ; Initialize index for list1
LOOP1:
    LDA list1,X    ; Load element from list1
    BEQ FINISH1    ; If end of list1, finish
    LDY #0         ; Initialize index for list2
    LDX #0         ; Reload index for list2
LOOP2:
    LDA list2,Y    ; Load element from list2
    BEQ NEXT1      ; If end of list2, go to next element in list1
    CMP list1,X    ; Compare elements from list1 and list2
    BEQ MATCH      ; If match, store element and go to next element in list1
    INY            ; Increment index for list2
    JMP LOOP2      ; Repeat loop for list2
MATCH:
    STA result,X   ; Store matched element
    INX            ; Increment index for result list
NEXT1:
    INX            ; Increment index for list1
    JMP LOOP1      ; Repeat loop for list1
FINISH1:
    RTS

list1:
    .byte 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 0

list2:
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0

result:
    .byte 0,0,0,0,0,0,0,0,0,0,0

END START
