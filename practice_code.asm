
RESET         = $FFFC       ; Reset vector address
START         = $0600       ; Start of program memory

  org START

start:
  lda #<string        ; Load low byte of string address into accumulator
  sta ptr             ; Store low byte of string address in pointer
  lda #>string        ; Load high byte of string address into accumulator
  sta ptr+1           ; Store high byte of string address in pointer

  ldx #0              ; Initialize index X to 0
  ldy #0              ; Initialize index Y to 0
  stx longest_len     ; Initialize longest length to 0

loop:
  lda (ptr),y         ; Load character at current index Y
  beq end             ; If end of string, go to end
  cmp #$00            ; If null terminator, go to end
  beq end

  jsr check_palindrome ; Check for palindrome
  bcs update_longest  ; If palindrome, update longest length

  iny                 ; Increment index Y
  jmp loop            ; Repeat for next character

update_longest:
  lda longest_len
  cmp len
  bcs skip_update
  sta longest_len
  lda len
  sta longest

skip_update:
  jmp loop

check_palindrome:
  ldx #0               ; Initialize index to 0
  ldy #0               ; Initialize index to 0

check_loop:
  lda (ptr),y          ; Load character at current index Y
  beq end_check        ; If end of string, return
  cmp #$00             ; If null terminator, return
  beq end_check

  sta temp,x           ; Store character in temp array
  iny                  ; Increment index Y
  inx                  ; Increment index X
  bne check_loop       ; Repeat until 256 characters stored

end_check:
  dex
  stx len              ; Store length

check_palindrome_loop:
  lda temp,x           ; Load character from temp array
  cmp (ptr),y          ; Compare with original character
  bne not_palindrome   ; If not palindromic, return

  inx                  ; Increment index X
  dey                  ; Decrement index Y

  cpx len              ; Compare lengths
  bcc check_palindrome_loop ; Repeat until end
  sec
  rts

not_palindrome:
  clc
  rts

end:
  rts

ptr:
  .word 0
len:
  .byte 0
longest:
  .byte 0
temp:
  .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
string:
  .asciiz "abcbac"
