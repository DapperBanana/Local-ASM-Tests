
start:
    ; Load the length of list 1 into Y
    LDA list1_len
    STA $01
    LDY #$00
    
    ; Load the length of list 2 into X
    LDA list2_len
    STA $00
    LDX #$00
    
find_common_elements:
    ; Compare elements of list 1 with elements of list 2
    LDA list1, Y
    CMP list2, X
    BEQ common_element
    
    ; Move to next element in list 2
    INX
    CPX $00
    BNE find_common_elements
    
    ; Move to next element in list 1
    INY
    CPY $01
    BNE find_common_elements
    
    ; End of program
    RTS
    
common_element:
    ; Output common element
    STA common_list, X
    
    ; Move to the next element in list 2
    INX
    CPX $00
    BNE find_common_elements
    ; Move to the next element in list 1
    INY
    CPY $01
    BNE find_common_elements
    
    ; End of program
    RTS
    
list1_len: .byte 5
list1: .byte 1, 3, 5, 7, 9
    
list2_len: .byte 4
list2: .byte 2, 3, 5, 8
    
common_list: .byte 4

