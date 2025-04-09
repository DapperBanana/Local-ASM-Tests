
.ORG $1000

LDA #0         ; Initialize counter for current sequence length
STA current_length  
LDA #0         ; Initialize counter for longest sequence length
STA longest_length
LDA #0         ; Initialize start index of longest sequence
STA start_index
LDA #0         ; Initialize end index of longest sequence
STA end_index

LDA #10        ; Load the number of integers in the list
STA list_length
LDA #1         ; Load the start index of the sequence
STA current_index

LOOP:
    LDA list, X    ; Load the current integer
    STA current_number
    CMP #255       ; Check if we have reached the end of the list
    BEQ END
    
    LDA current_number
    CMP previous_number
    BEQ CONTINUE       ; If current number is same as previous, continue the sequence

    LDA current_length
    CMP longest_length
    BEQ NEXT_SEQUENCE  ; If current sequence is longer than longest, update longest sequence
    
    LDA #0             ; Reset current sequence length
    STA current_length
    STA start_index    ; Update start index of new sequence
    LDX current_index
        
CONTINUE:
    INC current_index  ; Move to next integer
    LDA current_length 
    INC                ; Increment the current sequence length
    STA current_length
    
    LDA current_number ; Update previous number
    STA previous_number
    
    JMP LOOP
   
NEXT_SEQUENCE:
    LDA current_length
    STA longest_length
    LDA start_index
    STA start_index
    LDA current_index
    DEC               ; Update end index
    STA end_index
    
    LDA #0           ; Reset current sequence length for next sequence
    STA current_length
        
    JMP LOOP

END:
    BRK

current_length: .BYTE 0
longest_length: .BYTE 0
current_index: .BYTE 0
start_index: .BYTE 0
end_index: .BYTE 0
previous_number: .BYTE 0
current_number: .BYTE 0
list_length: .BYTE 0
list: .BYTE 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 255

.END
