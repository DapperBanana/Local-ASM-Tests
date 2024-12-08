
    .org $0600
    
start:
    lda #$00              ; Initialize index for string comparison
    ldx #$00              ; Initialize index for DTD comparison
    
check_xml:
    lda input_str, x      ; Load character from input string
    cmp #$3C              ; Compare character to ASCII '<'
    bne not_valid_xml     ; Branch if character is not '<'
    inx                   ; Increment DTD index
    lda dtd_str, x        ; Load character from DTD string
    cmp #$3C              ; Compare character to ASCII '<'
    beq check_end         ; Branch if DTD end is reached
    cmp input_str, x      ; Compare character to corresponding position in input string
    bne not_valid_xml     ; Branch if characters do not match
    inx                   ; Increment index
    jmp check_xml         ; Repeat for next character
    
not_valid_xml:
    lda #$00              ; Set flag to indicate invalid XML
    jmp end               ; Jump to end
    
check_end:
    lda dtd_str, x        ; Check if DTD is at end
    cmp #$00              
    bne not_valid_xml     ; Branch if DTD is not at end
    
valid_xml:
    lda #$01              ; Set flag to indicate valid XML
    
end:
    rts
    
input_str:
    .asciiz "<xml>...</xml>"
    
dtd_str:
    .asciiz "<!DOCTYPE ...>"
