
    .txt "Median Calculation Program"
    
    .org $0200
    
    LDX #0                 ; Initialize index to zero
    STX index
    LDA #10                 ; Set length of array to 10
    STA length
    LDA #20                 ; Load the array with numbers
    STA numbers1
    LDA #30
    STA numbers2
    LDA #40
    STA numbers3
    LDA #50
    STA numbers4
    LDA #60
    STA numbers5
    LDA #70
    STA numbers6
    LDA #80
    STA numbers7
    LDA #90
    STA numbers8
    LDA #100
    STA numbers9
    LDA #110
    STA numbers10
    
getMedian:
    LDA length              ; Load length of array
    JSR divideBy2           ; Divide length by 2 to find the middle index
    TAX                     ; Save the middle index in X
    LDA #$00                ; Load 0 into A to clear upper byte of W
    STA $01                 ; Clear the upper byte of W
    LDA (index),Y           ; Load the value at index Y into A
    STA W1
    INY                     ; Increment Y for the next value
    
compareLoop:
    CPY length              ; Compare Y with length
    BEQ finish              ; If Y = length, finish the program
    LDA W1                  ; Load the value at index X into A
    INC X                   ; Increment X to move to the next index
    CMP (index),Y           ; Compare the value at index Y with A
    BMI skipSwap            ; If value at index Y is less than A, skip swap
    STA temp                ; Swap the values at indices X and Y
    LDA (index),Y
    STA (index),X
    LDA temp
    STA (index),Y
    
skipSwap:
    LDA (index),Y           ; Load the value at index Y into A
    STA W1                  ; Store the value in W1
    INY                     ; Increment Y for the next value
    JMP compareLoop         ; Repeat the comparison loop
    
finish:
    LDA W1                  ; Load the median value into A
    STA median
    RTS
    
divideBy2:
    SEC
    LDA #$02
    SBC #$01
    RTS
    
    .org $F000
    
index:  .ds 1
length: .ds 1
median: .ds 1
temp:   .ds 1
W1:     .ds 2
numbers1:  .ds 1
numbers2:  .ds 1
numbers3:  .ds 1
numbers4:  .ds 1
numbers5:  .ds 1
numbers6:  .ds 1
numbers7:  .ds 1
numbers8:  .ds 1
numbers9:  .ds 1
numbers10: .ds 1
