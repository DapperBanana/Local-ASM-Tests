
          .org $0200
start:    lda #NUMBER     ; Load the number to find prime factors of
          ldx #2          ; Start with the smallest prime factor
loop:     cpx NUMBER      ; Check if we have reached the end
          beq done        ; If so, we are done
          lda NUMBER      ; Load the number again
          clc
          div x          
          bcc not_factor   ; If the division result has a remainder, then x is not a factor
          sta NUMBER      ; Update the number to be the quotient
          lda x           ; Load the factor to be printed
          jsr print_num   ; Call subroutine to print the factor
          lda #44         ; Load ASCII value for comma to print next factor
          jsr print_char  ; Call subroutine to print comma
          jmp loop        ; Continue loop
not_factor:  inx            ; Increment factor
          jmp loop
done:     lda #0          ; Load 0 to indicate end of factors
          jsr print_num   ; Print end of factors
end:      rts

print_char:
          sta $fb
          lda #02
          jsr $ffd2
          rts

print_num:
          ldx #0
print_loop:
          clc
          adc #$30
          sta $fe,x
          inx
          lda #0
          bcc print_loop
