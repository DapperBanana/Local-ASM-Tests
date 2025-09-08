
LDA #30        ; Load the value of 30 (Celsius temperature) into the accumulator
STA temp_c     ; Store the Celsius temperature in the variable temp_c

LDA temp_c     ; Load the Celsius temperature from the variable temp_c into the accumulator
CLC            ; Clear the carry flag
ADC #32        ; Add 32 to the Celsius temperature
STA temp_f     ; Store the Fahrenheit temperature in the variable temp_f

LDA temp_f     ; Load the Fahrenheit temperature from the variable temp_f into the accumulator
BRK            ; Break - stop the program

temp_c .BYTE 0  ; Variable to store the Celsius temperature
temp_f .BYTE 0  ; Variable to store the Fahrenheit temperature
