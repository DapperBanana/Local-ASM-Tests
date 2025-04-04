
START    LDX #$05      ; Set loop counter to 5 characters
         LDY #$00      ; Initialize Y to 0

LOOP     JSR RANDOM   ; Call random number generator
         AND #$1F      ; Mask out upper bits to get value between 0-31
         CMP #$0A      ; If value < 10, add 48 ('0' ASCII value)
         BCC NUMERIC
         ADC #$37      ; Otherwise, add 55 ('A' ASCII value)

NUMERIC  STA ($30),Y  ; Store value at $30 (memory location for password)
         INY          ; Increment Y
         DEX
         BNE LOOP     ; Repeat until 5 characters generated

DONE     BRK           ; Exit program

RANDOM    LDA $D012     ; Read CIA timer value register
          LSR            ; Shift right twice (divides by 4)
          LSR
          LDA $D012     ; Read CIA timer value register again
          AND #$0F      ; Mask out upper bits to get value between 0-15
          RTS 

         .ORG $30       ; Start of memory allocation for password
