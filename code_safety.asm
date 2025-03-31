
PC_START    = $0200
BUF_SIZE    = $80

          .ORG    PC_START
start     LDA     #$00            ; Initialize word count to 0
          STA     word_count

next_char LDA     $C000,X         ; Load next character from file
          BEQ     end_of_file     ; If character is null, end of file reached
          CMP     #$20            ; Compare character to space
          BEQ     check_space     ; If character is space, check for word separation
          INX                     ; Move to next character
          BNE     next_char       ; Carry over to next page

check_space
          INX                     ; Move to next character
          LDA     $C000,X         ; Load next character
          CMP     #$20            ; Compare character to space
          BEQ     next_char       ; If character is space, continue to next character
          INC     word_count      ; Increment word count
          INX
          BNE     next_char       ; Carry over to next page

end_of_file
          INX                     ; Move to next character
          LDA     word_count
          STA     $C100           ; Store word count in $C100

          BRK

          .ORG    $FFFC
          .WORD   PC_START
