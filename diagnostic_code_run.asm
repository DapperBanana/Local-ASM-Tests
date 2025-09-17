
; Load the starting address of the list into memory
LDA #<list
LDX #>list
STA $00
STX $01

; Initialize variables
LDX #$00     ; current sequence length
LDY #$00     ; longest sequence length
LDA #$FF     ; previous value

loop:
  ; Load the next value from the list
  LDA ($00),Y
  BEQ end        ; break if end of list is reached

  ; Compare the current value with the previous value
  CMP #$FF
  BEQ next      ; skip first value

  CMP $02        ; compare with previous value
  BNE reset     ; reset sequence if not consecutive

  ; Increment the current sequence length
  INX
  CPX #$FF     ; check for overflow
  BEQ reset    ; reset if overflow

  ; Update the longest sequence length
  CPX $03
  BCC loop      ; continue if current sequence is shorter
  LDX $03      ; update longest sequence length
  LDA #$FF     ; update previous value

  next:
    INY
    JMP loop

  reset:
    LDX #$00
    LDA #$FF

    JMP loop

  end:
    ; The longest consecutive sequence length is in register X
    BRK

  ; List of integers
  list:
  .byte 1, 2, 3, 5, 6, 7, 8, 10, 11, 12, 13, 14
