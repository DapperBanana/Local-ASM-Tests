
; Prime factors of a number in memory location 0x00
START LDX #2            ; Start with divisor 2
LOOP LDY #0            ; Initialize counter for prime factors
DIV   CPY #0            ; Check if number is divisible
      BEQ PRIME        ; If divisible, go to PRIME
      INY                ; Increment counter
      CLC
      LDA $00            ; Load number from memory
      CMP #$03            ; Check if number is equal to 3
      BCS NOT_3
      SEC
      JSR DIVIDE_3
      BCS DONE
      NOP
      NOP
DIVIDE_3 LSR                ; Divide by 3
          BCC DIVIDE_3
          ROL
          SBC #$01
          RTS

NOT_3 CLC
          CMP #$05            ; Check if number is equal to 5
          BCS NOT_5
          SEC
          JSR DIVIDE_5
          BCS DONE
          NOP
          NOP
DIVIDE_5 LDA $00            ; Load number from memory
          LSR                ; Divide by 5
          BCC DIVIDE_5
          ROL
          SBC #$02
          RTS

NOT_5 CMP #$02            ; Check if number is equal to 2
          BNE CONTINUE
          NOP
          NOP
          CLC
          RTS

CONTINUE            ; Continue dividing by divisor
          LDA $00
          LDX #2
          CLC
          DIVX
          BCS LOOP        ; If remainder is zero, continue with the same divisor
          INX                ; Otherwise, increment the divisor
          CPX $00            ; Check if divisor is greater than the number
          BCC LOOP        ; If not, continue dividing
          RTS

PRIME INX                ; Increment the counter
        STX $01            ; Store prime factor in memory location 0x01
        LDX $00            ; Load the number from memory
        SEC
        DIVX
        STX $00            ; Store the quotient back in memory
        CPX #$02            ; Check if divisor is greater than 2
        BCS LOOP        ; If not, exit the loop
        RTS

DONE                    ; Finished finding prime factors
        BRK                ; Break

