
ORG $0200

; Define the two lists
LIST1    .BYTE $01, $02, $03, $04, $05
LIST1_LEN = * - LIST1

LIST2    .BYTE $03, $04, $05, $06, $07
LIST2_LEN = * - LIST2

; Define buffer to store the intersection
INTERSECTION .BLKW 10

START
    LDX #0               ; Initialize X index to 0
LOOP1
    LDA LIST1, X         ; Load element from LIST1 into A
    STA $FB              ; Store it in a temporary location
    LDX #0               ; Reset X index for inner loop
LOOP2
    LDA LIST2, X         ; Load element from LIST2 into A
    CMP $FB              ; Compare it with the element from LIST1
    BEQ ADD_TO_INTERSECTION ; If they match, add to intersection
    INX                  ; Increment X index for LIST2
    CPX LIST2_LEN        ; Check if reached end of LIST2
    BNE LOOP2            ; If not, continue loop
    INX                  ; Increment X index for LIST1
    CPX LIST1_LEN        ; Check if reached end of LIST1
    BNE LOOP1            ; If not, continue loop

END
    BRK

ADD_TO_INTERSECTION
    LDA $FB              ; Load element from LIST1 into A
    STA INTERSECTION, X  ; Add it to intersection buffer
    INX                  ; Increment index for intersection buffer
    RTS                  

