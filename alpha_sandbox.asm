
       ORG $0200
       
start  LDX #0         ; Initialize index X to 0
       LDY #0         ; Initialize sum Y to 0
       LDA #0         ; Initialize count A to 0
       
loop   LDA list,X     ; Load element from list into A
       BEQ end        ; Check if end of list
       
       CLC            ; Clear carry flag
       ADC Y          ; Add element to sum
       STA Y          ; Store sum back in Y
       
       INX            ; Increment index
       SEC            ; Set carry flag
       ADC #1         ; Increment count
       STA A          ; Store count back in A
       
       JMP loop       ; Repeat for next element
       
end    CPY #0         ; Check if count is zero
       BEQ done       ; If so, exit
       
       TYA            ; Transfer sum to A
       TAX            ; Transfer count to X
       CLC            ; Clear carry flag
       DIV X          ; Divide sum by count
       
done   BRK            ; Exit program
       
list   .byte 10, 20, 30, 40, 50, 0
