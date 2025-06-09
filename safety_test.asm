
.DATA
data_dict:
  .byte 10, 20, 30, 40, 50  ; Sample data values

.CODE
start:
  LDX #0  ; Initialize index
  LDA data_dict,X  ; Load data value into A register
  JSR draw_bar  ; Draw bar chart for the data value
  INX  ; Increment index
  CPX #5  ; Compare index to number of data values
  BNE start  ; Branch if not equal to loop through all values

  BRK  ; End program

draw_bar:
  STA $2000  ; Set start of bar chart at memory address $2000
  LDX #0  ; Initialize counter for drawing bar
loop:
  CMP #$00  ; Compare data value to 0
  BEQ end  ; Branch if equal, end drawing bar
  STA $2000,X  ; Set data value at current memory address
  INX  ; Increment memory address
  DEC A  ; Decrement data value
  JMP loop  ; Jump back to loop
end:
  RTS
