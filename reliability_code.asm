
FIBONACCI_START equ      $0200    ; Start address of program

                .org     FIBONACCI_START

start           lda      #0       ; Initialize variables
                sta      current_term
                lda      #1
                sta      next_term
                lda      #1
                sta      counter
                lda      #10      ; Number of terms to generate
                sta      num_terms

loop            lda      current_term
                jsr      print_number  ; Print current term

                lda      current_term
                clc
                adc      next_term
                sta      temp
                lda      next_term
                sta      current_term
                lda      temp
                sta      next_term

                inx
                cpx      num_terms
                bne      loop

end             rts

print_number    sta      $FD      ; Store number to be printed
                ldx      #2
                ldy      #$00
print_loop      lda      ($FD),y
                beq      print_done
                jsr      $FFD2
                iny
                bne      print_loop
                inc      $FD+1
                bne      print_loop

print_done      rts

                .end
