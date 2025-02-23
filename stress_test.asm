
JSON_START equ $2000  ; Start address of JSON file

SEI
CLD

LDX #$00  ; Initialize X register
LDY #$00  ; Initialize Y register

read_loop: ; Loop to read JSON file
    LDA JSON_START, Y  ; Load byte from JSON file
    CMP #$7B  ; Check for start of object '{'
    BEQ read_key  ; If start of object, go to read_key
    INC Y  ; Move to next byte
    JMP read_loop  ; Continue reading JSON file

read_key:
    INC Y  ; Skip '{'

key_loop: ; Loop to read key of key-value pair
    LDA JSON_START, Y  ; Load byte from JSON file
    CMP #$22  ; Check for key delimiter '"'
    BEQ read_colon  ; If key delimiter, go to read_colon
    STA $FF  ; Store key in memory for printing later
    INC Y  ; Move to next byte
    JMP key_loop  ; Continue reading key

read_colon:
    INC Y  ; Skip '"'
    INC Y  ; Skip ':'

value_loop: ; Loop to read value of key-value pair
    LDA JSON_START, Y  ; Load byte from JSON file
    CMP #$2C  ; Check for end of pair ','
    BEQ print_pair  ; If end of pair, go to print_pair
    STA $FF  ; Store value in memory for printing later
    INC Y  ; Move to next byte
    JMP value_loop  ; Continue reading value

print_pair:
    LDX #$00  ; Initialize X register for printing
    LDA $FF, X  ; Load key from memory
    JSR print_string  ; Print key
    JSR print_separator  ; Print separator ':'
    INX  ; Move to value in memory
    LDA $FF, X  ; Load value from memory
    JSR print_string  ; Print value
    JSR print_separator  ; Print separator ','
    
    INC Y  ; Move to next key
    JMP key_loop  ; Repeat process for next key

print_string:
    STA $FE  ; Store character for printing
    LDA $FE  ; Load character
    JSR $FFD2  ; Print character
    RTS

print_separator:
    LDA #$20  ; Load separator (space)
    JSR $FFD2  ; Print separator
    RTS

BRK
