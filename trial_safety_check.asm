
        .org $0600

start   sei                 ; Disable interrupts
        cld                 ; Clear decimal mode
        lda #$7F            ; Clear screen
        jsr $FFD2

        lda #$00            ; Set text position to top-left
        sta $9D
        sta $9E

        lda #<prompt        ; Print prompt to enter name
        ldy #>prompt
        jsr $FFD2

getName lda #$00            ; Read input from user
        jsr $FFCC
        bne getName

        lda $A          ; Load first character of user input
        cmp #" "        ; Check if input is blank
        beq getName     ; Ask for name again

printGreeting
        jsr clearScreen    ; Clear screen
        lda #<greeting     ; Print personalized greeting
        ldy #>greeting
        jsr $FFD2

        lda $A          ; Load first character of user input
        cmp #" "        ; Check if input is blank
        beq getName     ; Ask for name again

        lda $9D         ; Return cursor to top-left
        sta $9A
        lda $9E
        sta $9B

        lda #<nameInput    ; Print user input/name
        ldy #>nameInput
        jsr $FFD2

        lda #$FF            ; Infinite loop
loop    jmp loop

prompt  .text "Enter your name: $00"
nameInput .text "$00$00"
greeting .text "Hello, "
