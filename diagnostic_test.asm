
    .text
    .org $0200
    
start:
    ; Initialize variables
    LDA #$00        ; Initialize sum to 0
    STA sum
    
    ; Get user input
    LDX #$00        ; Initialize index to 0
input_loop:
    ; Read user input
    JSR read_input
    
    ; Check for end of input
    CMP #$0D        ; Check for Enter key
    BEQ calculate_sum
    
    ; Convert ASCII to number
    SEC
    SBC #$30        ; Convert ASCII to number
    TAX
    
    ; Add digit to sum
    CLC
    LDA sum
    ADC X
    STA sum
    
    INX             ; Increment index
    JMP input_loop
    
calculate_sum:
    ; Print sum of digits
    LDA sum
    JSR print_sum
    
    ; End program
    BRK
    
read_input:
    ; Read character from input
    JSR $FFCF       ; KERNAL GETIN
    STA input
    
    ; Print character
    LDA input
    JSR $FFD2       ; KERNAL CHROUT
    
    RTS
    
print_sum:
    ; Print sum
    JSR $FFD2       ; KERNAL CHROUT
    RTS
    
    .data
input:  .byte $00
sum:    .byte $00
