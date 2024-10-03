
; Merge two sorted lists into a single sorted list
; Assumes the input lists are stored in memory starting from LIST1 and LIST2
; The output merged list will be stored starting from MERGED_LIST

        .org $0200     ; Start of program

LIST1   .byte $01,$03,$05,$07,$09
LIST2   .byte $02,$04,$06,$08,$10
MERGED_LIST .res 10  ; Reserve memory for the merged list

        LDX #0         ; Initialize index for list1
        LDY #0         ; Initialize index for list2

merge_loop:
        LDA LIST1,X    ; Load element from list1
        CMP LIST2,Y    ; Compare with element from list2
        BCC add_from_list1 ; Branch if element from list1 is smaller
        STA MERGED_LIST,X ; Store element from list2 in merged list
        INY            ; Move to next element in list2
        CPY #5         ; Check if reached end of list2
        BNE merge_loop ; Continue merging
        JMP add_remaining_list1 ; Jump to add remaining elements from list1

add_from_list1:
        STA MERGED_LIST,X ; Store element from list1 in merged list
        INX            ; Move to next element in list1
        CPX #5         ; Check if reached end of list1
        BNE merge_loop ; Continue merging
        JMP add_remaining_list2 ; Jump to add remaining elements from list2

add_remaining_list1:
        LDA LIST1,X
        STA MERGED_LIST,X
        INX
        CPX #5
        BNE add_remaining_list1
        BRK            ; End of program

add_remaining_list2:
        LDA LIST2,Y
        STA MERGED_LIST,X
        INX
        INY
        CPY #5
        BNE add_remaining_list2
        BRK            ; End of program
