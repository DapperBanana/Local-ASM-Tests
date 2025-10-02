
    .org $0200
    
start:
    ; Load file into memory
    LDA $fd00    ; Load starting address of file into A
    STA file_ptr ; Copy address to file pointer
    LDA $fd01
    STA file_ptr+1
    
read_loop:
    LDA (file_ptr),Y  ; Read byte from file
    CMP #","          ; Compare to CSV delimiter
    BEQ print_char    ; Branch if delimiter found
    CMP #"\n"         ; Compare to newline delimiter
    BEQ end_line      ; Branch if newline found
    JSR $ffd2         ; Print character
    INY               ; Increment file pointer
    JMP read_loop

print_char:
    JSR $ffd2         ; Print character
    INY               ; Increment file pointer
    JMP read_loop

end_line:
    RTS

file_ptr: .word $0400  ; Address where file is loaded
    
    .org $fffa
    .word start
