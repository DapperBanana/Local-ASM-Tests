
    .org $0200

start:
    jsr getString      ; Get the input string
    jsr validateIPv4   ; Check if the input is a valid IPv4 address
    bcs validAddress   ; Branch if the address is valid

invalidAddress:
    lda #<errorMessage
    sta $02
    lda #>errorMessage
    sta $03
    jsr printString    ; Print error message
    jmp $FFD2          ; End program

validAddress:
    lda #<successMessage
    sta $02
    lda #>successMessage
    sta $03
    jsr printString    ; Print success message
    jmp $FFD2          ; End program

getString:
    lda #$00           ; Initialize counter
    ldx #0             ; Clear X register
    lda $FF           ; Wait for key press
    cmp #$0D          ; Check if Enter key is pressed
    beq endInput      ; If so, end input
    sta $C000, X      ; Store input character
    inc $C000
    inx               ; Increment X register
    bne getString     ; Repeat
endInput:
    rts

validateIPv4:
    lda $C000       ; Check first octet
    cmp #$30        ; Check if it's in range '0'-'9'
    bcc invalidIP   ; If not, invalid address
    cmp #$39
    bcs invalidIP
    lda $C001       ; Check second octet
    cmp #$30
    bcc invalidIP
    cmp #$39
    bcs invalidIP
    lda $C002       ; Check third octet
    cmp #$30
    bcc invalidIP
    cmp #$39
    bcs invalidIP
    lda $C003       ; Check fourth octet
    cmp #$30
    bcc invalidIP
    cmp #$39
    bcs invalidIP
    lda #$00
    rts

invalidIP:
    lda #$01
    rts

printString:
    lda #$00
    sta $D020       ; Initialize screen position
nextChar:
    lda ($02), Y    ; Load character
    cmp #$00        ; Check for null terminator
    beq endPrint    ; If found, end printing
    jsr $FFD2       ; Print character
    inc $02         ; Move to next character
    bne nextChar    ; Repeat
endPrint:
    rts

errorMessage:
    .text "Invalid IPv4 address", $00

successMessage:
    .text "Valid IPv4 address", $00
