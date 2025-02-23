
    ORG $0200

START
    LDA $2001        ; Load the length of the list
    BNE BEGIN        ; Branch if list is not empty

END
    BRK              ; Exit the program

BEGIN
    LDX #$00         ; Initialize index to zero
    CLC              ; Clear the carry flag

LOOP
    LDA $2000, X     ; Load the next number in the list
    ADC $2000, X     ; Add the number to the running sum
    INX              ; Increment index
    CPX $2001        ; Compare index to length of list
    BNE LOOP         ; Loop until end of list
    
    LSR              ; Divide the sum by 2 to get the average
    STA $2002        ; Store the median in memory
    
    JMP END          ; End the program
