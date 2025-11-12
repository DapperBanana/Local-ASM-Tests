
        .org $2000

; Constants
START = $2000
CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

; Variables
msgAddr .res 1
key     .res 1
choice  .res 1
char    .res 1
encrypted .res 1

;  Program starts here
start:  lda #0                ; clear A register
        sta msgAddr           ; clear msgAddr variable
        sta key               ; clear key variable
        sta choice            ; clear choice variable

input:  lda #"Enter E for Encrypt, D for Decrypt: "
        jsr output
        lda #" "
        jsr input

        cmp #"E"              ; check if input is 'E' for encryption
        beq encrypt
        cmp #"D"              ; check if input is 'D' for decryption
        beq decrypt

invalidInput:
        lda #"Invalid input. Please try again."
        jsr output
        bra input

encrypt: lda #1
        sta choice            ; set choice to 1 for encryption
        lda #"Enter message to encrypt: "
        jsr output
        jsr inputMessage

        lda #"Enter encryption key (1-25): "
        jsr output
        jsr inputKey

        jsr encryptMessage    ; encrypt the message
        lda encrypted         ; load the encrypted message
        jsr output            ; output the encrypted message
        bra done

decrypt: lda #2
        sta choice            ; set choice to 2 for decryption
        lda #"Enter message to decrypt: "
        jsr output
        jsr inputMessage

        lda #"Enter decryption key (1-25): "
        jsr output
        jsr inputKey

        jsr decryptMessage    ; decrypt the message
        lda encrypted         ; load the decrypted message
        jsr output            ; output the decrypted message
        bra done

inputMessage: lda #""
        sta msgAddr           ; clear message address
        ldx #0                 ; initialize index register
inputMessageLoop:
        jsr input             ; input character
        cmp #0                 ; check for null terminator
        beq inputMessageEnd
        sta char              ; store character
        lda char
        sta msgAddr, x         ; store character in message buffer
        inx                   ; increment index
        jmp inputMessageLoop
inputMessageEnd: rts

inputKey: lda #0
        sta key               ; clear key variable
inputKeyLoop:
        jsr input             ; input character
        cmp #0                 ; check for null terminator
        beq inputKeyEnd
        sec
        sbc #"0"              ; subtract ascii value of '0'
        cmp #10                ; check if it's a digit
        bcc notADigit
        bra invalidKey
notADigit:
        asl a                  ; multiply key by 10
        clc
        adc key               ; add new digit
        sta key               ; store key
        jmp inputKeyLoop
inputKeyEnd: rts

encryptMessage: lda msgAddr       ; load message address
        sta char              ; load first character
        ldx #0                 ; initialize index register
encryptLoop: lda char              ; load character
        cmp #"A"              ; check if it's a letter
        bcc notALetter
        cmp #"Z"              ; check if it's a letter
        bcs notALetter
        jsr encryptChar       ; encrypt character
        sta encrypted         ; store encrypted character
        lda msgAddr, x         ; load next character
        sta char              ; store next character
        inx                   ; increment index
        cmp #0                 ; check for null terminator
        bne encryptLoop
        rts

decryptMessage: lda msgAddr       ; load message address
        sta char              ; load first character
        ldx #0                 ; initialize index register
decryptLoop: lda char              ; load character
        cmp #"A"              ; check if it's a letter
        bcc notALetter
        cmp #"Z"              ; check if it's a letter
        bcs notALetter
        jsr decryptChar       ; decrypt character
        sta encrypted         ; store decrypted character
        lda msgAddr, x         ; load next character
        sta char              ; store next character
        inx                   ; increment index
        cmp #0                 ; check for null terminator
        bne decryptLoop
        rts

encryptChar: lda char              ; load character
        sec
        sbc #"A"              ; subtract ascii value of 'A'
        clc
        adc key               ; add encryption key
        cmp #26                ; check if character is past 'Z'
        bcc encryptCharEnd
        sbc #26                ; wrap character around
encryptCharEnd: clc
        adc #"A"              ; add ascii value of 'A' back
        rts

decryptChar: lda char              ; load character
        sec
        sbc #"A"              ; subtract ascii value of 'A'
        clc
        sbc key               ; subtract encryption key
        cmp #0                 ; check if character is before 'A'
        bcs decryptCharEnd
        adc #26                ; wrap character around
decryptCharEnd: clc
        adc #"A"              ; add ascii value of 'A' back
        rts

output: jsr $ffd2            ; output character
        rts

done:   lda #"Do you want to encrypt or decrypt another message? (Y/N): "
        jsr output
        jsr input

        cmp #"Y"              ; check if input is 'Y' to continue
        beq start
        rts

        .end
