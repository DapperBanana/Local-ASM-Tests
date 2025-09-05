
; Simulated JSON data
API_DATA:
    .byte "{"            ; Start of JSON object
    .byte "key1": 123,   ; Key-value pair
    .byte "key2": "Hello, world!", ; Key-value pair
    .byte "}"            ; End of JSON object

; Entry point
    lda #<API_DATA      ; Load low byte of API_DATA address
    sta ptr             ; Store address in PTR
    lda #>API_DATA      ; Load high byte of API_DATA address
    sta ptr+1           ; Store address in PTR+1
    
    jsr process_json    ; Call subroutine to process JSON data
    
    jmp $               ; End program

; Subroutine to process JSON data
process_json:
    lda ptr             ; Load low byte of address
    sta addr            ; Store in temporary address
    lda ptr+1           ; Load high byte of address
    sta addr+1          ; Store in temporary address
    
    ldy #0              ; Initialize index
    
next_char:
    lda (addr),y        ; Load byte at address + index
    beq end_of_json     ; If byte is 0, end of JSON
    
    ; Put your JSON processing code here
    
    iny                 ; Increment index
    bne next_char       ; Branch to next_char
    iny                 ; Increment index
    
end_of_json:
    rts                 ; Return from subroutine

; Variables
ptr:    .word 0         ; Pointer to API_DATA
addr:   .word 0         ; Temporary address
