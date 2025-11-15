
; Constants
BUFFER_SIZE = 64
NUM_QUESTIONS = 5

; Data section
.buffer ds BUFFER_SIZE
.questions ds NUM_QUESTIONS
.answer ds 1

; Entry point
org $0200

start:
    lda #'H'  ; Print welcome message
    jsr $ffd2  ; Output character
    lda #'e'
    jsr $ffd2
    lda #'l'
    jsr $ffd2
    lda #'l'
    jsr $ffd2
    lda #'o'
    jsr $ffd2
    lda #' '
    jsr $ffd2
    lda #'A'
    jsr $ffd2
    lda #'p'
    jsr $ffd2
    lda #'p'
    jsr $ffd2
    lda #'l'
    jsr $ffd2
    lda #'i'
    jsr $ffd2
    lda #'c'
    jsr $ffd2
    lda #'a'
    jsr $ffd2
    lda #'t'
    jsr $ffd2
    lda #'i'
    jsr $ffd2
    lda #'o'
    jsr $ffd2
    lda #'n'
    jsr $ffd2
    lda #':'
    jsr $ffd2 ; Output character
    lda #13 ; carriage return
    jsr $ffd2
    lda #10 ; linefeed
    jsr $ffd2

    jsr get_question ; Get first question
    jsr get_response ; Get user input
    jsr store_response ; Store user input

    jsr get_question ; Get second question
    jsr get_response ; Get user input
    jsr store_response ; Store user input

    ; Repeat for remaining questions...

    lda #'T'
    jsr $ffd2
    lda #'h'
    jsr $ffd2
    lda #'a'
    jsr $ffd2
    lda #'n'
    jsr $ffd2
    lda #'k'
    jsr $ffd2
    lda #' '
    jsr $ffd2
    lda #'y'
    jsr $ffd2
    lda #'o'
    jsr $ffd2
    lda #'u'
    jsr $ffd2
    lda #'!'
    jsr $ffd2

end:
    rts

; Get a question from the questions array
get_question:
    lda questions,x
    jsr print_string
    inx
    cpx #NUM_QUESTIONS
    bne get_question
    rts

; Get user input
get_response:
    ldx #0
    lda #'>' ; Prompt user for input
    jsr $ffd2
    lda #32 ; space
    jsr $ffd2

read_loop:
    lda $00 ; Read character from input
    jsr $ffd1
    sta .buffer,x
    inc x
    cmp #13 ; Check if Enter key was pressed
    bne read_loop
    rts

; Store user input
store_response:
    ldx #0
store_loop:
    lda .buffer,x
    sta answer
    inx
    cpx #BUFFER_SIZE
    bne store_loop
    rts

; Print a null-terminated string
print_string:
    lda #$00
    ldy #0
print_loop:
    lda (answer),y
    beq print_end
    jsr $ffd2
    iny
    bne print_loop
print_end:
    rts

; Questions
.questions:
    .byte "What is your name?",0
    .byte "What is your desired job role?",0
    .byte "What relevant experience do you have?",0
    .byte "Why do you want to work for us?",0
    .byte "What are your salary expectations?",0

; End of program
end:
    rts

; Padding
.pad:
    .byte 0 ; Padding for aligning to even address
