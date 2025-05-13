
    ; Program to calculate the median of a list of numbers
    
    ORG $1000
    
    LDA #0              ; Initialize sum to 0
    STA sum
    LDA #0              ; Initialize count to 0
    STA count

next_num:
    LDA numbers, X      ; Load next number from list
    CMP #255            ; Check if end of list
    BEQ calculate_median
    
    CLC
    ADC sum             ; Add number to sum
    STA sum
    
    INC count           ; Increment count
    
    INX                 ; Move to next number in list
    JMP next_num        ; Repeat for next number
    
calculate_median:
    LDA count           ; Load the count of numbers
    ASL                 ; Multiply by 2
    TAX
    
    LDA sum             ; Load the sum of numbers
    SEC
    SBC #0              ; Subtract 0, carry flag is set
    LSR                 ; Divide by 2
    
    LDX count           ; Load the count of numbers
    LSR
    
    LDY #0
    LDA numbers, Y
    STA median
    
    CPX #1
    BEQ display_median
    
find_median:
    CLC
    ADC #1
    TAY
    LDA numbers, Y
    STA median
    
    LDA count
    SEC
    SBC #1
    CMP #0
    BNE find_median
    
display_median:
    LDA median          ; Load the median
    ; Use the median as needed
    
    BRK
    
sum:    .byte 0
count:  .byte 0
median: .byte 0
    
numbers:                ; List of numbers, terminate with 255
    .byte 10, 7, 5, 12, 8, 11, 255
    
    ; End of program
    .ORG $FFFC
    .word $1000
