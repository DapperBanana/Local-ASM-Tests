
        .org    $0200
start:
        LDX     #0                     ; Initialize index X to 0
        LDA     message,X              ; Load the first character of the string
        CMP     #$00                   ; Check if it is null character
        BEQ     is_palindrome           ; If it is, the string is a palindrome
        JSR     strlen                 ; Get the length of the string
        DEX                           ; Decrement the length by 1
loop:
        CPX     X                      ; Check if index X is equal to or greater than the length
        BCS     is_palindrome           ; If it is, the string is a palindrome
        LDA     message,X              ; Load the character at index X
        CMP     message,X              ; Compare with the corresponding character at the end of the string
        BNE     not_palindrome          ; If not equal, the string is not a palindrome
        INX                           ; Increment index X
        DEX                           ; Decrement length by 1
        JMP     loop                   ; Continue looping

is_palindrome:
        ; String is a palindrome
        JMP     palindrome_found

not_palindrome:
        ; String is not a palindrome
        JMP     not_palindrome_found

strlen:
        LDX     #0                     ; Initialize index X to 0
count:
        LDA     message,X              ; Load the character at index X
        BEQ     done                   ; If it is null character, we have reached the end of the string
        INX                           ; Increment index X
        JMP     count                  ; Continue counting

done:
        RTS

message:
        .text    "anna"                ; Palindrome string

palindrome_found:
        ; Add your logic here for when the string is a palindrome
        BRK

not_palindrome_found:
        ; Add your logic here for when the string is not a palindrome
        BRK
