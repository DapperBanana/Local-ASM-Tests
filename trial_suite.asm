
        .org $0200

start   LDX #0           ; Initialize X register to 0 (index for length count)
        LDY #0           ; Initialize Y register to 0 (index for longest word)
        LDY #0           ; Initialize Y register to 0 (index for current word)
        LDA sentence    ; Load address of sentence into accumulator
        STA ptr         ; Store address in pointer
        LDA #0          ; Load null terminator into accumulator
        STA max_len     ; Initialize max_len to 0

loop    LDA (ptr),Y     ; Load character from memory
        BEQ end         ; If we reach the null terminator, end loop
        CMP #$20        ; Compare character with space
        BEQ next_word   ; If space is found, move to next word
        INY             ; Increment index for current word
        JMP loop

next_word
        CPY max_word    ; Check if current word length is greater than max_word
        BCS update_len  ; If yes, update max_len
        LDA #$00        ; Reset current word length
        STA max_word
        INY             ; Move to next word
        JMP loop

update_len
        STY max_word    ; Store current word length as max_word
        LDA max_len     ; Load current max length
        CMP max_word    ; Compare with current word length
        BCS skip_update ; If current word length is less than max length, skip update
        STA max_len     ; Update max_len with current word length

skip_update
        LDA ptr         ; Load address of sentence into accumulator
        STA ptr         ; Store address in pointer
        INX             ; Increment length count
        JMP loop

end
        HLT             ; Halt the program

sentence .byte "This is a sample sentence", 0
ptr     .word 0
max_len .byte 0
max_word .byte 0

        .end
