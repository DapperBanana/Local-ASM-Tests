
; Blackjack Game

; Define constants
SCREENOUT = $FD00      ; Output screen location
SCREENIN = $FF00       ; Input screen location

; Define variables
player_hand    .byte 0
dealer_hand    .byte 0
player_score   .byte 0
dealer_score   .byte 0
card_index     .byte 0
card_deck      .byte $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D

; Entry point
start
    LDA #<player_hand
    STA $03
    LDA #>player_hand
    STA $04

    LDA #<dealer_hand
    STA $05
    LDA #>dealer_hand
    STA $06

    JSR init_deck
    JSR deal_card
    JSR deal_card

    JSR player_turn
    JSR dealer_turn

    JSR check_winner

    RTS

init_deck
    LDA #0
    STA card_index
    RTS

deal_card
    LDA card_index
    CLC
    ADC #1
    STA card_index

    LDA card_deck, X
    STA $00
    LDY #0
    LDX $03
    STY (X), Y
    RTS

player_turn
    LDA #0
    STA player_score

player_turn_loop
    JSR print_hand player
    JSR print_score player

    LDA #0
    STA $00
    STA $01
    JSR get_player_input

    CMP #0
    BEQ player_turn_loop

    CMP #1
    BEQ dealer_turn

    CMP #2
    BEQ check_winner

    RTS

dealer_turn
    LDA #0
    STA dealer_score

    dealer_turn_loop
    JSR print_hand dealer
    JSR print_score dealer

    JSR generate_dealer_move

    LDX $05
    LDA (X), Y
    STA $00
    JSR get_player_input

    CMP #1
    BEQ dealer_turn_loop

    JSR check_winner

    RTS

generate_dealer_move
    LDA dealer_score
    CMP #16
    BCS generate_dealer_move_done

    JSR deal_card
    JSR add_card_to_hand dealer

    JMP generate_dealer_move

generate_dealer_move_done
    RTS

check_winner
    JSR print_hand player
    JSR print_hand dealer

    LDA player_score
    CMP dealer_score

    BEQ no_winner

    LDA player_score
    CMP dealer_score
    BGT player_wins

    LDA dealer_score
    CMP player_score
    BGT dealer_wins

no_winner
    JSR print_string "No winner"

    RTS

player_wins
    JSR print_string "Player wins"

    RTS

dealer_wins
    JSR print_string "Dealer wins"

    RTS

add_card_to_hand
    CLC
    LDX $03
    INX
    STX $03
    STX $04

    LDA #1
    SEC
    SBC #10
    INX
    STX (X), Y

    RTS

print_hand
    LDX $03
    TXA
    STA $00
    LDA #0

print_hand_loop
    LDA (X), Y
    BEQ print_hand_done

    STA $02
    JSR print_card
    INY

    JMP print_hand_loop

print_hand_done
    RTS

print_card
    LRA #SCREENOUT
    LDX $02
    LDA (X), Y
    STA SCREENOUT
    RTS

print_score
    LDA SCREENOUT
    STA $01
    LDA #SCREENOUT + $10
    STA SCREENOUT

    LRA $01
    RTS

print_string
    LDX #0
print_string_loop
    LDA (X), Y
    BEQ print_string_done

    JSR print_card
    INX

    JMP print_string_loop

print_string_done
    RTS

get_player_input
    LDX #SCREENIN
    LDA #0
    STA SCREENIN
    STA SCREENIN

waiting_for_input
    LDA SCREENIN
    CMP #0
    BEQ waiting_for_input

    LDA SCREENIN
    RTS
