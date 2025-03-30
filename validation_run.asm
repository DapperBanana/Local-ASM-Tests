
        .org $0200   ; Start the program at memory address $0200

start:
        LDA #10     ; Load the number to be checked into the accumulator
        AND #$01    ; Perform a bitwise AND operation with 1 to check the least significant bit
        BEQ even    ; Branch to even if the result is 0 (number is even)
        JMP odd     ; Jump to odd if the result is not 0 (number is odd)

even:
        LDA #$00    ; Load 0 into the accumulator to represent an even number
        STA $0200   ; Store the result at memory address $0200
        BRK         ; Exit the program

odd:
        LDA #$01    ; Load 1 into the accumulator to represent an odd number
        STA $0200   ; Store the result at memory address $0200
        BRK         ; Exit the program
