
        .text
        .global _start

_start:
        LDA #0          ; initialize index
        STA index

check_common:
        LDA list1, X    ; load element from first list
        CMP list2, X    ; compare with element from second list
        BEQ found_common ; if equal, found common element
        INX             ; increment index
        CPX list_size   ; check if end of list
        BNE check_common ; if not end of list, continue checking
        BRK             ; exit if end of list

found_common:
        LDA list1, X    ; load common element
        STA result      ; store common element
        BRK             ; exit program

        .data
list1:  .byte 1, 2, 3, 4, 5
list2:  .byte 3, 4, 5, 6, 7
list_size: .byte 5
index:  .byte 0
result: .byte 0
