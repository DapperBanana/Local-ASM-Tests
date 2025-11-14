
        LDA #10         ; Load the value of variable 1 into the accumulator
        STA TEMP        ; Store the value of variable 1 in TEMP
        LDA #20         ; Load the value of variable 2 into the accumulator
        STA VAR1        ; Store the value of variable 2 in VAR1
        LDA TEMP        ; Load the value of variable 1 from TEMP into the accumulator
        STA VAR2        ; Store the value of variable 1 in VAR2

        TEMP .BYTE 0     ; Temporary variable to store value of variable 1
        VAR1 .BYTE 0     ; Variable 1
        VAR2 .BYTE 0     ; Variable 2
