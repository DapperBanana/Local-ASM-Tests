
; LCM of two numbers in 6502 Assembly

          ORG   $1000
start     LDX   #0         ; Initialize X register
          LDY   #0         ; Initialize Y register

          ; Input first number into accumulator
input_num1 LDA   #first_number
          STA   num1

          ; Input second number into accumulator
input_num2 LDA   #second_number
          STA   num2

          ; Initialize counter to 1
          LDA   #1
          STA   counter

loop      ; Check if counter is less than or equal to num1 or num2
          LDA   counter    ; Load counter into accumulator
          CMP   num1       ; Compare with num1
          BCC   next_num1  ; Branch if less than num1
          CMP   num2       ; Compare with num2
          BCC   next_num2  ; Branch if less than num2

          ; Find LCM by multiplying num1 and num2 by the counter
          LDA   num1
          CLC
          ADC   num1
          STA   num1
          LDA   num2
          CLC
          ADC   num2
          STA   num2

next_num1 ; Increment counter
          INC   counter
          JMP   loop

next_num2 ; Increment counter
          INC   counter
          JMP   loop

num1      .BYTE  0
num2      .BYTE  0
counter   .BYTE  0

first_number  .BYTE  5      ; Input the first number here
second_number .BYTE  7      ; Input the second number here

          END   start
