
    ORG $0200

; Define the two lists
List1    .BYTE 05, 10, 15, 20, 25
List2    .BYTE 10, 15, 20, 25, 30

; Initialize variables
count    .BYTE 00
common   .DS 256

    LDX #00       ; Initialize index for List1
loop1:
    LDY #00       ; Initialize index for List2
loop2:
    LDA List1, X  ; Load element from List1
    CMP List2, Y  ; Compare with element from List2
    BEQ addCommon ; If elements match, add to common list
    INY           ; Increment List2 index
    CPY #05       ; Check for end of List2
    BNE loop2     ; If not, continue loop2

    INX           ; Increment List1 index
    CPX #05       ; Check for end of List1
    BNE loop1     ; If not, continue loop1

displayCommon:
    LDA count      ; Load count of common elements
    STA $FD        ; Store in display register
    LDX #00        ; Initialize index for common list

outputCommon:
    LDA common, X  ; Load common element
    STA $FE        ; Store in output register
    INX            ; Increment index
    CPX count      ; Check for end of common list
    BNE outputCommon

    BRK            ; End program

addCommon:
    STA common, X ; Add common element to list
    INC count     ; Increment count of common elements
    INX           ; Increment index
    RTS           ; Return to main loop
