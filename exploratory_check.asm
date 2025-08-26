
start:
    ; Initialize variables
    LDA #0          ; Initialize accumulator to 0
    STA sum         ; Store accumulator value in sum variable
    LDA number      ; Load number to be calculated into the accumulator
    
loop:
    CMP #0          ; Check if the number is 0
    BEQ done        ; If number is 0, exit loop
    LSR             ; Right shift to isolate the last digit
    STA digit       ; Store the last digit in digit variable
    CLC
    ADC digit       ; Add last digit to sum
    STA sum         ; Store the updated sum
    JMP loop        ; Continue loop
    
done:
    CMP #9          ; Check if sum is a single-digit number
    BCC end         ; If sum is less than 10, go to end
    
    ; If sum is not a single-digit number, repeat the process with the new sum
    LDA sum
    STA number      ; Update number with the sum
    JMP start       ; Restart the process
    
end:
    BRK             ; End program

sum: .BYTE 0
digit: .BYTE 0
number: .BYTE 123  ; Input number to be calculated

    .ORG $FFFC
    .WORD start     ; Set program entry point
