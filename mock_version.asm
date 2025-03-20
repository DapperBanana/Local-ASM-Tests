
; Program to check if a given string is a valid JSON
; Input: String in memory starting at $1000
; Output: Success message if valid JSON, Error message if invalid JSON

        .org $1000

; Declare variables
buffer  .ds 100    ; Input string buffer
isValid .byte 0    ; Flag to track if JSON is valid

start
        ldx #0          ; Initialize index
        lda buffer,x    ; Load first character
        cmp #'{'
        beq checkEnd    ; Check if JSON starts with { character
        lda #'E'
        jsr printChar    ; Print Error message
        lda #'r'
        jsr printChar
        lda #'r'
        jsr printChar
        jmp end

checkEnd
        lda #0          ; Initialize flag
        inx             ; Increment index
checkChar
        lda buffer,x     ; Load next character
        beq isValidJSON ; If end of string, JSON is valid
        cmp #'}'
        beq checkEnd     ; If end of JSON object, continue checking
        cmp #' '         ; Ignore whitespace
        beq skipChar
        cmp #':'         ; Check for key-value separator
        bne checkChar    ; If not, continue checking
        inc isValid      ; Increment flag
skipChar
        inx
        jmp checkChar

isValidJSON
        lda isValid
        beq printError   ; If flag is 0, JSON is invalid
        lda #'S'
        jsr printChar    ; Print Success message
        lda #'u'
        jsr printChar
        lda #'c'
        jsr printChar
        lda #'c'
        jsr printChar
        lda #'e'
        jsr printChar

printError
        lda #'E'
        jsr printChar    ; Print Error message
        lda #'r'
        jsr printChar
        lda #'r'
        jsr printChar

end
        rts

printChar
        jsr $ffd2       ; Call Kernal routine to print character
        rts
