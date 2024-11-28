
        .text
        .org $0200

        LDA List1     ; Load the starting address of List1
        STA A1
        LDA List2     ; Load the starting address of List2
        STA A2

Loop1   LDA (A1),Y   ; Load an element from List1
        STA TEMP     ; Save it in TEMP

Loop2   LDA (A2),Y   ; Load an element from List2
        CMP TEMP     ; Compare it with the element from List1
        BEQ Found     ; If they are equal, go to Found

        INY           ; Increment the offset
        CPY #Length   ; Compare offset with length of lists
        BNE Loop2     ; If not end of list, continue searching

        LDA List1     ; If end of list1 is reached, go to next element in list1
        CLC
        ADC #ElementSize
        STA A1
        LDA List2     ; Reset offset for list2
        CLC
        ADC #ElementSize
        STA A2
        JMP Loop1     ; Continue searching for common elements

Found   ; Common element found
        ; Do something here with the common element

        INY           ; Increment offset for list1
        CPY #Length   ; Compare offset with length of lists
        BNE Loop1     ; If not end of list, continue searching

Done    BRK           ; Finished

        .data

List1   .byte $01,$02,$03,$04,$05
List2   .byte $03,$04,$05,$06,$07

A1      .word List1
A2      .word List2
TEMP    .byte 0
Length  = * - List1   ; Length of lists
ElementSize = 1         ; Size of each element in the list
