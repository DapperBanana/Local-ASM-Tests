
        ORG $1000
        
START   LDA $FF00      ; Load the length of the string
        SEC            ; Set carry flag for subtraction
        SBC #2         ; Subtract 2 to get the end index of the string
        STA $FF01      ; Store the end index in memory
        
        LDX #0         ; Set X register to start index of the string
        LDY $FF00      ; Load the length of the string
        DEY            ; Decrement Y register to get the last index of the string
        STY $FF00      ; Store the updated length in memory
        
CHECK   CPX $FF00      ; Compare start index with end index
        BCS END        ; If start index >= end index, then it's a palindrome
        
        LDA ($FF00),X  ; Load character from start index
        CMP ($FF01),X  ; Compare character from end index
        BNE NOT_PALINDROME ; If not equal, then it's not a palindrome
        
        INX            ; Increment start index
        DEY            ; Decrement end index
        JMP CHECK      ; Repeat the check
        
NOT_PALINDROME
        LDA #$00       ; Set A register to 0 to indicate it's not a palindrome
        STA $FF02      ; Store the result in memory
        RTS            ; Return
        
END     LDA #$01       ; Set A register to 1 to indicate it's a palindrome
        STA $FF02      ; Store the result in memory
        
        RTS            ; Return
