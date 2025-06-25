
; 6502 Assembly Program for Personality Quiz

        .org $0200

RESET   lda #0            ; Initialize accumulator
        sta $400          ; Clear screen
        ldx #0            ; Initialize X register
        ldy #0            ; Initialize Y register

QUIZ_LOOP 
        lda QUESTION,X    ; Load question
        jsr PRINT         ; Print question
        lda #0            ; Initialize accumulator
        jsr INPUT         ; Get user input

        cmp #65           ; Compare input to 'A'
        beq OPTION_A      ; If input is 'A', branch to OPTION_A
        cmp #66           ; Compare input to 'B'
        beq OPTION_B      ; If input is 'B', branch to OPTION_B
        jmp QUIZ_LOOP     ; Otherwise, repeat the quiz

OPTION_A
        lda OPTION_A_MSG  ; Load option A message
        jsr PRINT         ; Print option A message
        jmp END           ; End the quiz

OPTION_B
        lda OPTION_B_MSG  ; Load option B message
        jsr PRINT         ; Print option B message
        jmp END           ; End the quiz

PRINT
        ldy #0            ; Reset Y register
PRINT_LOOP
        lda QUESTION_TEXT,Y  ; Load character
        beq PRINT_END     ; If null byte, end
        jsr $fdd2         ; Print character
        iny               ; Increment Y
        jmp PRINT_LOOP    ; Loop

PRINT_END
        rts               ; Return

INPUT
        jsr $ffd2         ; Get user input
        rts

END
        rts               ; End program

QUESTION
        .byte "Which color do you prefer? (A) Blue (B) Red", 0

OPTION_A_MSG
        .byte "You are calm and logical.", 0

OPTION_B_MSG
        .byte "You are passionate and energetic.", 0

QUESTION_TEXT
        .byte "Which color do you prefer? (A) Blue (B) Red", 0

        .end
