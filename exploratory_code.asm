
    .org $0200

str1        .asc "hello"
str2        .asc "world"
result      .byte 0

start:
    ldx #0      ; Initialize index to 0

loop:
    lda str1, x  ; Load character from str1
    beq end      ; If end of string, exit loop
    jsr check    ; Check if character is already present in str2
    inx          ; Increment index
    jmp loop     ; Continue looping

end:
    lda #$00     ; Load null character
    sta result   ; Store result
    rts          ; Return from subroutine

check:
    ldy #0      ; Initialize index to 0
    
check_loop:
    lda str2, y  ; Load character from str2
    beq not_common  ; If end of string, character is not common
    cmp str1, x  ; Compare character from str1 and str2
    beq common   ; If characters match, they are common
    iny          ; Increment index
    jmp check_loop ; Continue looping

common:
    lda str1, x  ; Load common character
    sta result   ; Store result
    rts          ; Return from subroutine

not_common:
    rts          ; Return from subroutine
