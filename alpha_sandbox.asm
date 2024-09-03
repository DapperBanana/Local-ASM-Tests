
LDA #0
STA input_buffer

load_movie:
    LDX #0
    LDA movie_data, X
    CMP #0
    BEQ end_program

    JSR print_string      ; Print movie name
    JSR get_user_input     ; Get user input
    CMP #89               ; Check if user input is 'Y'
    BEQ print_recommendation

    INX
    JMP load_movie

print_recommendation:
    JSR print_string recomm_string
    JSR print_string
    JSR print_string recomm_movie

    JMP load_movie

end_program:
    BRK

print_string:
    LDY #0
    LDA input_buffer, Y
    BEQ end_print
    JSR $ffd2
    INY
    JMP print_string

end_print:
    RTS

get_user_input:
    JSR $ffd2
    STA input_buffer
    RTS

input_buffer:
    .BYTE 0
    .BYTE 0

movie_data:
    .BYTE "Titanic", 0
    .BYTE "The Shawshank Redemption", 0
    .BYTE "The Godfather", 0
    .BYTE "Inception", 0
    .BYTE 0

recomm_string:
    .BYTE "Would you like to watch this movie? (Y/N): ", 0

recomm_movie:
    .BYTE "Great choice! Enjoy the movie!", 0
