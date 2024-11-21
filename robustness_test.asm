
.include "6502.h"

ORG $0200

start:
  LDX #$00
  STX message_ptr ; initialize message pointer to 0

getUserInput:
  LDA #'?' ; display prompt character
  JSR $FFCF ; kernal output character
  
  ; read user input
  JSR $FF00 ; kernal input character
  STA message_buffer, X ; store user input in message buffer
  INX
  CPX #$40 ; check if message is too long
  BNE getUserInput ; if not, continue getting input
  
  ; display user input
  LDY #$00
  LDX message_ptr ; load message pointer
displayInputLoop:
  LDA message_buffer, X ; load character from message buffer
  BEQ endDisplayInput ; if end of message, exit loop
  JSR $FFCF ; display character
  INX
  INY
  BNE displayInputLoop

endDisplayInput:
  
  ; check if user entered 'exit' to quit program
  LDX #$00
checkExit:
  LDA message_buffer, X
  CMP #$65 ; 'e'
  BNE notExit
  INX
  LDA message_buffer, X
  CMP #$78 ; 'x'
  BNE notExit
  INX
  LDA message_buffer, X
  CMP #$69 ; 'i'
  BNE notExit
  INX
  LDA message_buffer, X
  CMP #$74 ; 't'
  BNE notExit
  JMP $FFD2 ; quit program

notExit:
  ; clear message buffer
  LDX #$00
clearBufferLoop:
  LDA #' '
  STA message_buffer, X
  INX
  CPX #$40
  BNE clearBufferLoop

  JMP getUserInput ; repeat process

message_ptr: .BYTE $00
message_buffer: .BLOCK $40

END start
