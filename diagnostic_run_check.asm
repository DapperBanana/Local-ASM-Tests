
    ORG $0200

    LDX #$00         ; Initialize index
loop:
    LDA list,X       ; Load next number from list
    STA temp         ; Store number in temp
    JSR square       ; Calculate square of number
    STA result,X     ; Store result back in memory
    INX              ; Increment index
    CPX #5           ; Check if end of list
    BNE loop         ; If not, continue loop

    BRK              ; End program

square:
    CLC              ; Clear carry flag
    LDA temp         ; Load number from temp
    ADC temp         ; Add number to itself
    STA temp         ; Store result in temp
    RTS              ; Return

list:
    .BYTE $01, $02, $03, $04, $05

temp:
    .BYTE $00

result:
    .BYTE $00, $00, $00, $00, $00

    .END
