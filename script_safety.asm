
    .org $0200
    
start:
    LDX #$00             ; Initialize index to zero
    
read_input:
    LDA input,X          ; Load next input character
    BEQ end_of_input     ; If end of input, exit
    
    CMP #$20             ; Check if character is a space
    BEQ read_input       ; If space, skip and read next character
    
    STA temp             ; Store the character in temp
    
search_dictionary:
    LDA dictionary,X     ; Load next entry in dictionary
    BEQ no_translation   ; If end of dictionary, no translation found
    
    CMP temp             ; Compare the current dictionary entry with input character
    BEQ found_translation ; If match, found translation
    
    INX                  ; Move to next entry in dictionary
    INX                  ; Skip translation entry
    
    JMP search_dictionary ; Continue searching in dictionary
    
found_translation:
    LDA dictionary,X     ; Load translation word
    JSR print_output     ; Print translation word
    
    INX                  ; Skip original word
    
    LDA dictionary,X     ; Load next entry in dictionary
    STA temp             ; Store translation in temp
    
    JMP search_dictionary ; Continue searching in the rest of the dictionary
    
no_translation:
    JSR print_output     ; Print original word
    
    JMP read_input       ; Continue reading the input string
    
end_of_input:
    BRK                  ; End program execution
    
print_output:
    ; Print the character in A to output device
    ; (e.g., screen or printer)
    RTS
    
input:
    .byte "hello",0      ; Input string to be translated
    
dictionary:
    .byte "hello","hola",0 ; English to Spanish translation dictionary
    
    .byte 0 ; End of dictionary
