
START     LDX #0         ; Initialize index to 0
          LDA nums,X     ; Load the first number into accumulator
          STA max        ; Initialize max to first number

LOOP      INX            ; Increment index
          CPX #10        ; Check if all numbers have been processed
          BEQ DONE       ; If all numbers have been processed, exit loop

          LDA nums,X     ; Load next number into accumulator
          CMP max        ; Compare with current max
          BCC SKIP       ; If number is less than max, skip next steps
          STA max        ; Update max with new number

SKIP      JMP LOOP       ; Continue loop

DONE      BRK            ; End of program

nums      .byte 5, 8, 10, 7, 3, 15, 12, 6, 9, 11   ; List of 10 numbers
max       .byte 0         ; Variable to store max value
