
                        .org $1000

start:
  ; Set up stack pointer
  ldx #$FF
  txs

  ; Print quiz instructions
  lda #<message1
  ldx #>message1
  jsr printMessage

  ; Question 1
  lda #<question1
  ldx #>question1
  jsr printMessage
  jsr getAnswer
  cmp #1
  beq answer1
  bne question2

question2:
  ; Question 2
  lda #<question2
  ldx #>question2
  jsr printMessage
  jsr getAnswer
  cmp #1
  beq answer2
  bne result

answer1:
  ; Answer 1
  lda #<answer1
  ldx #>answer1
  jsr printMessage
  jmp end

answer2:
  ; Answer 2
  lda #<answer2
  ldx #>answer2
  jsr printMessage
  jmp end

result:
  ; Result message
  lda #<result
  ldx #>result
  jsr printMessage

end:
  ; End program
  rts

printMessage:
  ; Print message stored in memory
  sta $02
  stx $03
printLoop:
  lda ($02),Y
  beq printDone
  jsr $ffd2
  iny
  bne printLoop
printDone:
  rts

getAnswer:
  ; Get user input
  lda #$00
  jsr $ffcf
  cmp #'1'
  bne invalidAnswer
  jmp inputDone
  
invalidAnswer:
  lda #<invalid
  ldx #>invalid
  jsr printMessage

inputDone:
  rts

message1:
  .text "Welcome to the personality quiz! Please answer the following questions by entering 1 or 2.\n"
  .byte 0
  
question1:
  .text "Question 1: Are you more of an introvert (1) or extrovert (2)?\n"
  .byte 0

question2:
  .text "Question 2: Do you prefer mountains (1) or beaches (2)?\n"
  .byte 0

answer1:
  .text "You are an introvert!\n"
  .byte 0

answer2:
  .text "You are an extrovert!\n"
  .byte 0

result:
  .text "Thank you for taking the quiz!\n"
  .byte 0

invalid:
  .text "Invalid answer. Please enter 1 or 2.\n"
  .byte 0

  .end start
