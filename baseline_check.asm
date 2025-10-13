
STARTING_ADDRESS = $8000

         ORG STARTING_ADDRESS

         LDX #0        ; initialize counter
INPUT:
         LDA $1000,X   ; get the input number from memory
         BEQ END       ; exit loop if input is 0
         JSR IS_PERFECT_SQUARE    ; check if the number is a perfect square
         BCC NOT_PERFECT          ; jump to NOT_PERFECT if not a perfect square
         INX            ; increment counter if perfect square
NOT_PERFECT:
         INX            ; increment counter
         INX            ; increment counter
         INX            ; increment counter
         INX            ; increment counter
         INX            ; increment counter
         BNE INPUT      ; loop back to get next number
END:
         BRK            ; exit program

IS_PERFECT_SQUARE:
         CLC            ; clear carry flag
         LDA #$01       ; initialize A register to 1
         STA $2000      ; store A at memory location
LOOP:
         CMP $2000      ; compare input number with current value
         BEQ PERFECT    ; branch if they are equal
         ADC $2000      ; add current value to A
         STA $2000      ; store sum at memory location
         INC $2000      ; increment current value
         BNE LOOP       ; loop back
PERFECT:
         CMP $1000     ; compare sum with input number
         RTS           ; return

         .END
