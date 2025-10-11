
    .org $0200
RESET:
    lda #$00
    sta $07F8  ; Set stack pointer
    sei        ; Disable interrupts
    cld        ; Clear decimal mode
    lda #$00
    sta $400 ;clear X register
    sta $401 ;clear Y register
    lda #$FF
    sta $600 ;pointer to screen start
    sty $401
    stx $600
    lda #< SCREEN
    sta $600
    lda #> SCREEN
    sta $601
    lda #SCREEN_LENGTH-1
    sta $7FF
    ldx #$60    ; X = $60
    clr_scr:
         lda #$20   ; space character
         sta $600, X    ; store the space character in the screen
         dex      ; decrease X by 1
         bpl clr_scren   ; branch if result is not negative
    ldx #$00
    sed
    lda #$FF
    sta $2002
    lda #$00
    sta $2003
    lda #$20     ; end of screen in vic, $20 = 32
    sty $d016
    lda #$12
    sta $d011
    lda #$7f
    sta $d012
    lda #$3F
    sta $d018
Prompt:
    ldx #$00
    ldy #$08
    lda #$00
    jsr print
    lda #$42 ;B
    jsr print
    lda #$41 ;A
    jsr print
    lda #$53
    jsr print
    lda #$49
    jsr print
    lda #$43
    jsr print
    lda #$20
    jsr print
    lda #$54
    jsr print
    lda #$45
    jsr print
    lda #$58
    jsr print
    lda #$54
    jsr print
    lda #$20
    jsr print
    lda #$53
    jsr print
    lda #$50
    jsr print
    lda #$41
    jsr print
    lda #$43
    jsr print
    lda #$45
    lda #<DATA_PROMPT
    jsr print_text
    lda #>DATA_PROMPT
    jsr print_text
    lda #10
    jsr get_char
    lda $300 ;user input
    ldx #$00
    cpx #13 ; enter key
    beq Prompt
    ldy #$08
    lda $300
    jsr print
    ldy #$09
    lda #$20
    jsr print
        
        
        jmp Prompt ; wait for something
DATA_PROMPT: .byte "Enter a direction to explore (N, S, E, W):"
SCREEN:    .byte "Welcome to the space exploration game!"
SCREEN_LENGTH = * - SCREEN


print_byte:
        .org $FFD2
        rts

print:
        sta $2000 ;data register, set screen
        stx $2001 ;screen, default
        stx $2001 ; control register, control registers 
        stx $2001 ; control registers, default
        lda #8
        sta $2000 ; default
print_loop:
        ldx #$01
        jsr print_byte
        dex
        beq print_loop ; ends loop
        rts
print_text:
        jsr print_byte
        lda (ptr), y  ; pointer to string;
        beq end_print_text  ; branch if no more content
        jsr print
        iny
        iny
        bra print_text  ; ends loop
end_print_text:
        rts
    
get_char:
        lda #'$00' ;block until a key is ready
        jsr $FFE4 ; get key
        sta $300    ; store user input
        rts

