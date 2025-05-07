
; Job Application System

RESET    = $0200

        .org RESET

START    lda #0            ; Initialize variables
         sta status
         sta answer

         lda #<welcome_msg ; Print welcome message
         ldy #>welcome_msg
         jsr print_message

ask_name lda #<enter_name_msg ; Ask for applicant's name
         ldy #>enter_name_msg
         jsr print_message
         jsr get_input

         lda #$8d            ; Print newline
         jsr print_char

         lda #<confirm_name_msg ; Ask for confirmation of name
         ldy #>confirm_name_msg
         jsr print_message
         jsr get_input

         cmp #'y            ; Check if user confirmed name
         beq name_confirmed
         bne ask_name

name_confirmed lda #<thank_you_msg  ; Thank applicant for applying
               ldy #>thank_you_msg
               jsr print_message

               lda #<good_luck_msg  ; Wish applicant good luck
               ldy #>good_luck_msg
               jsr print_message

end      lda #0            ; End program
         rts

print_message
         ldx #0            ; Print message character by character
print_loop
         lda (x),y
         beq print_done
         jsr print_char
         inx
         bne print_loop

print_done rts

print_char
         sta $0400            ; Print character to screen
         rts

get_input
         lda #0            ; Get user input
         jsr $ffe4
         sta answer
         rts

welcome_msg    .asciiz "Welcome to the Job Application System" ; Messages
enter_name_msg .asciiz "Please enter your name: "
confirm_name_msg .asciiz "Is this your correct name? (y/n): "
thank_you_msg  .asciiz "Thank you for applying!"
good_luck_msg  .asciiz "Good luck with your application!"

status    .byte 0     ; Variables
answer    .byte 0

        .org $fffa    ; Interrupt vectors
        .word START, START, START, START, START, START, START
