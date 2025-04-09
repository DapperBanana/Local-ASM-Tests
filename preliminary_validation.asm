
.org $0200

START:
    LDX #$00        ; Initialize X register to 0 (word count)
    LDA #<TEXT_FILE ; Load low byte of text file address
    STA $02         ; Store low byte to $02
    LDA #>TEXT_FILE ; Load high byte of text file address
    STA $03         ; Store high byte to $03

READ_LOOP:
    LDA ($02),Y     ; Load character from text file
    CMP #$20        ; Compare character to space (' ')
    BEQ IS_WORD     ; Branch if space charater found
    CMP #$0D        ; Compare character to carriage return
    BEQ END_READ    ; Branch if end of file
    CMP #$00        ; Compare character to null terminator
    BEQ END_READ    ; Branch if end of file
    INY             ; Increment Y register to move to next character
    JMP READ_LOOP   ; Jump back to READ_LOOP

IS_WORD:
    INX             ; Increment X register (word count)
    INY             ; Increment Y register to move to next character
    JMP READ_LOOP   ; Jump back to READ_LOOP

END_READ:
    STX $00         ; Store word count in $00
    BRK             ; Break and end program

TEXT_FILE:
    .incbin "text_file.txt"

.end
