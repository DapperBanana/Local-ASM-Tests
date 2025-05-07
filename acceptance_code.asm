
js_filename = "crud.js"

SYS_EXEC = $ff      ; system call to execute a file

  LDX #js_filename
  LDY #00
  STX filename
  STY filename+1

  LDX #$0A
  LDY #$0A
  JSR SYS_EXEC
