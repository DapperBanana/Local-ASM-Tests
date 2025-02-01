
        LDX #0             ; Initialize index for list1
LOOP1:  LDA LIST1_START,X  ; Load byte from list1
        BEQ END1          ; End of list1
        LDY #0             ; Initialize index for list2
LOOP2:  LDA LIST2_START,Y  ; Load byte from list2
        BEQ NEXT1         ; End of list2
        CMP LIST1_START,X  ; Compare byte from list1 with byte from list2
        BEQ MATCH         ; Found a match
        INY               ; Increment index for list2
        JMP LOOP2         ; Continue comparing
MATCH:  STA RESULT,X      ; Store matching byte in result list
        INX               ; Increment index for result list
NEXT1:  INX               ; Increment index for list1
        JMP LOOP1         ; Continue comparing
END1:   RTS               ; Return from subroutine

LIST1_START: .BYTE 1,2,3,4,5,6,0   ; List1 with 6 elements
LIST2_START: .BYTE 3,4,7,8,0         ; List2 with 4 elements
RESULT:      .BYTE 0,0,0,0,0,0,0,0   ; Result list with maximum possible size
