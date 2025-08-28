
; Example 6502 Assembly program to check if a given string is a valid email address

; Assume the input string is stored starting at $4000 in memory
; The length of the string is stored at $FFFE (LSB) and $FFFF (MSB)

start:
    ldx #0               ; Initialize index
    lda $FFFE            ; Load LSB of string length
    beq end              ; If length is 0, exit

check_email:
    lda $4000, X         ; Load character at current index
    cmp #'@'             ; Check if current character is '@'
    beq found_at         ; If '@' is found, check rest of email
    cmp #'.'             ; Check if current character is '.'
    beq not_valid        ; If '.' is found before '@', not valid email
    inx                  ; Increment index
    cpx $FFFE            ; Check if reached end of string
    bne check_email      ; If not end, continue checking
    bra is_valid         ; If end reached without '@' and '.', valid email

found_at:
    inx                  ; Move past '@'
    ldy #$02             ; Initialize counter for minimum 2 characters after '@'

check_domain:
    lda $4000, X         ; Load character at current index
    cmp #'.'             ; Check if current character is '.'
    beq end              ; If '.' is found, it is end of email address
    inx                  ; Increment index
    dey                  ; Decrement counter for minimum 2 characters after '@'
    bne check_domain     ; If counter not zero, continue checking
    bra is_valid         ; If minimum 2 characters after '@' are present, valid email

not_valid:
    lda #0               ; Set A register to 0 to indicate not valid email
    jmp end

is_valid:
    lda #1               ; Set A register to 1 to indicate valid email

end:
    rts                  ; Return from subroutine
