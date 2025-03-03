
ORG $1000

.data
dataDict  .byte $05, $0A, $0F, $07, $03   ; Dictionary of data to be represented as a bar chart

.text
start   LDX #0                  ; Initialize X to zero (index of data dictionary)
loop    LDA dataDict, X         ; Load data value from dictionary
        STA $D000               ; Output value as a bar chart
        INX
        CPX #5                  ; Compare index with the length of dictionary
        BNE loop                ; Continue looping until all data values are processed

end     BRK                     ; End of program

.end
