
        .segment "CODE"
        .org $0200
        
start   LDX #0              ; Initialize X to 0
loop    LDA list1, X        ; Load the element from list1
        CMP #$00            ; Compare with null terminator
        BEQ finished       ; If reached end of list1, exit

        LDY #0              ; Initialize Y to 0
inner   LDA list2, Y        ; Load the element from list2
        CMP #$00            ; Compare with null terminator
        BEQ nextElement    ; If reached end of list2, move to next element in list1

        CMP list1, X        ; Compare the elements
        BEQ foundCommon     ; If elements are equal, go to foundCommon
        
        INY                 ; Increment Y
        JMP inner           ; Check next element in list2
        
foundCommon
        STA commonList, X   ; Store the common element in commonList
        INX                 ; Increment X
        JMP nextElement      ; Move to next element in list1
        
nextElement
        INX                 ; Move to next element in list1
        JMP loop            ; Check next element in list1
        
finished
        RTS
        
        .segment "DATA"
list1   .byte $01, $02, $03, $04, $05, $00   ; List 1 with null terminator
list2   .byte $03, $04, $05, $06, $07, $00   ; List 2 with null terminator
commonList .block 10                           ; Common elements list

        .end
