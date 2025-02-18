
START:
      LDX #0          ; Initialize index register X to 0
READ:
      LDA MESSAGE,X   ; Load character from MESSAGE into A
      BEQ FINISH      ; Branch to FINISH if character is null terminator
      INX             ; Increment index register X
      JMP READ        ; Jump back to READ

REVERSE:
      DEX             ; Decrement index register X
      BEQ DONE        ; Branch to DONE if index is 0
      STA OUTPUT,X    ; Store character from A to OUTPUT
      JMP REVERSE     ; Jump back to REVERSE

FINISH:
      STX LENGTH      ; Store length in LENGTH
      LDX #0          ; Initialize index register X to 0
      JMP REVERSE     ; Jump to REVERSE

DONE:
      LDY #0          ; Initialize index register Y to 0
PRINT:
      LDA OUTPUT,Y    ; Load character from OUTPUT into A
      BEQ END         ; Branch to END if character is null terminator
      JSR $FFD2       ; Call KERNAL subroutine to print character to screen
      INY             ; Increment index register Y
      JMP PRINT       ; Jump back to PRINT

END:
      RTS             ; Return from subroutine

MESSAGE:
      .ASCII "HELLO, WORLD!" ; Input string
OUTPUT:
      .BLKW 20       ; Output string
LENGTH:
      .BYTE 0        ; Store length of string

      .ORG $2C00    ; Start address of the program

      JMP START     ; Jump to start of the program
