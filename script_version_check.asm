
ORG $0200

LDA #STRING1 ; Load the address of the first string
STA $00
LDA #STRING2 ; Load the address of the second string
STA $01

LDA #$FF ; Set the initial distance counter to -1
STA DISTANCE

LDX #$00 ; Initialize string index to 0
LDY #$00 ; Initialize string index to 0

LOOP:
LDA $00,X ; Load character from first string
CMP #0 ; Check for end of string
BEQ DONE ; If end of string is reached, exit loop
STA CHAR1 ; Store character in CHAR1

LDA $01,X ; Load character from second string
CMP #0 ; Check for end of string
BEQ DONE ; If end of string is reached, exit loop
STA CHAR2 ; Store character in CHAR2

LDX #$00 ; Initialize edit distance counter to 0
CALL EDITDIST ; Calculate edit distance
STA TEMP ; Store result in TEMP

LDA DISTANCE ; Load current distance
CMP #$FF ; Check if initial distance
BEQ NOUPDATE ; If initial distance, no update needed

LDA TEMP ; Load calculated distance
CMP DISTANCE ; Compare with current distance
BCS NOUPDATE ; If greater, don't update
STA DISTANCE ; Update distance

NOUPDATE:
INX ; Increment index for next character
JMP LOOP ; Continue loop

DONE:
BRK ; Exit program

EDITDIST:
LDX #$00 ; Initialize counter to 0
EDITLOOP:
LDA CHAR1,X ; Load character from first string
CMP CHAR2,X ; Compare with character from second string
BEQ SKIP ; If characters are equal, skip
INC TEMP ; Increment distance counter
SKIP:
INX ; Increment index
LDA CHAR1,X ; Load character from first string
CMP #0 ; Check for end of string
BEQ EDITDONE ; If end of string, exit loop
JMP EDITLOOP ; Continue loop

EDITDONE:
RTS

TEMP:
BYTE $00

DISTANCE:
BYTE $FF

CHAR1:
BYTE $00

CHAR2:
BYTE $00

STRING1:
.TEXT "kitten",0

STRING2:
.TEXT "sitting",0

.END
