
LDA #0         ; Initialize index for list 1
STA INDEX1

LDA #0         ; Initialize index for list 2
STA INDEX2

LOOP1:
LDA LIST1,X    ; Load current element from list 1
STA CURRENT_ELEMENT

LDA #0         ; Reset index for list 2
STA INDEX2

LOOP2:
LDA LIST2,X    ; Load current element from list 2
CMP CURRENT_ELEMENT ; Compare with element from list 1
BEQ ADD_COMMON_ELEMENT  ; If equal, add to common elements list

INX            ; Increment index for list 2
CMP #LIST_SIZE ; Compare index with list size
BNE LOOP2      ; Continue if not at the end of list 2

INX            ; Increment index for list 1
CMP #LIST_SIZE ; Compare index with list size
BNE LOOP1      ; Continue if not at the end of list 1

BRK            ; Exit program

ADD_COMMON_ELEMENT:
STA COMMON_LIST,Y ; Add common element to common list
INY               ; Increment index for common list

RTS               ; Return from subroutine

INDEX1:
    .byte 0
INDEX2:
    .byte 0
CURRENT_ELEMENT:
    .byte 0
COMMON_LIST:
    .block 20

LIST1:
    .block 10
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

LIST2:
    .block 10
    .byte 2, 4, 6, 8, 10, 12, 14, 16, 18, 20

LIST_SIZE:
    .byte 10 
