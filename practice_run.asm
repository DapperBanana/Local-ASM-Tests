
    .org $0200
    .org $FCFC
LDA $01      ; Load the length of the first list into the accumulator
STA $FE      ; Store it in memory location $FE
LDA $02      ; Load the length of the second list into the accumulator
STA $FF      ; Store it in memory location $FF

    .org $020A
LDX #$00     ; Initialize X register to 0
LOOP1:
    LDA ($03),X   ; Load element at index X of first list
    STA $FB       ; Store it in memory location $FB
    LDY #$00      ; Initialize Y register to 0
LOOP2:
    LDA ($04),Y   ; Load element at index Y of second list
    CMP $FB       ; Compare it with the element from first list
    BEQ FOUND     ; Branch if equal
    INY           ; Increment Y
    CPY $FF       ; Compare Y with the length of second list
    BCC LOOP2     ; Branch if Y < length of second list
    INX           ; Increment X
    CPX $FE       ; Compare X with the length of first list
    BCC LOOP1     ; Branch if X < length of first list
DONE:
    BRK           ; Break execution
FOUND:
    JSR PRINT    ; Call subroutine to print common elements
    INY           ; Increment Y for checking remaining elements in second list
    CPY $FF       ; Compare Y with the length of second list
    BCC LOOP2     ; Branch if Y < length of second list
    INX           ; Increment X for checking remaining elements in first list
    CPX $FE       ; Compare X with the length of first list
    BCC LOOP1     ; Branch if X < length of first list
    JMP DONE      ; Jump to the end of the program

    .org $0250
PRINT:
    LDA $FB       ; Load common element into accumulator
    STA $FD       ; Store it in memory location $FD
    LDA #$2C      ; Load comma into accumulator
    JSR $FFD2     ; Call subroutine to print comma
    LDA $FD       ; Load common element into accumulator
    JSR $FFD2     ; Call subroutine to print common element
    RTS           ; Return from subroutine

    .org $FFD2
    STA $03       ; Store accumulator in temporary memory location
    LDX #$00      ; Initialize X register to 0
PRINT_LOOP:
    LDA $03,X     ; Load char to print into accumulator
    BEQ END_PRINT ; Branch if the end of the string is reached
    JSR $FFD2     ; Call Kernal subroutine to print char
    INX           ; Increment X
    JMP PRINT_LOOP; Jump back to PRINT_LOOP
END_PRINT:
    RTS           ; Return from subroutine

    .org $FFFC
    DW $0200      ; Set the program starting address
    DW $0250      ; Set the PRINT subroutine address

    .org $00
    DB $0A        ; Length of first list
    DB $03        ; Length of second list
    DB $01,$02,$03,$04,$05,$06,$07,$08,$09,$0A
    DB $02,$04,$06
