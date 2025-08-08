
start
    LDA #decimal_number   ; Load the decimal number into the accumulator
    STA number
    
    LDA #0               ; Clear the numerator
    STA numerator
    
    LDA #1               ; Set the denominator to 1
    STA denominator
    
    LDX #1               ; Start with a fraction of 1/1
    
loop
    CMP number           ; Compare the current fraction with the input decimal number
    BEQ done             ; If the fraction is equal to the input number, we are done
    
    BCC increment        ; If the fraction is less than the input number, increment the numerator and denominator
    JMP divide           ; If the fraction is greater than the input number, divide the fraction by 2 and try again
    
increment
    INX                  ; Increment the numerator
    INX                  ; Increment the denominator
    JMP loop

divide
    LDX numerator        ; Divide the numerator by 2
    LSR
    STX numerator
    
    LDX denominator      ; Divide the denominator by 2
    LSR
    STX denominator
    
    JMP loop

done
    ; The fraction is now equal to the input decimal number
    ; The numerator is in the X register
    ; The denominator is in the Y register

    BRK

number .BYTE 0
numerator .BYTE 0
denominator .BYTE 0
