
; Length of first string
first_len:   .byte 6
; Length of second string
second_len:  .byte 7

; First string
first_string: .asciiz "ABCDGH"
; Second string
second_string: .asciiz "AEDFHR"

; Table to store lengths of common subsequences
subseq_lengths: .fill 42, 0

start:
    LDA first_len
    STA $FE  ; Store length of first string at memory location $FE
    LDA second_len
    STA $FF  ; Store length of second string at memory location $FF

    LDA $FE
    STA $01  ; Load length of first string into X register
    LDA $FF
    STA $02  ; Load length of second string into Y register

    JSR find_subseq  ; Find the length of the longest common subsequence

    LDA subseq_lengths
    STA result  ; Store the result in memory location 'result'

    BRK  ; Exit the program

find_subseq:
    LDX $01
    LDY $02

    LDA #0
    STA (subseq_lengths),X ; Initialize the first row of the table with zeros

loop:
    CPX #0
    BEQ done  ; If end of first string reached, exit loop
    CPY #0
    BEQ done  ; If end of second string reached, exit loop

    LDA first_string,X  ; Load character from first string
    CMP second_string,Y  ; Compare character with second string

    BEQ same_char
    JMP check_length

same_char:
    LDA subseq_lengths,X
    CLC
    ADC #1  ; Increment length of the common subsequence
    STA subseq_lengths,X

    INX
    INY
    JMP loop

check_length:
    LDA subseq_lengths,X
    LDX subseq_lengths,X+1
    LDY subseq_lengths-6,Y

    CPX LDY
    BEQ keep_max
    CPX LDX
    BCS keep_max
    LDX subseq_lengths
    STA LDX

    RTS

keep_max:
    LDY subseq_lengths-6,Y
    STA LDX
    RTS

done:
    RTS

result: .byte 0  ; Variable to store the length of the longest common subsequence
