
      ORG $0200

CHECK_ISBN:
      LDX #0            ; Initialize index to 0
      LDY #0            ; Initialize count to 0
      LDA #$00          ; Initialize checksum to 0

LOOP:
      LDA INPUT, X      ; Load character of input string
      BEQ VALID         ; Branch if end of string reached

      CMP #'-'          ; Check if character is a hyphen
      BEQ CONTINUE      ; Branch if hyphen found
      
      CMP #'X'          ; Check if character is 'X'
      BEQ X_FOUND       ; Branch if 'X' found

      CMP #0            ; Check if character is a digit
      BMI INVALID       ; Branch if character is not a digit

      SEC               ; Clear carry flag for addition
      SBC #48           ; Convert character to actual number
      STA TEMP          ; Store the number in TEMP

      INX               ; Increment index
      CPY #10           ; Check if already counted 10 characters
      BCS INVALID       ; Branch if more than 10 characters
      LDA TEMP
      ADC Y             ; Add the number to checksum
      STA Y

      BCC CONTINUE      ; Branch if no carry

      INY               ; Increment count by 1
      LDA Y
      CMP #10           ; Check if count reached 10
      BNE CONTINUE

      INC X             ; Increment index by 1 (to skip hyphen)
      
CONTINUE:
      INX               ; Increment index
      BNE LOOP          ; Continue loop
      INC X             ; Increment index by 1 (to skip null terminator)
      BNE LOOP

VALID:
      LDA Y
      CMP #11           ; Check if 10 characters have been counted
      BNE INVALID       ; Branch if less than 10 characters

      LDA TEMP
      CMP #10           ; Check if last character is a digit or 'X'
      BCC INVALID       ; Branch if less than 10 characters

      LDA Y
      CMP #0            ; Check if checksum is divisible by 11
      BEQ IS_VALID      ; Branch if valid ISBN number
      BRA INVALID

X_FOUND:
      LDX #3
      LDA #10           ; Account X as 10
      STA Y             ; Add 10 to checksum
      INY
      BRA CONTINUE

IS_VALID:
      LDA #1            ; Set success code to 1
      STA RESULT

INVALID:
      LDA #0            ; Set success code to 0
      STA RESULT

      RTS

INPUT:
      .BYTE '9','-','7','8','8','2','4','4','7','7','1', 0

TEMP: .BYTE 0
RESULT: .BYTE 0

      END
