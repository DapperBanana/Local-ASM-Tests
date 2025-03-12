
; Program to check if a given number is a perfect digital invariant

START LDA NUM     ; Load the number to be checked
      STA TEMP    ; Store it in TEMP for comparison later
      LDX #0      ; Initialize index X with 0

LOOP  LSR          ; Shift the number to the right
      BCC NOT_PDI ; If the carry flag is not set, continue checking
      STA DIGIT,X ; Store the digit in the DIGIT array
      INX         ; Increment the index
      CPX #4      ; Check if all digits have been processed
      BEQ CHECK   ; If yes, check if it is a perfect digital invariant
      JMP LOOP    ; Continue looping

NOT_PDI
      STA TEMP2  ; Store the number in TEMP2 for later comparison
      LDX #0     ; Reset index X
      LDA #0     ; Initialize accumulator with 0

CHK_LOOP
      CLC       ; Clear carry flag
      ADC DIGIT,X ; Add the current digit to the accumulator
      INX       ; Increment index
      CPX #4    ; Check if all digits have been processed
      BNE CHK_LOOP ; If not, continue checking

      CMP TEMP   ; Compare the result with the original number
      BEQ IS_PDI ; If they are equal, it is a perfect digital invariant
      JMP NOT_PDI ; If not, it is not a perfect digital invariant

IS_PDI
      ; Output message that the number is a perfect digital invariant
      LDA #$02  ; Load sys call to print text
      LDX #MSG_IS_PDI ; Load message address
      JMP $FFEF    ; Call Kernal service

CHECK
      LDX #0       ; Reset index X
      LDA #0       ; Initialize accumulator with 0
      JMP CHK_LOOP ; Jump to CHK_LOOP to check if it is a perfect digital invariant

NUM   .BYTE $55    ; Example input number
TEMP  .BYTE $00    ; Temporary storage for original number
TEMP2 .BYTE $00    ; Temporary storage for processed number
DIGIT .BYTE $00,$00,$00,$00 ; Array to store individual digits

MSG_IS_PDI .BYTE "Perfect Digital Invariant", $00 ; Message to be displayed

      .END
