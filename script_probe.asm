
    .org $1000
    .block
start:
    lda #0
    sta $d020 ; Clear screen
    lda #$d0
    sta $d021 ; Set background color to white

    lda #<msg1
    sta $fb
    lda #>msg1
    sta $fc

    lda #<msg2
    sta $ee
    lda #>msg2
    sta $ef

    lda #<msg3
    sta $e0
    lda #>msg3
    sta $e1

    lda #$9c
    sta $d800
    jsr $ffc5 ; Kernal routine to print string
    jsr $ffd2 ; Kernal routine to get key
    cmp #65
    beq reset ; If 'A' key pressed, reset screen
    rts

reset:
    jsr $fb
    lda #$9c
    sta $d800
    lda $fb
    sta $0840
    lda $fc
    sta $0841
    lda $ee
    sta $0842
    lda $ef
    sta $0843
    lda $e0
    sta $0844
    lda $e1
    sta $0845
    rts

msg1:   .text "Welcome to Social Simulator! Press any key to continue."
msg2:   .text "This is a basic text-based social media platform."
msg3:   .text "Press 'A' to reset the screen."
