
        ORG $8000  ; Start address of the program

        LDX #0     ; Initialize index for set 1
loop1   LDA set1,X ; Load element from set 1
        BEQ end1   ; If element is 0 (end of set), exit loop
        STA result,X ; Store element in result
        INX        ; Increment index
        JMP loop1  ; Continue looping

end1    LDX #0     ; Initialize index for set 2
loop2   LDA set2,X ; Load element from set 2
        BEQ end2   ; If element is 0 (end of set), exit loop
        CMP result,X ; Compare with elements already in union
        BEQ skip   ; If element is already in union, skip
        STA result,X ; Store element in result
        INX        ; Increment index

skip    INX        ; Increment index
        JMP loop2  ; Continue looping

end2    RTS        ; Return from subroutine

set1    .BYTE 1, 2, 3, 4, 5, 0 ; Set 1 (change values as needed)
set2    .BYTE 4, 5, 6, 7, 8, 0 ; Set 2 (change values as needed)
result  .BLKB 10  ; Result array with enough space to store union

        END        ; End of program
