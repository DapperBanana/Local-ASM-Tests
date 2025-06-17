
    .org $0200

start   LDX #$00        ; Initialize X register to hold the count of vowels
        LDA #<input     ; Load low byte of address of input string
        LDY #>input     ; Load high byte of address of input string
        JSR readString   ; Call subroutine to read input string
        
count   LDA (ZP),Y       ; Load next character of string into A register
        CMP #$41        ; Check if character is 'A'
        BEQ increment   ; If character is 'A', increment counter
        CMP #$45        ; Check if character is 'E'
        BEQ increment   ; If character is 'E', increment counter
        CMP #$49        ; Check if character is 'I'
        BEQ increment   ; If character is 'I', increment counter
        CMP #$4F        ; Check if character is 'O'
        BEQ increment   ; If character is 'O', increment counter
        CMP #$55        ; Check if character is 'U'
        BEQ increment   ; If character is 'U', increment counter
        
        ; Check if end of string
        CMP #$00        ; Check if character is NULL
        BEQ end         ; If character is NULL, end program
        
        INY             ; Move to next character in the string
        JMP count       ; Continue counting vowels
        
increment
        INX             ; Increment the vowel count
        
        ; Check if end of string
        LDA (ZP),Y       ; Load next character of string into A register
        CMP #$00        ; Check if character is NULL
        BEQ end         ; If character is NULL, end program
        
        INY             ; Move to next character in the string
        JMP count       ; Continue counting vowels
        
end
        INX             ; Skip over NULL terminator
        STX result      ; Store the result in the result variable
        
done
        BRK             ; End program
        
result  .byte $00        ; Variable to store the result

input   .byte "HELLO, WORLD!", $00  ; Input string

; Subroutine to read input string
readString
        LDA #$00
        STA (ZP)
        LDX #$00
readLoop
        LDA (ZP),X
        BEQ doneReading
        INX
        JMP readLoop
doneReading
        RTS

    .end
