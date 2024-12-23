
        ; 6502 Assembly Quiz Program
        
        ; Load the first question into memory
        LDA #<Question1
        STA $2000
        LDA #>Question1
        STA $2001
        
        ; Load the answers into memory
        LDA #<Answer1
        STA $2002
        LDA #>Answer1
        STA $2003
        LDA #<Answer2
        STA $2004
        LDA #>Answer2
        STA $2005
        LDA #<Answer3
        STA $2006
        LDA #>Answer3
        STA $2007
        
loop:   ; Display the question
        LDA $2000
        JSR $FFD2   ; Output character
        
        LDA $2001
        JSR $FFD2   ; Output character
        
        ; Display the answers
        LDA $2002
        JSR $FFD2   ; Output character
        
        LDA $2003
        JSR $FFD2   ; Output character

        LDA $2004
        JSR $FFD2   ; Output character
        
        LDA $2005
        JSR $FFD2   ; Output character

        LDA $2006
        JSR $FFD2   ; Output character
        
        LDA $2007
        JSR $FFD2   ; Output character
        
        ; Get user input
        LDA $FF00   ; Read key input
        CMP #65     ; Check if it's 'A' answer
        BEQ correct_answer
        CMP #66     ; Check if it's 'B' answer
        BEQ wrong_answer
        CMP #67     ; Check if it's 'C' answer
        BEQ wrong_answer
        
        BRA loop   ; Keep asking questions
        
correct_answer:
        ; Display message for correct answer
        LDA #<CorrectMessage
        STA $2000
        LDA #>CorrectMessage
        STA $2001
        JMP loop

wrong_answer:
        ; Display message for wrong answer
        LDA #<WrongMessage
        STA $2000
        LDA #>WrongMessage
        STA $2001
        JMP loop
        
        ; Data section
Question1: .asciiz "What is the capital of France?"
Answer1: .asciiz "A) London"
Answer2: .asciiz "B) Paris"
Answer3: .asciiz "C) Berlin"
CorrectMessage: .asciiz "Correct! Well done."
WrongMessage: .asciiz "Wrong answer. Try again."
