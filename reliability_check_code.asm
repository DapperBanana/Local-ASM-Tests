
RESET     .org $FFFC
          .word START

IRQ       .org $FFFE
          .word START

START     SEI           ; Disable interrupts
          CLD           ; Clear decimal mode

          LDX #$00      ; Initialize index register X
          LDY #$00      ; Initialize index register Y

MAIN_LOOP LDA menuText, Y    ; Load menu text
          CMP #$00           ; Check if end of text
          BEQ END            ; Branch to end if end of text
          JSR PRINT_STRING   ; Subroutine to print text
          INY                ; Increment Y
          JMP MAIN_LOOP      ; Continue looping

END       BRK           ; Break and end program

PRINT_STRING
          ; code to print a null-terminated string
          RTS           ; Return from subroutine

menuText  .text "Welcome to Fantasy Sports Manager\n"
          .text "1. View rosters\n"
          .text "2. Make trades\n"
          .text "3. Reset lineup\n"
          .text "4. Exit\n"
          .byte $00
