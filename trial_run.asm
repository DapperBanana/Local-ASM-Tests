
    ORG $1000          ; Start address
    
START
    LDX #0             ; Initialize index X to 0
    
LOOP
    ; Load the next element from the list into A
    LDA LIST,X
    
    ; Multiply the element by itself to get the square
    STA RESULT,X
    CLC
    ADC RESULT,X
    
    ; Increment index X
    INX
    
    ; Check if all elements have been processed
    CPX #LENGTH
    BNE LOOP
    
    ; End of program
    BRK
    
LIST
    .BYTE 2, 4, 6, 8, 10   ; List of numbers
LENGTH
    .BYTE 5                ; Length of the list
RESULT
    .BLOCK 5               ; Storage for the square of each element
