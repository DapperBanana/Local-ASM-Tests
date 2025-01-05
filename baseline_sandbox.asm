
SORT_LIST:
  LDX #10         ; Set the length of the list
  LDA #0          ; Set flag to indicate no swaps
LOOP:
  LDY #0          ; Set flag to indicate no swaps in this pass
  LDX #10         ; Reset index of items to sort
  
INNER_LOOP:
  LDA NUMBERS,X   ; Load current number
  CMP NUMBERS+1,X ; Compare with next number
  BMI SKIP_SWAP   ; Branch if no swap needed
  STA TEMP        ; Swap numbers
  LDA NUMBERS+1,X
  STA NUMBERS,X
  LDA TEMP
  STA NUMBERS+1,X
  LDA #1          ; Set swap flag
  STY #1          ; Set swap flag for current pass
  
SKIP_SWAP:
  DEX             ; Move to next pair of numbers
  BPL INNER_LOOP  ; Repeat inner loop if not done
  
  LDX #10         ; Reset index of items to sort
  CPX #2          ; Check if more than 1 pass is necessary
  BEQ DONE        ; Exit if no swaps were made in last pass
  BEQ THISPASS
  DEC ; Decrement pass
  JMP INNER_LOOP ; Repeat inner loop if more passes required
  
DONE:
  RTS
  
NUMBERS .BYTE 7, 4, 2, 8, 1, 5, 9, 3, 6, 0
TEMP    .BYTE 0
