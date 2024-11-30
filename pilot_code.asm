
        .org $0200

start   lda #0          ; Initialize index to 0
        sta index
      
loop    lda input,index ; Load character from input string
        cmp #0          ; Check for end of string
        beq done        ; If end of string, exit loop
        
        sta buffer,x    ; Store character in buffer
        inx             ; Increment buffer index
        inx             ; Move to next byte (skip null terminator)
        inx
      
        inx             ; Increment input index
        jmp loop        ; Repeat loop
        
done    dex             ; Decrement buffer index to skip null terminator
        txa             ; Copy buffer index to X register
        lda #0          ; Null terminate buffer
        sta buffer,x
        jsr print_string ; Print reversed string
        
        rts

input   .byte "Hello World!",0
buffer  .block $20

print_string
        ldx #0          ; Initialize index to 0
        
print_loop
        lda buffer,x    ; Load character from buffer
        beq print_end   ; If null terminator, end loop
        
        jsr $FFD2       ; Kernal routine to print character
        
        inx             ; Increment index
        jmp print_loop  ; Repeat loop
        
print_end
        rts

index   .byte 0

        .end
