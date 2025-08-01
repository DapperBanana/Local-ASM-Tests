
ORG $6000    ; Start of program memory space

LDA #9       ; Load the number of elements in the list
STA COUNT

LDX #0       ; Initialize X register to 0

LOOP:
    LDA NUMBERS, X  ; Load the current number in the list
    STA TEMP        ; Store it in TEMP for comparison
    INX             ; Increment X to get the next number
    
INNER_LOOP:
    LDY #0          ; Initialize Y register to 0
    LDA NUMBERS, Y  ; Load the next number in the list
    CMP TEMP        ; Compare it with TEMP
    BCC NO_SWAP     ; Branch if the next number is not smaller
    
    STA TEMP        ; Swap the numbers
    STY NUMBERS, X
    DEC Y
    STY NUMBERS, Y

NO_SWAP:
    INY             ; Increment Y to get the next number
    CPY COUNT       ; Check if Y has reached the end of the list
    BCC INNER_LOOP  ; Repeat inner loop if not
    
    DEX             ; Decrement X to move to the next element
    CPX COUNT       ; Check if X has reached the end of the list
    BCC LOOP        ; Repeat outer loop if not
    
    BRK             ; Exit the program

TEMP:   .BYTE 0      ; Temporary variable for comparison
COUNT:  .BYTE 0      ; Number of elements in the list
NUMBERS: .BLOCK 10   ; List of integers to be sorted

.END            ; End of program
