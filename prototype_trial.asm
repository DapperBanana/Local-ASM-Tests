
RESET     = $0200
CRSINH    = $f600

          ORG RESET
          .word START
          .word START

START     LDX #$00        ; set X register to 0 (word count)
          LDY #$00        ; set Y register to 0 (ASCII character)

LOOP      LDA $C000,Y    ; load character from input text file
          BEQ END        ; skip to end if end of file
          CMP #$20       ; compare with space character
          BNE NOT_SPACE  ; branch if not space
          INX             ; increment word count
          INY             ; increment character count
          BRA SKIP        ; skip ahead

NOT_SPACE INY             ; increment character count

SKIP      INY             ; increment index to next character
          BRA LOOP        ; go back to beginning of loop

END       LDA #$0D       ; load carriage return character
          JSR CRSINH     ; jump to subroutine to print word count
          JMP END        ; infinite loop to halt program

          .end
