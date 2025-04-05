
; Matrix Multiplication Program
;

.org $0200
START LDX #0        ; Initialize loop counters
     LDY #0

LOOP1 LDA MATRIX1, X  ; Load element from first matrix
      STA TEMP1       ; Store it in TEMP1

      LDY #0          ; Reset column counter for second matrix

LOOP2 LDA MATRIX2, Y  ; Load element from second matrix
      STA TEMP2       ; Store it in TEMP2

      LDA RESULT, X    ; Load element from result matrix
      CLC
      ADC TEMP1, *     ; Add product of elements to result matrix
      STA RESULT, X

      DEY                 ; Decrement column counter for second matrix
      INY                 ; Increment row counter for first matrix

      CPY #3              ; Check if all columns of second matrix have been traversed
      BNE LOOP2           ; If not, loop back

      INX                 ; Increment column counter for first matrix
      CPX #3              ; Check if all columns of first matrix have been traversed
      BNE LOOP1           ; If not, loop back

DONE  BRK

MATRIX1 .BYTE 1, 2, 3, 4
        .BYTE 5, 6, 7, 8
        .BYTE 9, 10, 11, 12

MATRIX2 .BYTE 1, 2, 3
        .BYTE 4, 5, 6
        .BYTE 7, 8, 9
        .BYTE 10, 11, 12

RESULT  .BYTE 0, 0, 0
        .BYTE 0, 0, 0
        .BYTE 0, 0, 0

TEMP1   .BYTE 0
TEMP2   .BYTE 0

     .END
