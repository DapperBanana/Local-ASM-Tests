
    .text
start:
    ldx #0            ; Initialize index for source string
    ldy #0            ; Initialize index for destination string
    
load_char:
    lda source_string, x  ; Load the next character from source string
    beq end_reversal   ; If null terminator is reached, branch to end_reversal
    inx               ; Increment source string index
    cpx #string_length   ; Check if we have reached the end of the string
    beq end_reversal
    jmp load_char     ; Loop back to load next character
    
copy_char:
    dex               ; Decrement source string index
    lda source_string, x  ; Load character from source string
    sta dest_string, y    ; Store character in destination string
    iny               ; Increment destination string index
    bpl copy_char     ; Continue copying characters
    
end_reversal:
    rts               ; Return
    
    .data
source_string:
    .asciiz "hello world"
string_length = * - source_string   ; Calculate length of source string
dest_string:
    .ds string_length     ; Reserve space for reversed string
