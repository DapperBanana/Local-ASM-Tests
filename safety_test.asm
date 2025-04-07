
          .org $2000

checkISBN:
          LDA #$00              ; initialize accumulator
          LDY #$00              ; initialize index
loop:     LDA ($2000),Y        ; load character from string
          BEQ end              ; if end of string, exit loop
          CMP #$30              ; compare character to '0'
          BCC invalid          ; if less than '0', invalid ISBN
          CMP #$39              ; compare character to '9'
          BCS invalid          ; if greater than '9', invalid ISBN
          INY                   ; increment index
          BNE loop              ; continue loop

end:      LDA #$01              ; set accumulator to 1 (valid ISBN)
          RTS                   ; return from function

invalid:  LDA #$00              ; set accumulator to 0 (invalid ISBN)
          RTS                   ; return from function

          .end
