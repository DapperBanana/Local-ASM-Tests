
; Find the longest common prefix of a list of strings
; Inputs:
; - Starting address of the list of strings in memory (pointers to null-terminated strings)
; - Number of strings in the list
; Outputs:
; - Address of the longest common prefix string in X register
; - Length of the longest common prefix in Y register

    SEI
    LDX #$FF        ; Initialize X register with $FF
    LDY #$FF        ; Initialize Y register with $FF

    LDY #0          ; Initialize index to 0
loop:
    LDA (pointer), Y    ; Load character from the first string
    CMP #$00        ; Check for null terminator
    BEQ done        ; If null terminator, we are done

    LDY #1          ; Restart index at 1
    LDX (pointer)   ; Load address of the second string
inner_loop:
    LDA (pointer), Y    ; Load character from the second string
    CMP #$00        ; Check for null terminator
    BEQ done        ; If null terminator, we are done
    CMP (pointer), Y    ; Compare characters from both strings
    BNE done        ; If characters don't match, we are done

    INX             ; Increment X register (length of common prefix)
    INY             ; Increment index
    JMP inner_loop  ; Repeat inner loop

done:
    INY             ; Increment Y register to get length of prefix
    STX $00         ; Store length of common prefix in $00
    LDY #0          ; Initialize index to 0

find_pointer:
    LDA (pointer), Y    ; Load character from the first string
    CMP #$00        ; Check for null terminator
    BEQ end        ; If null terminator, we are done

    INY             ; Increment index
    JMP find_pointer    ; Repeat loop

end:
    TXA             ; Transfer length of prefix from X to A register
    TAX             ; Transfer A to X register
    STX $01         ; Store address of longest common prefix string in $01

    CLI
    RTS             ; Return

pointer:            ; Pointer is used to store the address of current string
    .word 0x0000    ; Initialize pointer to 0
