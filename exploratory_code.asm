
    ; Input: put the decimal number in the accumulator (A)
    ; Output: fraction in the format numerator/denominator, stored in memory at $0400 and $0401

    LDA #0             ; Clear accumulator
    STA $0400          ; Store numerator in memory
    LDA #1             ; Set denominator to 1
    STA $0401          ; Store denominator in memory

loop:
    CMP #0             ; Compare A with 0
    BEQ done           ; If A is 0, we are done

    ADC $0401         ; Add denominator to accumulator
    STA $0401         ; Store the result as the new denominator

    LDA $0400         ; Load numerator
    ASL               ; Multiply numerator by 2
    STA $0400         ; Store the result as the new numerator

    JMP loop          ; Repeat the process

done:
    RTS               ; Return from subroutine
