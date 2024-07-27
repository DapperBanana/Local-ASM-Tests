
START
    LDX #0          ; Initialize index to 0
LOOP
    LDA STRING,X    ; Load character from string
    CMP #32         ; Check if character is space
    BEQ SKIP        ; If space, skip punctuation removal
    CMP #44         ; Check if character is comma
    BEQ SKIP        ; If comma, skip punctuation removal
    CMP #46         ; Check if character is period
    BEQ SKIP        ; If period, skip punctuation removal
    CMP #33         ; Check if character is exclamation mark
    BEQ SKIP        ; If exclamation mark, skip punctuation removal
    CMP #63         ; Check if character is question mark
    BEQ SKIP        ; If question mark, skip punctuation removal
    CMP #0          ; Check if end of string
    BEQ END         ; If end of string, exit loop
    STA OUTPUT,X    ; Store character in output string
    INX             ; Increment index
SKIP
    INX             ; Increment index
    CPX #255        ; Check if end of string
    BNE LOOP        ; If not end of string, continue loop
END
    BRK             ; Exit program

STRING
    .ASC "Hello, world! This is a test. How are you?"

OUTPUT
    .BLKW 255       ; Output string
