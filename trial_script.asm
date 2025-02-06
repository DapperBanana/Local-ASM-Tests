
.segment "CHAR"
message_start
.byte "Welcome to the Personality Quiz! Answer a few questions to find out more about yourself.", 0
message_end

.segment "DATA"
question1
.byte "1. Are you more introverted or extroverted? (I/E)", 0
question2
.byte "2. Do you prefer routine or spontaneity? (R/S)", 0
question3
.byte "3. Are you more logical or emotional? (L/E)", 0
question4
.byte "4. Would you rather work alone or in a team? (A/T)", 0
question5
.byte "5. Are you a planner or do you like to go with the flow? (P/G)", 0

answers
.byte 0,0,0,0,0

.segment "BSS"
response
.byte 0

.segment "CODE"
.org $8000

start:
    lda #message_start
    jsr print_string
    
    lda #question1
    jsr print_string
    jsr get_response
    sta answers
    
    lda #question2
    jsr print_string
    jsr get_response
    sta answers+1
    
    lda #question3
    jsr print_string
    jsr get_response
    sta answers+2
    
    lda #question4
    jsr print_string
    jsr get_response
    sta answers+3
    
    lda #question5
    jsr print_string
    jsr get_response
    sta answers+4
    
    lda #message_end
    jsr print_string
    
    lda answers
    jsr print_answer
    
done:
    rts

print_string:
    ldx #0
print_loop:
    lda [x]
    beq print_done
    jsr $ffd2 ; CHROUT
    inx
    jmp print_loop
print_done:
    rts

print_answer:
    lda response
    sta $d020 ; clear screen
    cmp #"I"
    beq introverted
    cmp #"E"
    beq extroverted
    cmp #"R"
    beq routine
    cmp #"S"
    beq spontaneity
    cmp #"L"
    beq logical
    cmp #"E"
    beq emotional
    cmp #"A"
    beq alone
    cmp #"T"
    beq team
    cmp #"P"
    beq planner
    cmp #"G"
    beq flow
    
    rts
    
introverted:
    lda #"You are more introverted and prefer spending time alone."
    jsr print_string
    rts

extroverted:
    lda #"You are more extroverted and enjoy socializing with others."
    jsr print_string
    rts

routine:
    lda #"You prefer routine and structure in your daily life."
    jsr print_string
    rts

spontaneity:
    lda #"You enjoy spontaneity and are always up for new adventures."
    jsr print_string
    rts

logical:
    lda #"You tend to approach situations with logic and reason."
    jsr print_string
    rts

emotional:
    lda #"You make decisions based on your emotions and feelings."
    jsr print_string
    rts

alone:
    lda #"You work best independently and value your personal space."
    jsr print_string
    rts

team:
    lda #"You thrive in collaborative environments and enjoy working with others."
    jsr print_string
    rts

planner:
    lda #"You like to plan ahead and have a clear path for the future."
    jsr print_string
    rts

flow:
    lda #"You prefer to go with the flow and adapt to changing circumstances."
    jsr print_string
    rts

get_response:
    lda #response
    jsr $ffb5 ; GETIN
    rts
