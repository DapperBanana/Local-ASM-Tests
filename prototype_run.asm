
; 6502 Assembly program to count the occurrences of each word in a given string

        .org $1000

string  .asciiz "hello world hello world hello"

        ; Initialize variables
        LDX #$00          ; Index for current word
        LDY #$00          ; Index for current character in word
        LDZ #$00          ; Index for current word index in table
        LDW #$00          ; Counter for current word count

        ; Parse string and count occurrences of each word
parse:
        LDA string,Y      ; Load current character
        CMP #32           ; Check if end of word
        BEQ next_word     ; If end of word, go to next word
        CMP #0            ; Check if end of string
        BEQ end_parse     ; If end of string, stop parsing

        INY               ; Increment character index

        ; Continue parsing current word
        JMP parse

next_word:
        STY word_length   ; Store word length
        LDX #$00          ; Reset character index

        ; Check if word already exists in table
check_word:
        LDA table,X       ; Load current word
        CMP string,Y      ; Compare with current word
        BEQ word_exists   ; If word exists, increment count and skip adding to table

        INX               ; Increment table index
        CMP #0            ; Check if end of table
        BNE check_word    ; If not end of table, check next word

        ; Add word to table if it doesn't already exist
        STY temp          ; Store current character index

add_word:
        LDA string,Y      ; Load current character
        STA table,X       ; Add character to table
        INY               ; Increment character index
        INX               ; Increment table index
        CMP #32           ; Check if end of word
        BNE add_word      ; If not end of word, continue adding characters
        STX table_count   ; Store current word count

word_exists:
        LDA table_count   ; Load current word count
        CLC
        ADC #$01          ; Increment word count
        STA table_count   ; Store updated count
        LDX temp          ; Restore current character index

        ; Move to next word in string
next_word_parse:
        INY               ; Increment character index
        LDA string,Y
        CMP #0            ; Check if end of string
        BEQ end_parse     ; If end of string, stop parsing

        ; Continue parsing next word
        JMP parse

end_parse:
        BRK               ; End the program

        .org $2000

table:
        .blkw $100        ; Table to store unique words
word_count:
        .blkw $100        ; Table to store word counts

        .org $FFFA

        .dw start
        .dw start

start:
        JSR parse         ; Start parsing the string

        ; Exit program
        LDA #$FF
        STA $F000
