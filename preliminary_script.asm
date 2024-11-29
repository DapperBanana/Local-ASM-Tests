
ORG $1000

; Constants
LIST_SIZE = 10

; Input lists
list1: .byte $01, $03, $05, $07, $09, $0B, $0D, $0F, $11, $13
list2: .byte $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14

; Output list
output_list: .byte LIST_SIZE

start:
    LDX #0            ; Initialize index for list1
    LDY #0            ; Initialize index for list2
    LDA #0            ; Initialize index for output_list

merge_loop:
    LDA list1, X      ; Load element from list1
    CMP list2, Y      ; Compare with element from list2
    BCC add_to_output ; If list1 element is smaller, add it to output_list
    STA output_list, Y ; Otherwise add list2 element to output_list
    INY               ; Increment index for list2

add_to_output:
    STA output_list, A  ; Add list1 element to output_list
    INX                 ; Increment index for list1
    INY                 ; Increment index for list2
    INY                 ; Increment index for output_list
    CPX #LIST_SIZE      ; Check if end of list1 has been reached
    BNE merge_loop      ; If not, continue merging
    LDA list2, Y        ; Copy remaining elements from list2 to output_list
    STA output_list, A
    INY
    INY
    CPY #LIST_SIZE      ; Check if end of list2 has been reached
    BNE end_merge       ; If not, continue merging

end_merge:
    JMP $FFFE           ; End program

