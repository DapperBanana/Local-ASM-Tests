
START:
    LDA #<ARRAY        ; Load the low byte of the address of the start of the array
    STA PTR
    LDA #>ARRAY         ; Load the high byte of the address of the start of the array
    STA PTR+1
    LDA #LENGTH         ; Load the number of elements in the array
    STA COUNT

    LDA #VALUE          ; Load the value to search for
    STA SEARCH_VALUE

    JSR BINARY_SEARCH

    BRK                 ; Exit the program

ARRAY:
    .byte 1, 3, 5, 7, 9, 11, 13, 15  ; Sorted list of values
VALUE:
    .byte 9                         ; Value to search for
LENGTH:
    .byte 8                         ; Length of the array
SEARCH_VALUE:
    .byte 0

PTR:
    .word 0             ; Pointer to the current element being compared
COUNT:
    .byte 0             ; Number of remaining elements in the array

BINARY_SEARCH:
    LDA #0              ; Initialize low index to zero
    STA LOW_INDEX
    LDA COUNT           ; Initialize high index to (count - 1)
    SEC
    SBC #1
    STA HIGH_INDEX

LOOP:
    LDA LOW_INDEX
    CMP HIGH_INDEX
    BEQ NOT_FOUND       ; If low index >= high index, value not found

    LDA LOW_INDEX
    CLC
    ADC HIGH_INDEX
    LSR                 ; Calculate mid index
    STA MID_INDEX

    LDA MID_INDEX
    ASL
    TAX
    LDA PTR
    CLC
    ADC #0
    TAX
    LDA PTR+1
    STA TMP
    LDA MID_INDEX
    STA TMP+1

    LDA SEARCH_VALUE
    CMP (TMP),X         ; Compare the value at mid index with the search value
    BEQ FOUND           ; If equal, value found
    BCC SEARCH_LOWER    ; If less than, search lower half
    BCS SEARCH_UPPER    ; If greater than, search upper half

SEARCH_LOWER:
    LDA MID_INDEX
    SEC
    SBC #1
    STA HIGH_INDEX
    JMP LOOP

SEARCH_UPPER:
    LDA MID_INDEX
    STA LOW_INDEX
    JMP LOOP

FOUND:
    LDA SEARCH_VALUE
    STA TMP
    LDA #0
    STA TMP+1

    LDA TMP
    STA $D020           ; Print the index of the found value
    LDA TMP+1
    STA $D021

    RTS

NOT_FOUND:
    LDA #0
    STA $D020           ; If value not found, print 00
    STA $D021

    RTS
