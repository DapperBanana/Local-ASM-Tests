
.inesmirroring 0

.segment "TEXT"
                .null-terminated
welcome_msg:
                .text "Welcome to the Educational Quiz! Answer the following questions to test your knowledge."

question1:
                .text "What is the capital of France?"
answer1:
                .text "Paris"

question2:
                .text "What is the largest planet in our solar system?"
answer2:
                .text "Jupiter"

question3:
                .text "How many continents are there in the world?"
answer3:
                .text "7"

segment "DATA"
questions:
                .addr question1, question2, question3

answers:
                .addr answer1, answer2, answer3

.segment "CODE"
start:
                JSR print_string, welcome_msg

                LDX #0
loop:
                LDA questions, X
                BEQ finish

                JSR print_string, A
                JSR read_string

                LDA answers, X
                CMP A
                BEQ correct

                JSR print_string, wrong_msg

correct:
                LDA #0
                STA temp

                INX
                JMP loop

finish:
                RTS

print_string:
                LDX #0
print_char:
                LDA A, X
                BEQ end_print
                JSR $fcb1
                INX
                JMP print_char

end_print:
                RTS

read_string:
                LDX #0
read_next:
                JSR $ffd8
                CMP #$8D
                BEQ end_read

                STA temp, X
                INX
                JMP read_next

end_read:
                LDX #0
                LDA #0
                STA temp, X
                RTS

wrong_msg:
                .text "Wrong answer. Please try again."

temp:           .res 100

.end
