
ORG $1000

; Constants
LIST1_START = $1000
LIST2_START = $2000
MERGED_LIST_START = $3000
MAX_SIZE = 10

; Variables
list1_ptr = $00
list2_ptr = $01
merged_ptr = $02
temp_ptr = $03
temp_value = $04
i = $05
j = $06

; Initialize pointers
    LDA #LIST1_START
    STA list1_ptr
    LDA #LIST2_START
    STA list2_ptr
    LDA #MERGED_LIST_START
    STA merged_ptr

merge_lists_loop:
    ; Compare elements at list1_ptr and list2_ptr
    LDA (list1_ptr),Y
    CMP (list2_ptr),Y
    BCC add_list1_element
    ; If list2 element is smaller, add it to merged list
    LDA (list2_ptr),Y
    STA (merged_ptr),Y
    JMP increment_list2_ptr
    
add_list1_element:
    ; Add list1 element to merged list
    LDA (list1_ptr),Y
    STA (merged_ptr),Y
    JMP increment_list1_ptr

increment_list1_ptr:
    ; Increment list1 pointer
    CLC
    ADC #1
    STA temp_value
    LDA temp_value
    CMP #MAX_SIZE
    BEQ end_merge
    LDA list1_ptr
    STA temp_ptr
    LDX #0
    INX
    STX temp_ptr
    LDA temp_value
    STA list1_ptr
    JMP merge_lists_loop

increment_list2_ptr:
    ; Increment list2 pointer
    CLC
    ADC #1
    STA temp_value
    LDA temp_value
    CMP #MAX_SIZE
    BEQ end_merge
    LDA list2_ptr
    STA temp_ptr
    LDX #0
    INX
    STX temp_ptr
    LDA temp_value
    STA list2_ptr
    JMP merge_lists_loop

end_merge:
    RTS
