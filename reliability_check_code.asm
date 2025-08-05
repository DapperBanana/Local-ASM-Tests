
      .org $0200

start lda #0       ; initialize counter
      sta counter

      lda #1       ; initialize Fibonacci sequence
      sta fib1
      lda #1
      sta fib2

loop  cmp max_terms ; check if we have reached the max number of terms
      beq done

      lda fib1      ; calculate next term
      clc
      adc fib2
      sta next_term

      lda fib2
      sta fib1

      lda next_term
      sta fib2

      jsr print_fibonacci ; print the term

      inc counter   ; increment the counter
      jmp loop

done  rts

print_fibonacci
      lda #<text
      sta TXTCL
      lda #>text
      sta TXTHL

      lda counter
      jsr dec_to_ascii
      jsr print_string

      lda #<comma
      sta TXTCL
      lda #>comma
      sta TXTHL
      jsr print_string

      lda next_term
      jsr dec_to_ascii
      jsr print_string

      lda #<newline
      sta TXTCL
      lda #>newline
      sta TXTHL
      jsr print_string

      rts

dec_to_ascii
      clc
      lda #10
loop2 adc #48
      bcc no_increment
      adc #7
no_increment
      sta buffer,x
      dex
      lda #0
      cmp next_term
      bne loop2
      ldx #3
loop3 lda buffer,x
      sta $6000,x
      dex
      bpl loop3
      rts

print_string
      ldx #0
loop4 lda $6000,x
      beq done2
      jsr $FFD2
      inx
      jmp loop4
done2 rts

text  .byte "Fibonacci Term: "
comma .byte ", "
newline .byte $0D
max_terms .byte 10
fib1  .word 0
fib2  .word 0
next_term .word 0
counter .byte 0
buffer .byte 0,0,0,0
      .end
