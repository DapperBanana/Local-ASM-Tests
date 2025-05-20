
            .org $1000        ; Starting address of the program

            LDA #0           ; Load 0 into accumulator
            STA IsLeapYear   ; Initialize IsLeapYear to 0
            
            LDA year         ; Load the input year into the accumulator
            JSR CheckLeapYear ; Call the function to check if it's a leap year
            
            BEQ NotLeapYear   ; Branch if not a leap year

IsLeapYear  DEC              ; Decrement IsLeapYear to indicate it's a leap year

NotLeapYear BRK              ; Break
            
CheckLeapYear
            CMP #0           ; Compare with 0
            BMI Done         ; Branch if less than 0
            
            LDA year         ; Load the input year into the accumulator
            AND #$03         ; Bitwise AND with 3
            CMP #0           ; Compare with 0
            BNE Done         ; Branch if not equal to 0

            LDA year         ; Load the input year into the accumulator
            AND #$07         ; Bitwise AND with 7
            CMP #0           ; Compare with 0
            BNE Done         ; Branch if not equal to 0

            LDA year         ; Load the input year into the accumulator
            AND #$0F         ; Bitwise AND with 15
            CMP #0           ; Compare with 0
            BNE Done         ; Branch if not equal to 0

            LDA year         ; Load the input year into the accumulator
            AND #$03         ; Bitwise AND with 3
            CMP #1           ; Compare with 1
            BNE Done         ; Branch if not equal to 1

            LDA year         ; Load the input year into the accumulator
            AND #$0F         ; Bitwise AND with 15
            CMP #0           ; Compare with 0
            BNE Done         ; Branch if not equal to 0

            JMP Done         ; Jump to Done

Done        RTS              ; Return from subroutine

            .equ year $2022   ; Input year to check

            .org $FFFC        ; Reset Vector
            .word $1000       ; Start address of program
