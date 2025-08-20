
    .org $0200

start
    lda #<$0200 ; Load the low byte of the start address
    sta $0314 ; Set the stack pointer
    lda #>$0200 ; Load the high byte of the start address
    sta $0315

    ; Print welcome message
    ldx #0 ; Initialize index register
    ldy #msg_length ; Load message length
print_loop
    lda msg,x ; Load character from message
    jsr $ffd2 ; Print character to screen
    inx ; Increment index
    dey ; Decrement message length
    bne print_loop ; Repeat until message length is 0

    ; Prompt user for name
    jsr prompt_name

    ; Prompt user for age
    jsr prompt_age

    ; Prompt user for desired position
    jsr prompt_position

    ; Display thank you message
    jsr print_newline
    jsr print_thank_you

    ; End program
    jmp $ffcf ; End of program

prompt_name
    jsr print_newline
    lda #<name_prompt ; Load address of prompt for name
    ldy #0 ; Initialize index register
    jsr print_string
    lda #>name_prompt
    jsr print_string

input_name
    ; Read user input
    lda #$00
    jsr $ffd2 ; Read character from keyboard
    cmp #$0d ; Check if input is enter key
    beq name_entered
    tax
    jsr $ffd2 ; Print character to screen
    jmp input_name

name_entered
    rts

prompt_age
    jsr print_newline
    lda #<age_prompt ; Load address of prompt for age
    ldy #0 ; Initialize index register
    jsr print_string
    lda #>age_prompt
    jsr print_string

input_age
    ; Read user input
    lda #$00
    jsr $ffd2 ; Read character from keyboard
    cmp #$0d ; Check if input is enter key
    beq age_entered
    tax
    jsr $ffd2 ; Print character to screen
    jmp input_age

age_entered
    rts

prompt_position
    jsr print_newline
    lda #<position_prompt ; Load address of prompt for desired position
    ldy #0 ; Initialize index register
    jsr print_string
    lda #>position_prompt
    jsr print_string

input_position
    ; Read user input
    lda #$00
    jsr $ffd2 ; Read character from keyboard
    cmp #$0d ; Check if input is enter key
    beq position_entered
    tax
    jsr $ffd2 ; Print character to screen
    jmp input_position

position_entered
    rts

print_newline
    lda #<newline ; Load address of newline character
    ldy #0 ; Initialize index register
    jsr print_string
    lda #>newline
    jsr print_string
    rts

print_thank_you
    lda #<thank_you_msg ; Load address of thank you message
    ldy #0 ; Initialize index register
    jsr print_string
    lda #>thank_you_msg
    jsr print_string
    rts

print_string
    sta $c000,y
    iny
    rts

msg_length = *-msg
msg
    .text "Welcome to the job application system!"

name_prompt
    .text "Please enter your name: "
   
age_prompt
    .text "Please enter your age: "
   
position_prompt
    .text "Please enter your desired position: "
   
newline
    .byte $0d

thank_you_msg
    .text "Thank you for your application!"

