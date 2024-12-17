
; Input: a list of numbers, terminated by a zero
; Output: the median of the list of numbers

          .org $0200

start     ldx #0              ; Initialize index to 0
          lda numbers,x       ; Load first number from list
          clc
          beq done            ; If number is zero, exit loop
loop      inx                 ; Increment index
          lda numbers,x       ; Load next number from list
          beq check_median    ; If number is zero, calculate median
          cmp numbers,x       ; Compare current number with next number
          bcc continue        ; If next number is greater, continue
          sta temp            ; Otherwise, swap numbers
          sta numbers,x
          lda temp
          sta numbers,x
          bcc continue
continue  jmp loop            ; Continue looping

check_median
          lda #0              ; Initialize median to 0
          ldy #0              ; Initialize counter to 0
          ldx #0              ; Initialize index to 0
median_loop
          lda numbers,x       ; Load number from list
          iny                 ; Increment counter
          inc x               ; Increment index
          beq calculate_median ; If number is zero, calculate median
          jmp median_loop

calculate_median
          lsr y               ; Divide counter by 2 to find midpoint
          asl y
          ldx y               ; Move midpoint to X register
          lda numbers,x       ; Load number at midpoint
          sta median          ; Store the median

done      rts

numbers   .byte 5, 3, 2, 6, 4, 0 ; List of numbers

temp      .byte 0
median    .byte 0

          .end
