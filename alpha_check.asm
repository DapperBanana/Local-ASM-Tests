
        .text
start:
        lda #0         ; initialize index
        sta index

check_next:
        lda input, x   ; load next character from input string
        cmp #65        ; check if it is a capital letter
        bcc invalid    ; if not, go to invalid address
        cmp #90        ; check if it is a capital letter
        bcc valid      ; if yes, go to valid address
        cmp #97        ; check if it is a lowercase letter
        bcc invalid    ; if not, go to invalid address
        cmp #122       ; check if it is a lowercase letter
        bcc valid      ; if yes, go to valid address
        cmp #48        ; check if it is a number
        bcc invalid    ; if not, go to invalid address
        cmp #57        ; check if it is a number
        bcc valid      ; if yes, go to valid address
        cmp #46        ; check if it is a period
        beq period     ; if yes, go to period address
        cmp #64        ; check if it is an @ symbol
        beq at_symbol  ; if yes, go to at_symbol address
        cmp #45        ; check if it is a hyphen
        beq valid
        cmp #95        ; check if it is an underscore
        beq valid
        bcc invalid

valid:
        inx            ; increment index
        lda input, x   ; load next character
        cmp #0          ; check if it is end of string
        beq valid_address ; if yes, jump to valid_address

        jmp check_next ; continue checking characters

invalid:
        lda #0         ; return 0 if address is invalid
        sta result
        jmp end

valid_address:
        lda #1         ; return 1 if address is valid
        sta result

end:
        rts

period:
        lda input, x   ; load next character after period
        cmp #64         ; check if it is @
        beq invalid     ; if it is, address is invalid
        cmp #48        ; check if it is a number
        bcc invalid
        cmp #57        ; check if it is a number
        bcc valid      ; if yes, go to valid address
        cmp #65        ; check if it is a capital letter
        bcc invalid 
        cmp #90        ; check if it is a capital letter       
        bcc valid
        cmp #97        ; check if it is a lowercase letter       
        bcc invalid
        cmp #122       ; check if it is a lowercase letter
        bcc valid

at_symbol:
        lda input, x   ; load next character after @
        cmp #46        ; check if it is a period
        beq invalid    ; if it is, address is invalid

        jmp check_next ; continue checking characters

        .bss
input:  .asciiz  "testemail@example.com"
index:  .byte  0
result: .byte  0
