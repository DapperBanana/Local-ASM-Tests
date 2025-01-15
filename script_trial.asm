
ORG $1000

START:
    ; Initialize variables
    LDX #$00          ; X register will be used as a counter
    STX current       ; Initialize the current pointer with 0 (start of the list)

    ; Add elements to the linked list
    LDA #5            ; Add element 5 to the list
    JSR ADD_ELEMENT

    LDA #10           ; Add element 10 to the list
    JSR ADD_ELEMENT

    ; Print the contents of the list
    JSR PRINT_LIST

    ; End of program
    BRK

ADD_ELEMENT:
    ; Allocate memory for a new node
    LDA #2            ; Set the size of the node (2 bytes for data and pointer)
    JSR ALLOCATE_MEMORY
    STA (temp_ptr), Y ; Store the data in the allocated memory
    INY

    ; Add the new element to the list
    LDA current       ; Load the current pointer
    STA temp_ptr      ; Store it in the temp_ptr
    LDA temp_ptr +1
    STA temp_ptr +1

    ; Update the current pointer to point to the new element
    LDA Y
    STA current
    RTS

PRINT_LIST:
    ; Print the contents of the list
    LDA current
    BEQ END_PRINT     ; If the list is empty, skip printing

    PRINT_LOOP:
        LDA (current), Y  ; Load the data of the current node
        JSR PRINT_NUMBER  ; Print the data
        LDA current +1    ; Get the pointer to the next node
        STA current
        LDA current +2
        STA current +1
        BNE PRINT_LOOP    ; If pointer is not zero, continue looping

    END_PRINT:
        RTS

PRINT_NUMBER:
    ; Print the number stored in the accumulator
    ; This code should be implemented based on the specific hardware being used
    RTS

ALLOCATE_MEMORY:
    ; Allocate memory for a new node in the list
    ; This code should be implemented based on the specific hardware being used
    RTS

current:
    .BYTE $00, $00     ; Pointer to the current node in the list

temp_ptr:
    .BYTE $00, $00     ; Temporary pointer used for adding elements to the list

    .END
