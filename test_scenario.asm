
    ; Program to convert a decimal number to binary
    
    ORG $0200
    
start:
    LDX #$08         ; initialize counter to 8 bits
    LDA #$00         ; clear accumulator
    
get_input:
    JSR readInput    ; read decimal input
    CMP #$0A         ; check if input is < 10
    BCC convert      ; if less than 10, convert to binary
    LDA #$0A         ; if not, clear accumulator and prompt for valid input
    JSR sendOutput
    JMP get_input
    
convert:
    AND #$0F         ; mask input to store only 4 LSB
    CLC              ; clear carry flag
    ASL              ; shift accumulator left by 1
    ROL              ; rotate carry into LSB
    BCC skip         ; branch if no carry
    INC               ; increment accumulator to add carry
skip:
    DEX              ; decrement counter
    BNE convert      ; loop until all 8 bits are converted
    
sendOutput:
    STA output       ; store binary output in memory
    LDA #$0D         ; load carriage return character
    JSR sendChar     ; send carriage return
    LDA #$0A         ; load new line character
    JSR sendChar     ; send new line
    LDX #$08         ; reset counter
    
printOutput:
    LDA output,X     ; load binary output
    JSR sendChar     ; send output character
    DEX              ; decrement counter
    BPL printOutput  ; loop until all bits are printed
    
    JMP start        ; restart the program
    
readInput:
    LDA #$00         ; clear accumulator
    JSR getChar      ; read input character
    STA temp         ; store input in temp variable
    CMP #$0D         ; check if Enter key pressed
    BEQ endInput     ; exit if Enter key pressed
    CMP #$30         ; check if input is a valid digit (30H-39H)
    BCC readInput    ; branch if not valid
    CMP #$39
    BCS readInput
    
    LDA temp         ; convert ASCII to decimal
    SEC
    SBC #$30
    RTS
    
sendChar:
    STA $FE         ; load accumulator into IO register
    RTS
    
getChar:
    LDA $FE         ; read IO register into Accumulator
    RTS
    
temp:
    .BYTE $00
output:
    .BYTE $00
    
    ORG $FFFC
    .WORD start
