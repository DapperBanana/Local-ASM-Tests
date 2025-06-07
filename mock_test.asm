
    .org   $200

start 
    LDX  #0              ; initialize index
    LDY  #0              ; initialize result string index

loop
    LDA  input, X        ; load character from input string
    CMP  #0              ; check for null terminator
    BEQ  done            ; if null terminator, exit loop

    CMP  #44             ; check for comma
    BEQ  next_char       ; if comma, skip to next character

    CMP  #46             ; check for period
    BEQ  next_char       ; if period, skip to next character

    STA  result, Y       ; store character in result string
    INY                  ; increment result index

next_char
    INX                  ; increment input index
    JMP  loop

done
    STY  result_end      ; store end of result string
    RTS

input
    .byte "Hello, World!", 0

result
    .byte 0
result_end
