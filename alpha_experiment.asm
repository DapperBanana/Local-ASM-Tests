
          .org    $0200
          sei
          lda     #$00         
 
nextchar  lda     $0201,x       ; Get character               
          cmp     #$20          ; Check for space   
          beq     updatespace   ; If space then update length   
          inx                  ; Increment index
          bne     nextchar      ; If index is not zero, continue 
          inc     $0200         ; If index is zero, increment length
          bra     nextchar      ; Continue        
 
updatespace
          lda     $0200
          clc                  ; Clear carry flag
          adc     #$FF
          sta     $0200         ; Save the result
          inx                  ; Increment index
          lda     #$00          ; Clear the length
          sta     $0200         ; Save the length
          cmp     #$00
          beq     done          ; If end of sentence, done
          bra     nextchar      ; Continue    
 
done      lda     $0200
          sta     $0202         ; Save the result
          cli
          rts
 
sentence  .asciiz "This is a sample sentence"
          .byte   0
 
          .org    $0300
          jmp     sentence
