
start:
    LDA $3000    ; Load the address of the string into accumulator
    STA $00      ; Store the address in zero page
    LDX #$00     ; Initialize X register to index the string
    LDY #$00     ; Initialize Y register to keep track of characters seen so far
    
check_next_char:
    LDA ($00),Y  ; Load the next character from the string
    BEQ is_isogram  ; If end of string is reached, then it is an isogram
    CMP $00      ; Compare current character with previous characters seen
    BEQ not_isogram  ; If match is found, then it is not an isogram
    STA $00,X    ; Store the current character in memory for future comparison
    INX          ; Move to the next index in the string
    INY          ; Increment count of characters seen so far
    JMP check_next_char  ; Continue checking the next character in the string
    
is_isogram:
    LDA #$01     ; Load 1 into accumulator to indicate isogram
    STA $02      ; Store the result in memory
    BRK          ; Terminate the program
    
not_isogram:
    LDA #$00     ; Load 0 into accumulator to indicate not isogram
    STA $02      ; Store the result in memory
    BRK          ; Terminate the program
