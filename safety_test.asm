
; File Compression Algorithm in 6502 Assembly

; Load source address and destination address
LDX #source_address
LDY #dest_address
LDA #0

compress_loop:
; Load byte from source address
LDA (X), y

; Check if byte is repeated
CMP (X), y+1
BNE store_byte

; If byte is repeated, count repetitions
LDX #1
repeated_loop:
CPY #255
BEQ store_byte

; Count repetitions
INC X
INC Y
CMP (X), y
BEQ repeated_loop

; Store the repeated byte and repetition count
store_byte:
STA (Y),X
INY

; Check if end of file is reached
CPX #end_of_file
BEQ end

JMP compress_loop

end:
RTS

; Data section
source_address:
.byte $00, $01, $01, $02, $02, $02
.byte $03, $03, $03, $03, $04, $04

dest_address:
.byte $00
.byte $01

end_of_file:
.byte $04
