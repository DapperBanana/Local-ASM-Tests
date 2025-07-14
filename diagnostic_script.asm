
    .org $1000
    
start:
    ; Open the file
    lda #08 ; Open for read
    ldx #>filename
    ldy #<filename
    jsr $FFBD ; OPEN
    bcs file_error
    
    ; Read and print each line of the file
read_loop:
    lda #0 ; Reset file pointer
    jsr $FFC0 ; SETPTR
    lda #1 ; Read 1 byte at a time
    jsr $FFBA ; READ
    bcs file_end ; End of file
    
    ; Check for newline character
    cmp #10 ; ASCII for newline
    beq print_line ; Print the current line
    jsr $FFD2 ; CHROUT to console
    bpl read_loop ; Continue reading
    
print_line:
    jsr $FFD2 ; CHROUT to console
    jmp read_loop ; Continue reading
    
file_error:
    jsr $FFD2 ; CHROUT to console
    lda #<"Error opening file"
    jsr $FFD6 ; Print error message
    rts ; Exit program
    
file_end:
    jsr $FFD2 ; CHROUT to console
    lda #<"End of file"
    jsr $FFD6 ; Print message
    rts ; Exit program
    
filename:
    .byte "data.csv",0
    
    .end start
