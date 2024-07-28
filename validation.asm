
START LDX #0        ; Initialize index register X to 0
      LDA STR,X     ; Load first character of the string into accumulator
CHECK LDX #0        ; Initialize index register Y to 0
LOOP  CMP STR,Y     ; Compare character at index X with character at index Y
      BEQ DUPLICATE ; Branch if characters match (duplicate found)
      INY           ; Increment index register Y
      CPY LEN       ; Compare index register Y with length of string
      BNE LOOP      ; Branch back to LOOP if end of string not reached
      INX            ; Increment index register X
      CPX LEN        ; Compare index register X with length of string
      BCC CHECK      ; Branch back to CHECK if not end of string

IS_ISOGRAM JMP IS_ISOGRAM ; String is an isogram
DUPLICATE BRK           ; Exit program if duplicate is found

STR    .ASCII "HELLO"  ; String to check for isogram
LEN    = * - STR        ; Calculate length of string

      .ORG $FFFC      ; Program entry point
      .WORD START     ; Jump to START at program start
