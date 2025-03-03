
         .org    $0200       ; Start address of program

         LDA     #11         ; Load the number of sides of the hendecagon
         STA     sides

         LDA     #12         ; Load the value of the constant 12
         STA     constant

         LDA     #3          ; Load the value of the constant 3
         STA     alpha

         LDA     #1          ; Load the value of the constant 1
         STA     beta

         LDA     #0          ; Initialize accumulator to 0
         STA     result      ; Variable to store the final result

loop     LDA     sides       ; Load the number of sides
         SEC
         SBC     #1          ; Subtract 1 from the number of sides
         TAX                  ; Store the result in X register
         
         LDA     constant
         STA     temp         ; Store the value of the constant 12
         STA     temp2
         
         LDA     alpha        ; Load the value of the constant 3
         SEC
         SBC     beta         ; Subtract the value of the constant 1
         TAX                  ; Store the result in X register

         LDX     temp         ; Load the value of the constant 12
         STX     temp2

         CLC
         ADC     result       ; Add the current result
         STA     result       ; Store the updated result

         LDY     temp2
         
         DEX
         BNE     loop         ; Loop until all sides have been processed

         BRK                 ; End program

sides    .byte   0
temp     .byte   0
temp2    .byte   0
constant .byte  0
alpha    .byte   0
beta     .byte   0
result   .byte   0

         .end
