
START       LDA #27             ; Load the number to check 
            AND #$01            ; Check the least significant bit (LSB) 
            BEQ EVEN           ; If LSB is 0, jump to EVEN label 
            JSR ODD            ; Otherwise, call the ODD subroutine 
            BRA END            ; Branch to END label 
EVEN        JSR EVEN           ; Call the EVEN subroutine 
            BRA END            ; Branch to END label 
ODD         JSR ODD            ; Call the ODD subroutine 
END         BRK                 ; End the program 

EVEN        LDA #0              ; Load 0 to accumulator 
            STA $00             ; Store 0 to memory location $00 
            RTS                 ; Return from subroutine 

ODD         LDA #1              ; Load 1 to accumulator 
            STA $00             ; Store 1 to memory location $00 
            RTS                 ; Return from subroutine 
