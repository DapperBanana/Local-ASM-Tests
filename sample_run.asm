
PRIME_FACTORS:
  LDX #2          ; start with the smallest possible prime factor
LOOP:
  CPX NUM         ; have we reached the end of the search?
  BEQ DONE        ; if so, we are done finding prime factors
  CPY #0          ; check if NUM is divisible by X
  BEQ IS_FACTOR   ; if the division result is 0, then X is a factor
  LDA #0          ; if NUM is not divisible by X, increment X
  INX
  JMP LOOP        ; repeat the loop with the new X value
IS_FACTOR:
  TYA             ; store the current NUM value
  PHA
  LDA X           ; store the current X value
  PHA
  JSR DIVIDE      ; call a subroutine to divide NUM by X
  PLA             ; retrieve the current X value
  STA Y
  PLA             ; retrieve the current NUM value
  CMP #1          ; check if the division result is 1
  BEQ DONE        ; if the division result is 1, then we have found all prime factors
  JMP IS_FACTOR   ; if not, repeat the loop with the updated NUM value
DIVIDE:
  PHA             ; save A and Y registers
  TYA
  PHA
  TYA             ; copy the current NUM value to X
  TXA
  STA TEMP        ; store the current NUM value for later use
  TXA
  TYA
  SEC             ; initialize the subtraction
  SBC Y           ; subtract the current factor value from NUM
  TAY             ; store the division result in Y register
  LDA TEMP        ; restore the current NUM value
  PLA
  STA TEMP
  PLA
  RTS             ; return from the subroutine
DONE:
  RTS             ; end of program
