
    .org $0200
    LDA #<Set1           ; Load the low byte of the address of Set1
    STA $00              ; Store it in memory location $00
    LDA #>Set1           ; Load the high byte of the address of Set1
    STA $01              ; Store it in memory location $01
    
    LDX #0               ; Initialize index X to 0
loop1:
    LDA ( $00, X )       ; Load the value from Set1[X] into the accumulator
    STA $02              ; Store it in memory location $02
    
    LDA #<Set2           ; Load the low byte of the address of Set2
    STA $03              ; Store it in memory location $03
    LDA #>Set2           ; Load the high byte of the address of Set2
    STA $04              ; Store it in memory location $04
    
    LDX #0               ; Reset index X to 0
loop2:
    LDA ( $03, X )       ; Load the value from Set2[X] into the accumulator
    CMP $02              ; Compare it with the value from Set1[X]
    BEQ skip             ; If equal, skip storing the value
    
    STA Result, X        ; Store the unique value in the result set
    INX                  ; Increment index X
    
skip:
    INX                  ; Increment index X for Set2
    CPX #Set2Size        ; Check if end of Set2 is reached
    BNE loop2            ; If not, continue looping through Set2
    
    INX
    CPX #ResultSize
    BNE end
    
    INY
    CPY #Set1Size
    BNE loop1
    
end:    
    BRK
Set1:  .byte 1, 2, 3, 4, 5
Set1Size = * - Set1
    
Set2:  .byte 3, 4, 5, 6, 7
Set2Size = * - Set2

Result: .block 10
ResultSize = * - Result
