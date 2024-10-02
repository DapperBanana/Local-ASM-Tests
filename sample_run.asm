
    Processor 6502

    .org $0200

    LDA #$14      ; Load the initial number into the accumulator
    STA number

loop:
    LDX #0        ; Initialize X register to 0 for index
    LDA number    ; Load the number into the accumulator
    STA sum       ; Store the number in sum

calculate_sum:
    LSR           ; Divide the number by 10
    BCC sum_done  ; If no carry, proceed to sum_done
    INX           ; Increment the index
    JMP calculate_sum

sum_done:
    CLC
    ASL sum       ; Multiply sum by 2
    ADC sum       ; Add the original sum to the result of the multiplication
    BCC done      ; If no carry, proceed to done
    TXA           ; Otherwise, transfer the index to accumulator
    STA number    ; Store the index in number
    JMP loop      ; Restart the loop

done:
    NOP           ; Do nothing, end the program

number: .byte 0
sum:    .byte 0

    .end
