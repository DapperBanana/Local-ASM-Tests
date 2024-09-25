
    .org $0200

start:
    LDA #$00        ; Initialize max as 0
    STA max
    
    LDX #$00        ; Initialize index as 0
    STX index
    
loop:
    LDA numbers,X   ; Load the number at index X
    CMP max         ; Compare with max
    BCC updateMax   ; Branch if the number is greater than max
    
    JMP nextNumber
updateMax:
    STA max         ; Update max with the new largest number

nextNumber:
    INX             ; Increment index
    CPX #count      ; Compare index with count
    BNE loop        ; If index is not equal to count, loop
    
    BRK             ; Exit

numbers:
    .byte 5, 8, 12, 3, 9, 15   ; List of numbers
count = * - numbers             ; Calculate count of numbers

max:
    .byte $00
index:
    .byte $00

    .end
