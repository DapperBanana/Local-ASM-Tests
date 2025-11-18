
LDA #0            ; Initialize index i to 0
STA index_i
LDA #0            ; Initialize index j to 0
STA index_j

; Load the first element from list1 and list2
LDA list1, X      ; Load element from list1
STA current_element1
LDA list2, Y      ; Load element from list2
STA current_element2

merge_loop:
CMP current_element1, current_element2  ; Compare the current elements
BCS copy_element2  ; Branch if element from list2 is smaller
copy_element1:
STA merged_list, X  ; Copy element from list1 to the merged list
INY                 ; Increment index j for list2
LDA list1, X        ; Load next element from list1
STA current_element1
BNE compare_elements  ; Branch if not end of list1
close_list1:
LDA current_element2  ; Copy remaining elements from list2
STA merged_list, X
INY                 ; Increment index j for list2
LDA list2, Y        ; Load next element from list2
STA current_element2
BNE check_end       ; Check end of list2

compare_elements:
CMP current_element1, current_element2  ; Compare the current elements
BCS copy_element2   ; Branch if element from list2 is smaller
BCC copy_element1   ; Branch if element from list1 is smaller

copy_element2:
STA merged_list, Y  ; Copy element from list2 to the merged list
INX                 ; Increment index i for list1
LDA list2, Y        ; Load next element from list2
STA current_element2
BNE compare_elements  ; Branch if not end of list2
close_list2:
LDA current_element1  ; Copy remaining elements from list1
STA merged_list, Y
INX                 ; Increment index i for list1
LDA list1, X        ; Load next element from list1
STA current_element1
BNE check_end       ; Check end of list1

check_end:
CPX #list1_end      ; Check if end of list1 is reached
BNE merge_loop      ; If not, continue merge loop
Cpy #list2_end      ; Check if end of list2 is reached
BEQ end_merge       ; If not, we are done

end_merge:
RTS                 ; Return from subroutine

index_i: .byte 0
index_j: .byte 0
current_element1: .byte 0
current_element2: .byte 0
merged_list: .byte 0
list1: .byte 1, 3, 5, 7, 9
list1_end: .byte 0
list2: .byte 2, 4, 6, 8, 10
list2_end: .byte 0
