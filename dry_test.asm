
; Assume a list of strings is stored in memory with each string terminated by a null byte
; Store the starting address of the list in $1000
; Store the number of strings in $1002
; The longest common prefix will be stored starting from address $1100

LDA#$00      ; Initialize index to zero
STA$1100

LDA$1002     ; Load number of strings
CMP#$00      ; Check if there are strings
BEQEND       ; If no strings, end program

LOOP:
LDA$1000     ; Load address of current string
CLC
ADC$1100     ; Add index to get current character
STA$1101     ; Store current character in $1101

LDA$1101     ; Load current character
BEQEND       ; If current character is null byte, end program

CMP($1000),Y ; Compare current character with character in first string
BNEEND       ; If characters do not match, end program

INC$1000     ; Move to next string
LDA$1000
CMP#$00
BEQEND       ; If reached end of list, end program

LDA$1100     ; Load current prefix length
CLC
ADC#$01      ; Increment prefix length
STA$1100     ; Store updated prefix length

JMPLOOP      ; Continue with next character in strings

END:
BRK

BEQEND:
LDA$1100     ; Load current prefix length
STA$1103     ; Store length of the common prefix

RTS
