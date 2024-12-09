
; Queue data structure implementation in 6502 Assembly

queue_start    equ $0200    ; Start of queue address
queue_end      equ $0210    ; End of queue address

input_buffer   equ $020F    ; Input buffer address

index_read     equ $00      ; Read index
index_write    equ $01      ; Write index

                org $0200

start           lda #queue_start
                sta index_read
                sta index_write
                lda #0
                sta input_buffer

loop            ; Check if queue is full
                lda index_write
                cmp index_read
                beq loop    ; Wait if full

                lda input_buffer
                sta (index_write)
                inc index_write

                lda input_buffer
                and #$00
                sta input_buffer

                lda index_write
                cmp #queue_end
                bne loop

end             lda index_read
                cmp index_write
                beq end    ; Wait if empty

                lda (index_read)
                sta input_buffer
                inc index_read

                ; Process input_buffer here

                lda index_read
                cmp #queue_end
                bne end

                jmp loop

                end
