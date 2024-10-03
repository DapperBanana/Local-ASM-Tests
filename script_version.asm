
        .text
        .globl _start

_start:
        lda #0
        sta buffer_ptr
        
        lda #0
        sta email_ptr
        
        ldx #0
        ldy #0
        
loop:
        lda text,y
        beq end
        
        cmp #'@'
        beq found
        
        iny
        cpy #MAX_TEXT_SIZE
        bne loop
        
end:
        jmp done
        
found:
        lda y
        sta buffer, x
        inx
        
        lda text, y
        sta buffer, x
        inx
        
        lda email_ptr
        sta buffer_ptr
        
        lda buffer_ptr
        iny
        sta email_ptr
        
        lda #0
        sta buffer_ptr
        
        jmp loop   
        
done:
        rts
        
        .data
text:   .asciiz "This is a sample email address: test@email.com. Another one: example@example.com. End of text."
buffer: .ds 40
buffer_ptr: .byte
email_ptr: .byte

MAX_TEXT_SIZE = 255
