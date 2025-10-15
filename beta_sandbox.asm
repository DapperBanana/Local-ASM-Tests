
; Initialize variables
buffer   .ds   16     ; buffer to store input string
valid_ip .ds   1      ; flag to indicate valid IP address
input    .ds   1      ; variable to store input character
count    .ds   1      ; counter for digits in octet
octet    .ds   1      ; temporary storage for octet value
digit    .ds   1      ; temporary storage for digit value
         
; Main program loop
          ldx   #0     ; initialize index
loop      lda   buffer,x ; load character from buffer
          beq   done   ; end of string
          cmp   #'.'  ; check for delimiter
          beq   next_octet ; move to next octet
          cmp   #'0'
          bcc   invalid ; not a digit
          cmp   #'9'
          bcs   invalid ; not a digit
          jsr   ascii_to_digit ; convert ASCII digit to number
          clc
          lda   octet   ; load current octet
          asl   a     ; multiply by 2
          tay
          lda   digit   ; load digit
          clc
          adc   y     ; add digit to octet
          sta   octet   ; store result
          inx         ; next character
          jmp   loop
          
; Check if digit is a valid number
ascii_to_digit
          sec
          sbc   #'0'  ; subtract ASCII '0' to get digit value
          rts
          
; Check if the input string is a valid IPv4 address
invalid   lda   #0     ; set flag to indicate invalid IP address
          bra   done

; Move to next octet
next_octet
          lda   octet   ; load current octet
          cmp   #256   ; check if octet is within range
          bcc   invalid ; not a valid octet
          lda   #0     ; reset octet value
          lda   count   ; load digit count
          cmp   #3     ; check if 3 digits have been processed
          bne   invalid ; not a valid octet
          lda   #0     ; reset digit count
          jmp   loop

; End of program
done      rts
