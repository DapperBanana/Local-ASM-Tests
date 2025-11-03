
; Valid Credit Card Checker

          .org $0200     ; Start program at memory address 0200

start     LDX #0         ; Initialize index to point to the start of the string
          LDY #0         ; Initialize accumulator for checksum calculation
          LDA $3000,X    ; Load a character from the string
          BEQ end        ; If the character is null, end of string reached
          CMP #$30       ; Compare the character to '0'
          BCC invalid    ; If character is not a digit, invalid credit card number
          CMP #$39       ; Compare the character to '9'
          BCS invalid    ; If character is not a digit, invalid credit card number
          SUB #$30       ; Convert character to numeric value
          STA temp       ; Store numeric value in temp variable
          ASL            ; Multiply by 2
          BCC no_overflow ; Branch if no overflow
          SEC            ; Set carry flag
          SBC #$09       ; Subtract 9 to handle overflow
no_overflow
          ADC temp       ; Add the result to checksum
          INX            ; Move to the next character
          JMP start      ; Continue processing next character

invalid   LDA #$00       ; Invalid credit card number
          STA $4000      ; Store result in memory
          BRK            ; End program

end       LDA #$01       ; Valid credit card number
          STA $4000      ; Store result in memory
          BRK            ; End program

temp      .byte 0        ; Temporary variable for calculations

          .org $3000     ; Input string
          .byte "1234567890123456",0

          .org $4000     ; Output result
          .byte 0

          .end
