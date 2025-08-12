
ORG $2000

LDA #<input_text   ; Load low byte of address of input text
LDX #>input_text   ; Load high byte of address of input text
LDY #0             ; Initialize Y register to store hashtag count
LDX #0             ; Initialize X register to store current character position
LDY #0             ; Initialize Y register to store current hashtag position

check_next_character:
LDA (X),Y          ; Load next character from input text
CMP #' '           ; Check if it's a space character
BEQ increment_position ; If it's a space character, move to the next character

CMP #'#'           ; Check if it's a hashtag character
BNE increment_position ; If it's not a hashtag character, move to the next character

STA $3000,Y        ; Store current hashtag in memory at address $3000
INY                ; Increment Y to account for new hashtag
LDA (X),Y          ; Load next character from input text
CMP #' '           ; Check if it's a space character
BEQ increment_position ; If it's a space character, move to the next character

increment_position:
INX                ; Increment X to move to the next character
BRA check_next_character ; Repeat the process for the next character

input_text:
.string "This is a #sample text with #hashtags #included."

.END
