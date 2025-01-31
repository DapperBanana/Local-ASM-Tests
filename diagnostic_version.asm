
        ; Load the address of the input string into Y
        LDA input_string
        STA pointer
        LDA input_string + 1
        STA pointer + 1
        
        ; Initialize variables
        LDX #0
        LDY #0
        LDA #$00
        STA char_map
        
check_next_char:
        ; Load the next character from the input string
        LDA (pointer),Y
        BEQ is_isogram ; End of string reached
        
        ; Check if the character has been encountered before
        ASL A
        TAX
        LDA char_map,X
        BCS not_isogram
        
        ; Update char_map to mark this character as encountered
        ASL A
        ORA #$01
        STA char_map,X
        
        ; Increment Y to move to the next character in the string
        INY
        JMP check_next_char
        
not_isogram:
        LDA #$00
        STA is_isogram_flag
        
is_isogram:
        ; Store the result in the is_isogram_flag variable
        LDA is_isogram_flag
        STA result
        
        ; Halt the program
        BRK

input_string: .asciiz "hello"
pointer: .addr 0
char_map: .fill 256, 0
is_isogram_flag: .byte 1
result: .byte 0
