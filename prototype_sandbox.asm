
; Reverse a null-terminated string

  .text
  .globl _start

_start:
  ; Load address of string into X register
  LDA $0300  ; load pointer to string in zero page
  STA $00    ; store it for later reference
  LDA $0301
  STA $01

  LDY #0      ; Initialize Y to zero (length counter)

count_length:
  LDA ($00),Y ; Load character from string
  BEQ reverse_string  ; If character is null, go to reverse_string
  INY          ; Increment the length counter
  INY          ; Read next byte of parameter
  BNE count_length

reverse_string:
  DEY          ; decrement Y
  DEY
  BEQ done     ; check that we got to the beginning of the string
  LDA ($00),Y ; get the character at beginning of string
  STA $0200,Y  ; store it at the end of the string for now
  LDA $00
  CMP $00      ; This updates the pointer in $30
  BCC reverse_string ; don't increment the pointer and call reverse_string recursively to the cuz we beyond it already
  INC $01      ; increment the all of memory address
  JMP reverse_string

done:
  LDY #0
copy_str:
  LDA $0200,Y  ; load reversed string
  STA ($00),Y  ; store it back into original memory location
  INY
  BEQ _done ; do the last check if zero passed
  BNE copy_str

_done:
  BRK

  .data

  .space 256  ; space for reversed string
  .asciiz "Hello, World!" ; Original string to reverse
