
    ;
    ;  Program to check if a given string is an isogram
    ;

        .org $0200          ; Start address of program

start   LDA $2000          ; Load the memory location of the input string
        STA $01            ; Store in zero page
        LDA $2001          ; Load the length of the string
        STA $02            ; Store in zero page

        LDX $02            ; Load the length of the string
        LDY #$00            ; Initialize index for comparison

loop    INX                ; Increment index
        CPX $02            ; Check if we have reached the end of the string
        BEQ is_isogram     ; If so, it is an isogram

        LDA ($01),Y        ; Load character
        STA $03            ; Store in zero page
        LDY #$00            ; Initialize index for comparison

inner   CPY $02            ; Check if we have compared all characters
        BEQ not_isogram    ; If so, it is not an isogram

        INY                ; Increment index
        LDA ($01),Y        ; Load next character
        CMP $03            ; Compare with the current character
        BEQ not_isogram    ; If same, it is not an isogram
        JMP inner          ; Continue inner loop

is_isogram
        LDA #1             ; String is an isogram
        STA $0300          ; Store the result

done    BRK                ; Exit program

not_isogram
        LDA #0             ; String is not an isogram
        STA $0300          ; Store the result

        JMP done           ; Exit program
