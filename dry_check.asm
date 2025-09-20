
    ; Program to calculate the median of a list of numbers
    
    .org $0200
    
numbers    .byte 1, 5, 9, 3, 7, 2, 8, 6, 4     ; List of numbers
length     = ($ - numbers)                    ; Length of the list

start:
    ldx #0                                  ; Initialize index to 0
    lda #0                                  ; Initialize sum to 0
    sta sum                                
    
loop:
    lda numbers, x                         ; Load next number
    clc                                    ; Clear carry flag
    adc sum                                ; Add number to sum
    sta sum                                ; Update sum
    
    inx                                    ; Increment index
    cpx length                             ; Check if end of list
    bne loop                               ; If not, continue loop
    
    lsr                                    ; Divide sum by 2 to find median
    lsr
    
    sta median                             ; Store median
    
    ; Program ends here

sum       .byte 0
median    .byte 0

    .end start
