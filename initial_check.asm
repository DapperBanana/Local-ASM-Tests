
start:
    LDX #$07        ; Load the starting index into X register
    LDA #$11        ; Load the input binary number (00010001) into A register
    
convert_loop:
    LSR             ; Shift right to isolate the least significant bit
    BCC skip_add    ; If carry flag is set, skip add
    CLC             ; Clear the carry flag
    ADC #$30        ; Add '0' to the result in A
    skip_add:
    STA $01,X       ; Store the result into memory location $01-$08
    DEX             ; Decrement X
    BPL convert_loop; Loop until X is negative
    
    ; Print the result
    LDX #$07        ; Reload the starting index into X register
print_loop:
    LDA $01,X       ; Load the result from memory location $01-$08
    JSR $FFD2       ; Call KERNAL routine to print character in A
    DEX             ; Decrement X
    BPL print_loop  ; Loop until X is negative
    
    BRK             ; End program
    
    .ORG $FFD2      ; KERNAL routine for printing character
    JMP $EA81
