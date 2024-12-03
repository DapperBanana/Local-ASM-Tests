
        ORG $0200

start   LDA #12           ; Load first number into accumulator
        STA num1          ; Store it in memory location num1
        LDA #18           ; Load second number into accumulator
        STA num2          ; Store it in memory location num2
        
        JSR find_lcm     ; Call subroutine to find LCM
        
end     BRK

find_lcm
        LDA num1          ; Load first number into accumulator
        STA temp1
        LDA num2          ; Load second number into accumulator
        STA temp2
        
        LDA #1            ; Initialize counter to 1
        STA counter
        
loop    LDA temp1         ; Load temp1 into accumulator
        CMP #$00          ; Compare with 0
        BEQ end_loop1     ; If temp1 is 0, end loop
        
        LDY #0            ; Initialize index register Y to 0
        
loop1   LDX counter       ; Load counter into index register X
        LDA temp1         ; Load temp1
        
        JSR divide        ; Call subroutine to divide temp1 by counter
        
        BNE check_loop1   ; If division was successful, check loop1
        
        INX               ; Increment counter
        
check_loop1
        INY               ; Increment index register Y
        CPY #$02          ; Compare index register Y with constant 2
        BNE loop1         ; If not equal to 2, loop1
        
        JMP update_temp1  ; Jump to update_temp1
        
end_loop1
        LDA #1            ; Initialize counter to 1
        STA counter
        
loop2   LDA temp2         ; Load temp2 into accumulator
        CMP #$00          ; Compare with 0
        BEQ end_loop2     ; If temp2 is 0, end loop
        
        LDY #0            ; Initialize index register Y to 0
        
loop2   LDX counter       ; Load counter into index register X
        LDA temp2         ; Load temp2
        
        JSR divide        ; Call subroutine to divide temp2 by counter
        
        BNE check_loop2   ; If division was successful, check loop2
        
        INX               ; Increment counter
        
check_loop2
        INY               ; Increment index register Y
        CPY #$02          ; Compare index register Y with constant 2
        BNE loop2         ; If not equal to 2, loop2
        
        JMP update_temp2  ; Jump to update_temp2

end_loop2
        LDA temp1         ; Load temp1
        STA result        ; Store the result in memory location result

        LDX temp2         ; Load temp2
        CLC               ; Clear carry flag
        LDA result        ; Load result
        ADC temp2         ; Add temp2 to result
        STA result        ; Store the result in memory location result
        
        RTS               ; Return from subroutine

divide  LDX #$00          ; Initialize index register X to 0

loop_div
        LDA #$00          ; Clear accumulator
        CPX #$00          ; Compare index register X with constant 0
        BNE skip_div      ; If not equal to 0, skip the division

        INC X             ; Increment index register X

skip_div
        CLC               ; Clear carry flag
        LDA temp1         ; Load temp1
        SBC temp2         ; Subtract temp2
        STA temp1         ; Store the result back in temp1

        CPX #$00          ; Compare index register X with constant 0
        BNE loop_div      ; If not equal to 0, loop_div

        SEC               ; Set carry flag
        
        RTS               ; Return from subroutine

num1    .BYTE $00       ; First number
num2    .BYTE $00       ; Second number
temp1   .BYTE $00       ; Temporary variable 1
temp2   .BYTE $00       ; Temporary variable 2
counter .BYTE $00       ; Counter variable
result  .BYTE $00       ; Result variable

        END start
