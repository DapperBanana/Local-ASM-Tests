
LDA #0
STA player_score
STA dealer_score

start:
  JSR display_menu
  JSR deal_cards
  
player_turn:
  JSR display_player_hand
  JSR player_action
  JSR evaluate_player_hand
  BEQ dealer_turn

dealer_turn:
  JSR display_dealer_hand
  JSR evaluate_dealer_hand
  JSR decide_winner
  JSR restart_game

display_menu:
  LDX #0
  LDA menu_text,X
  JSR print_string
  RTS

deal_cards:
  LDX #0
  LDA #0
  JSR randomize
  STA player_hand,X
  INX
  JSR randomize
  STA player_hand,X
  INX
  JSR randomize
  STA dealer_hand,X
  INX
  JSR randomize
  STA dealer_hand,X
  RTS

display_player_hand:
  LDX #0
  LDA player_score
  STA temp_score
  LDA #5
  STA num_cards
  LDA player_hand,X
  JSR print_card
  INX
  LDA player_hand,X
  JSR print_card
  INX
  LDA temp_score
  JSR print_score
  RTS

player_action:
  LDA #0
  STA action
  LDA #0
  STA temp_score
  LDX #0
  LDA player_score
  CMP #21
  BEQ player_stand
  JSR display_player_menu
  BEQ player_action
  LDA action
  CMP #1
  BEQ player_hit
  CMP #2
  BEQ player_stand
  BRA player_action

player_hit:
  JSR randomize
  STA player_hand,X
  INX
  JSR display_player_hand
  RTS

player_stand:
  RTS

display_player_menu:
  LDX #0
  LDA player_menu_text,X
  JSR print_string
  LDA input
  CLC
  ADC #$D0
  CMP #$D2
  BCS invalid_input
  SEC
  SBC #$D0
  STA action
  RTS

evaluate_player_hand:
  LDX #0
  LDA #0
  STA player_score
  LDA player_hand,X
  JSR calculate_score
  STA temp_score
next_card:
  INX
  LDA player_hand,X
  BEQ check_bust
  JSR calculate_score
  CMP #0
  BEQ next_card
  CLC
  ADC temp_score
  STA temp_score
  BRA next_card

calculate_score:
  CMP #$01
  BEQ ace_check
  CMP #$0A
  BCS face_card_check
  CLC
  ADC player_score
  STA player_score
  RTS
  
face_card_check:
  LDA #$09
  CLC
  ADC player_score
  STA player_score
  RTS

ace_check:
  LDA player_score
  CMP #10
  BCS ace_low
  LDA #$11
  CLC
  ADC player_score
  STA player_score
  RTS
  
ace_low:
  LDA #$01
  CLC
  ADC player_score
  STA player_score
  RTS

check_bust:
  LDA player_score
  CMP #21
  BCC not_busted
  JMP player_busted

not_busted:
  RTS

display_dealer_hand:
  LDX #0
  LDA dealer_score
  STA temp_score
  LDA #5
  STA num_cards
  LDA dealer_hand,X
  JSR print_card_hidden
  INX
  LDA dealer_hand,X
  JSR print_card
  INX
  LDA temp_score
  JSR print_score
  RTS

evaluate_dealer_hand:
  LDX #0
  LDA #0
  STA dealer_score
  LDA dealer_hand,X
  JSR calculate_score
  STA temp_score
next_card_dealer:
  INX
  LDA dealer_hand,X
  BEQ check_bust_dealer
  JSR calculate_score
  CMP #0
  BEQ next_card_dealer
  CLC
  ADC temp_score
  STA temp_score
  BRA next_card_dealer

check_bust_dealer:
  LDA dealer_score
  CMP #17
  BCS dealer_stand
  JMP dealer_hit

dealer_stand:
  RTS

dealer_hit:
  JSR randomize
  STA dealer_hand,X
  INX
  JSR display_dealer_hand
  RTS

decide_winner:
  LDA player_score
  CMP dealer_score
  BEQ push
  BCS player_win
  JMP dealer_win

push:
  LDX #0
  LDA push_text,X
  JSR print_string
  JMP restart_game

player_win:
  LDX #0
  LDA player_win_text,X
  JSR print_string
  JMP restart_game

dealer_win:
  LDX #0
  LDA dealer_win_text,X
  JSR print_string
  JMP restart_game

restart_game:
  LDX #0
  LDA continue_text,X
  JSR print_string
  RTS

print_card:
  TAX
  LDA card_values,X
  JSR print_char
  LDA card_suits,X
  JSR print_char
  RTS

print_card_hidden:
  LDA #$03
  JSR print_char
  JSR print_char
  RTS

print_score:
  TAX
  LDA score_text,X
  JSR print_string
  LDA #0
  JSR print_char
  RTS

print_string:
  STA temp_char
next_char:
  LDA temp_char,X
  BEQ end_print
  JSR print_char
  INX
  BRA next_char
end_print:
  RTS

print_char:
  STA $D010
  LDA #$FF
  STA $D011
  RTS

randomize:
  LDA random_seed
  ASL
  ROL random_seed
  STA random_value
  LDA random_value
  RTS

menu_text: .byte "1. Play Blackjack", $0D, $0A, "2. Quit", $0D, $0A, "Enter option: $"
player_menu_text: .byte "1. Hit", $0D, $0A, "2. Stand", $0D, $0A, "Enter action: $"
card_values: .byte "A23456789TJQK"
card_suits: .byte "CDHS"
score_text: .byte "Score: $"
push_text: .byte "Push, nobody wins!", $0D, $0A
player_win_text: .byte "You win!", $0D, $0A
dealer_win_text: .byte "Dealer wins!", $0D, $0A
continue_text: .byte "Press any key to play again...", $0D, $0A

player_hand: .byte 0, 0
dealer_hand: .byte 0, 0
player_score: .byte 0
dealer_score: .byte 0
action: .byte 0
dealer_value: .byte 0
player_value: .byte 0
temp_score: .byte 0
random_seed: .byte 123
random_value: .byte 0
num_cards: .byte 0

