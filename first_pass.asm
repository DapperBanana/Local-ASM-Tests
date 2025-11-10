
; 6502 Assembly program to check if a given string is a valid IPv4 address

; Input:
; - Memory location BUFFER points to the string to check
; - Memory location RESULT will contain the result,
;   0 if the string is not a valid IPv4 address
;   1 if the string is a valid IPv4 address

BUFFER      .equ    $00      ; Memory location to store input string
RESULT      .equ    $01      ; Memory location to store result

            .org    $1000    ; Start address of the program

start       ldx     #$00     ; Initialize index to 0
            lda     #$01     ; Assume result is valid
            sta     RESULT   ; Store the result

check_loop  lda     BUFFER,X ; Load character from the string
            beq     end      ; If end of string, exit loop
            cmp     #'0'     ; Check if character is a digit
            bcc     not_valid ; If not a digit, mark string as invalid
            cmp     #'9'
            bcs     not_valid
            inc     X         ; Move to next character in the string
            bra     check_loop

not_valid   lda     #$00     ; String is not a valid IPv4 address
            sta     RESULT
            rts

end         rts

            .end
