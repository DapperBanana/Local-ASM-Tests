
ORG $1000

* Constants
radius    EQU $A0
height    EQU $A1
volume    EQU $A2

* Load radius from user input
          LDX #radius
          JSR GET_NUM

* Load height from user input
          LDX #height
          JSR GET_NUM

* Calculate volume
          LDA radius
          STA $F0    ; Store radius in zero page for future use
          LDA height
          STA $F1    ; Store height in zero page for future use
          LDA radius
          JSR MULT        ; r * r
          LDA height
          JSR MULT        ; r * r * h
          LDA $F0
          JSR MULT        ; r * r * h * PI
          LDA #$05
          JSR DIV         ; r * r * h * PI / 3
          STA volume

* Display the volume
          LDX #volume
          JSR PUT_NUM

DONE: RTS

MULT      STA $F2    ; Store the first multiplier
          LDA $F3    ; Load the second multiplier
          CLC
          ADC $F2    ; Add the first multiplier
          STA $F3    ; Store the result
          RTS

DIV       LDA $F3    ; Load the dividend
          SEC
          SBC $F2    ; Subtract the divisor
          LDX $F2
          STX $F3    ; Store the remainder
          RTS

GET_NUM   LDY #0    ; Clear index
          LDA #$00    ; Clear number
GET_NUM_LOOP JSR INKEY
          CPX #$0D    ; Check for enter
          BEQ GET_NUM_DONE    ; If enter, break
          CMP #$30
          BCC GET_NUM_LOOP    ; Skip if not a number
          CMP #$3A
          BCS GET_NUM_LOOP    ; Skip if not a number
          SEC
          SBC #$30
          TAX
          LDA #$0A
          JSR MULT
          LDA #0
          JSR MULT
          CLC
          LDA TAX
          ADC #0
          STA TAX
          JMP GET_NUM_LOOP

GET_NUM_DONE LSR        ; Divide number by 10
          BCC GET_NUM_DONE2
          LDA #0
          CLC
          JSR MULT
          LDA #0
          JSR MULT
          LDA TAX
          SEC
          SBC #1
          STA TAX
GET_NUM_DONE2
          STX (X)    ; Store the number in memory
          RTS

PUT_NUM   LDA (X)    ; Load the number from memory
          PHA        ; Push it on the stack
          LDA #$2C
          JSR CHROUT    ; Print a comma
          PLA        ; Pull the number back
          AND #$0F
PUT_NUM_LOOP
          BEQ PUT_NUM_DONE
          ORA #$30
          JSR CHROUT
          LDA #$0A
          JSR MULT
          JSR PUT_NUM_LOOP
PUT_NUM_DONE
          RTS

CHROUT   STA $FF     ; Store character in output register
          RTS

INKEY    LDA $FF     ; Load character from input register
          RTS

* Input Buffer
INPUT    DS $0F        ; Input buffer

* Variables
VAR      DS $0F

          .END
