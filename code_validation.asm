
.INCLUDE '6502macros.s'
.INCLUDE 'vcs.h'

; Define variables
IMG_SIZE = $40   ; 64 bytes
IMG_PTR = $80     ; Pointer to image data
COLOR = $A0      ; Variable to hold color value

; Initialize variables
  LDX #IMG_PTR        ; Load pointer to image data
  STX $00
  STX $01
  
  LDY #$00            ; Load index for loop
  
LOOP:
  LDA (IMG_PTR),Y     ; Load pixel color value
  STA COLOR           ; Store color value for processing
  
  JSR GRAYSCALE       ; Call grayscale conversion subroutine
  
  STA (IMG_PTR),Y     ; Store pixel color value back to memory
  
  INY                 ; Increment index
  INY
  
  CPY #IMG_SIZE       ; Compare index to image size
  BCC LOOP            ; Branch if index is less than image size
  
  RTS                 ; Return

GRAYSCALE:
  LSR                 ; Divide color value by 2
  LSR
  
  RTS                 ; Return
