
; Check if a string is a valid IPv4 address

        .org    $0600

START:
        LDX     #$00            ; Initialize index for string traversal
        LDA     #4              ; Initialize counter for number of octets

CHECK_OCTET_LOOP:
        JSR     READ_NEXT_CHAR  ; Read the next character from the string
        CMP     #$2E            ; Check if the character is a dot
        BEQ     VALID_IP        ; If dot, check if all 4 octets are checked
        CMP     #$00            ; Check if character is null terminator
        BEQ     INVALID_IP      ; If null terminator reached before all octets checked
        CMP     #$2F            ; Check if the character is a forward slash
        BEQ     INVALID_IP      ; If forward slash, string is invalid
        CMP     #$30            ; Check if character is a valid digit
        BCC     INVALID_IP      ; If character is not a digit, string is invalid

CHECK_OCTET_END:
        INX                     ; Increment index for next character
        CMP     #$00            ; Increment counter for octet checking
        BNE     CHECK_OCTET_LOOP

VALID_IP:
        RTS                     ; The string is a valid IPv4 address

INVALID_IP:
        RTS                     ; The string is not a valid IPv4 address

READ_NEXT_CHAR:
        LDA     INBUF,X         ; Load the next character from the input buffer
        STA     CURR_CHAR
        RTS

        .rs 256                 ; Reserve space for input buffer

CURR_CHAR   .byte   $00      ; Current character in the string
