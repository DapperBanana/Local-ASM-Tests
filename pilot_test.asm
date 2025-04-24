
    .org $0200
    
start
    lda #$00          ; Initialize index for the string
    sta index
    
loop:
    lda string, x     ; Load character from string
    beq done          ; If end of string, exit
    cmp #$00          ; Check for null terminator
    beq done
    
    cmp #65           ; Check if character is a capital letter
    bcc not_valid     ; If not, jump to not_valid
    cmp #122          ; Check if character is a lowercase letter
    bcs check_digit   ; If not, check for digits
    
valid_char:
    inx               ; Increment index
    jmp loop          ; Continue checking
    
check_digit:
    cmp #47           ; Check if character is a digit
    bcc not_valid     ; If not, jump to not_valid
    cmp #58           ; Check if character is a digit
    bcs valid_char    ; If so, continue checking
    
not_valid:
    lda invalid_msg   ; Load message for invalid URL
    jsr print_string  ; Print the message
    lda #$01          ; Set return value as invalid
    jmp end           ; Exit program
    
done:
    lda valid_msg     ; Load message for valid URL
    jsr print_string  ; Print the message
    lda #$00          ; Set return value as valid
    
end:
    rts               ; Return from subroutine
    
string:
    .text "https://www.example.com" ; String to check
    
valid_msg:
    .text "Valid URL\n"
    
invalid_msg:
    .text "Invalid URL\n"
    
print_string:
    ldx #$00          ; Initialize position in string
loop_print:
    lda string, x     ; Load character from string
    beq end_print     ; If end of string, exit
    jsr $ffd2         ; Print character to screen
    inx               ; Increment index
    jmp loop_print    ; Continue printing
    
end_print:
    rts               ; Return from subroutine
