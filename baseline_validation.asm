
; 6502 Assembly program to calculate the median of a list of numbers

LIST    .BYTE   $05, $02, $07, $10, $03, $09     ; List of numbers

        LDX     #0                              ; Initialize X register to 0
        LDA     #<LIST                          ; Load low byte of LIST address into A
        STA     $FE                             ; Store low byte of LIST address in zero page
        LDA     #>LIST                          ; Load high byte of LIST address into A
        STA     $FF                             ; Store high byte of LIST address in zero page
        LDA     #6                              ; Load number of elements in the list
        STA     $01                             ; Store number of elements in memory location $01
        LDA     $FE                             ; Load low byte of LIST address
        STA     $02                             ; Store low byte in memory location $02
        LDA     $FF                             ; Load high byte of LIST address
        STA     $03                             ; Store high byte in memory location $03

        JSR     SORT_LIST                       ; Call subroutine to sort the list

        LDX     $01                             ; Load number of elements into X register
        LDA     #0                              ; Initialize A register to 0
        STA     $04                             ; Store 0 in memory location $04
        LDA     $02                             ; Load lowest number in list into A
        STA     $06                             ; Store lowest number in memory location $06
        LDA     $03                             ; Load highest number in list into A
        STA     $07                             ; Store highest number in memory location $07

LOOP    LDA     ($02), X                        ; Load number at current position in list into A
        CLC                                   ; Clear carry flag
        ADC     $04                             ; Add current median to A
        STA     $04                             ; Store new median in memory location $04

        INX                                   ; Increment X register
        CPX     $01                             ; Compare X to number of elements
        BNE     LOOP                            ; Loop until all elements are processed

        LDA     $01                             ; Load number of elements into A
        AND     #1                              ; Check if even or odd
        BEQ     MEDIAN_EVEN                     ; Branch to MEDIAN_EVEN if even

        LDA     $04                             ; Load median into A (odd number of elements)
        JMP     PRINT_MEDIAN                    ; Jump to PRINT_MEDIAN

MEDIAN_EVEN
        LDX     #0                              ; Initialize X register to 0
        LDA     $04                             ; Load current median into A
        CLC
        ADC     ($02), X                        ; Add number on left side of median
        STA     $04
        INX
        LDA     ($02), X                        ; Add number on right side of median
        CLC
        ADC     $04
        ASL                                   ; Divide by 2 (shift left)
        STA     $04

PRINT_MEDIAN
        ; Output the median value stored in memory location $04
        ; Code to output median value

SORT_LIST
        LDX     #0                              ; Initialize X register to 0

SORT_LOOP
        LDA     $01                             ; Load number of elements into A
        SEC
        SBC     #1
        BEQ     SORT_DONE                       ; Branch to SORT_DONE if only 1 element left

        LDA     ($02), X                        ; Load current number into A
        SEC
        SBC     ($02), X                        ; Compare with next number in list
        BPL     NO_SWAP                         ; Branch if current number is less than or equal to next number

        LDA     ($02), X                        ; Swap current number and next number
        STA     $08
        LDA     ($02), X
        SEC
        SBC     $08
        STA     ($02), X
        CLC
        ADC     $08
        STA     ($02), X

NO_SWAP
        INX                                   ; Increment X register
        JMP     SORT_LOOP                       ; Jump back to SORT_LOOP

SORT_DONE
        RTS                                   ; Return from subroutine
