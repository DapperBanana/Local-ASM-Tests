
STARTING_ADDRESS .equ $0200

; Load first list into memory
LDA #0
STA $00 ; Counter for list A
LDA #0
STA $03 ; Counter for result list
LDA #0
STA $0A ; Counter for list B

LDX #0   ; Initialize X register to 0
LDA ListA, X
CMP #$FF  ; Check if end of list A
BEQ Done  ; If end of list A, exit

CheckNextElement:
    LDY #0  ; Initialize Y register to 0
    LDA ListB, Y
    CMP #$FF  ; Check if end of list B
    BEQ NextElement ; If end of list B, move to next element in list A
    
    CMP ListA, X ; Compare current element from list A with list B
    BEQ AddToResultList ; If match found, add element to result list
    
    INY  ; Move to next element in list B
    INY
    CPY #8  ; Check if end of list B
    BNE CheckNextElement ; If not end of list B, continue checking
    
NextElement:
    INX  ; Move to next element in list A
    LDA ListA, X
    CMP #$FF  ; Check if end of list A
    BNE CheckNextElement ; If not end of list A, continue
    
Done:
    STA ResultList, $03 ; Store end of result list
    BRK ; Exit program

AddToResultList:
    STA ResultList, $03 ; Store current element in result list
    INX
    LDA ListA, X
    STA $03 ; Update result list counter
    JMP NextElement

; Data section
ListA:
    .byte 5, 2, 8, 4, 9, 1, 7, $FF  ; List A (end with $FF)
ListB:
    .byte 3, 4, 7, 5, 2, 9, 8, $FF  ; List B (end with $FF)
ResultList:
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $FF  ; Result list (end with $FF)

; End of program
