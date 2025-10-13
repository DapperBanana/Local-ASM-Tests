
ORG $8000

START:
    LDX #$00         ; Initialize X register to 0 (index for source string)
    LDY #$00         ; Initialize Y register to 0 (index for destination string)
    LDA SOURCE,X     ; Load a character from the source string
    BEQ END          ; If the character is null terminator, exit
    CMP #$20         ; Check if the character is a space
    BEQ SKIP         ; Skip spaces
    CMP #$2C         ; Check if the character is a comma
    BEQ SKIP         ; Skip comma
    CMP #$2E         ; Check if the character is a period
    BEQ SKIP         ; Skip period
    CMP #$21         ; Check if the character is an exclamation mark
    BEQ SKIP         ; Skip exclamation mark
    CMP #$3F         ; Check if the character is a question mark
    BEQ SKIP         ; Skip question mark
    STA DEST,Y       ; Store the character in the destination string
    INY              ; Increment Y index
SKIP:
    INX              ; Increment X index
    JMP START        ; Continue looping

END:
    LDA #$00         ; Load null terminator
    STA DEST,Y       ; Store null terminator in the destination string

SOURCE:
    .BYTE 'H','e','l','l','o',',',' ','w','o','r','l','d','!','?','$'
DEST:
    .BLKB $20        ; Allocate 32 bytes for destination string

    END START
