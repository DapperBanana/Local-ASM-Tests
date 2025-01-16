
START LDA #0          ; Initialize counter for the current sequence
     STA CURRENT
    
     LDA #0          ; Initialize counter for the longest sequence
     STA LONGEST
    
     LDA #0          ; Initialize flag to indicate if we are in a sequence
     STA IN_SEQUENCE
    
     LDX #LIST_SIZE  ; Initialize counter for iterating through the list
    
LOOP LDA LIST,X      ; Load the next number from the list
     BEQ END_LOOP    ; If the number is 0, end the loop
    
     CMP #0          ; Compare the number with 0
     BEQ END_SEQUENCE ; If number is 0, end the current sequence
    
     CMP CURRENT     ; Compare the number with the previous number in the sequence
     BNE NEW_SEQUENCE ; If not consecutive, start a new sequence
    
     INC CURRENT     ; Increment counter for the current sequence
     JMP CONTINUE
    
NEW_SEQUENCE
     LDA CURRENT    ; Load the current sequence counter
     CMP LONGEST    ; Compare with the longest sequence counter
     BCC NOT_LONGEST ; If not longer, continue with the next number
    
     STA LONGEST    ; Update the longest sequence counter
    
NOT_LONGEST
     LDA #1         ; Start a new sequence
     STA CURRENT
     STA IN_SEQUENCE
     
CONTINUE
     LDA #1         ; Set flag to indicate we are in a sequence
     STA IN_SEQUENCE
    
END_SEQUENCE
     INX            ; Move to the next number in the list
     JMP LOOP
    
END_LOOP
     LDA LONGEST
     ; Output the longest consecutive sequence
    
     BRK            ; End program
    
LIST .BYTE 1,2,3,4,5,0 ; Example list of integers
LIST_SIZE = *-LIST     ; Calculate the size of the list
CURRENT  .BYTE 0       ; Counter for current sequence
LONGEST  .BYTE 0       ; Counter for longest sequence
IN_SEQUENCE .BYTE 0    ; Flag to indicate if we are in a sequence
