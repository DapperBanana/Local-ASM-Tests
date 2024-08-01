
        .org $0200

LIST1   .byte $01, $02, $03, $04, $05
LIST2   .byte $03, $04, $05, $06, $07
INTERSECTION   .byte 5             ; Maximum size of intersection list

START
        LDX #0                     ; Initialize index for LIST1
LOOP1   LDA LIST1, X               ; Load element from LIST1
        STX TEMP                   ; Save index for comparison later
        LDX #0                     ; Initialize index for LIST2
LOOP2   LDA LIST2, X               ; Load element from LIST2
        CMP TEMP                   ; Compare with element from LIST1
        BEQ ADD_INTERSECTION       ; If match, add to intersection list
        INX                        ; Move to next element in LIST2
        CPX #INTERSECTION          ; Check if reached max size of intersection list
        BNE LOOP2                  ; If not, continue with LIST2
        INX                        ; Increment index for LIST1
        CPX #5                     ; Check if reached end of LIST1
        BNE LOOP1                  ; If not, continue with LIST1

STOP    BRK                         ; Stop program execution

ADD_INTERSECTION
        STA INTERSECTION, X         ; Add intersecting element to intersection list
        INX
        RTS

TEMP    .byte 0                     ; Temporary storage for index
        .end
