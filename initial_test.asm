
ORG $0200

START:

    LDA #0          ; Initialize register A with 0
    STA $01         ; Clear memory address $01
    
    LDX #0          ; Initialize register X with 0
    
LOOP:
    LDA DATA,X      ; Load the data from the linked list into A
    BEQ END_LOOP    ; If data is 0, end the loop
    
    ; Perform operations on the data here
    ; For example, you could add 1 to each element
    
    INX             ; Increment X to point to the next element
    JMP LOOP        ; Repeat the loop
    
END_LOOP:
    BRK             ; End the program

DATA:
    .BYTE 2,5,7,0    ; Define the linked list data
    
    .END            ; End of program
