
; Define memory locations
SUM       = $00  ; Result of sum
DATA_PTR  = $01  ; Pointer to current data byte
DATA      = $100 ; Start of data

; Main program
        LDA #<DATA  ; Load low byte of data address
        STA DATA_PTR ; Store in data pointer
        LDA #>DATA  ; Load high byte of data address
        STA DATA_PTR+1 ; Store in data pointer
        
ADD_LOOP:
        LDA (DATA_PTR),Y ; Load data byte
        BEQ DONE  ; If null terminator, exit loop
        
        CMP #","  ; Check if comma
        BEQ NEXT_ELEMENT ; If so, skip to next element
        
        CLC
        ADC #48   ; Convert ASCII to binary
        TAX
        LDA SUM
        ADC TAX
        STA SUM ; Add to sum
        
NEXT_ELEMENT:
        INY  ; Increment data pointer
        JMP ADD_LOOP ; Repeat loop
        
DONE:
        ; Result stored in SUM, program end
