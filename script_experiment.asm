
START     LDA #0               ; Initialize sum of numbers
          STA SUM
          LDX #0               ; Initialize count of numbers
          STX COUNT
          
LOOP      LDA NUMBERS,X        ; Load next number from list
          BEQ DONE             ; Branch if end of list reached
          CLC
          ADC SUM              ; Add to sum
          STA SUM
          INX
          INX                  ; Increment count
          BNE LOOP
          
DONE      LDA COUNT            ; Load count
          LSR                  ; Divide by 2
          BCS ODD              ; If count is odd, branch to calculate median for odd count
          
EVEN      LDA SUM              ; Load sum
          LSR                  ; Divide by 2 to get average
          STA MEDIAN
          RTS

ODD       LDA COUNT            ; Load count
          ASL                  ; Multiply by 2
          TAX                  ; Store count in X
          LDX #0
          
ODD_LOOP  LDA NUMBERS,X        ; Load next number from list
          BEQ ODD_MEDIAN       ; Branch if end of list reached
          INX
          INX                  ; Increment count
          BNE ODD_LOOP
          
ODD_MEDIAN LDA NUMBERS,X        ; Load median
          STA MEDIAN
          RTS
          
NUMBERS   .BYTE 5,8,3,6,2      ; List of numbers
SUM       .BYTE 0              ; Variable to store sum
COUNT     .BYTE 0              ; Variable to store count
MEDIAN    .BYTE 0              ; Variable to store median
