
    .org    $1000
    
start:
    lda     #$00        ; Initialize random number generator seed
    sta     $D020
    ldx     #$FF        ; Initialize index for password generation loop
loop:
    lda     $D404       ; Get a random byte from SID noise generator
    and     #$1F        ; Mask out upper bits to limit range to 0-31
    cmp     #$0A        ; Check if it's a valid alphanumeric character
    bcc     loop        ; If not, generate a new random byte
    adc     #$30        ; Convert random byte to ASCII character
    sta     password,x  ; Store character in password buffer
    dex
    bpl     loop        ; Continue generating password until buffer is filled
    
    lda     #$00
    sta     $D000       ; Reset the VIC-II chip to display password
    ldx     #$FF
print:
    lda     password,x   ; Print password character
    jsr     $FFD2       ; Output character to screen
    dex
    bpl     print       ; Continue printing characters until all are printed
    
    lda     #$FF
loop1:
    bit     $DD00       ; Wait for user input
    bpl     loop1
    
    lda     #$00        ; Clear screen
    jsr     $FFCC
    
    jmp     start       ; Restart the program
    
    .block  $D020,$D404,$D000,$DD00
    .block  password
    
    .org    $01FF
    .block  $FFD2,$FFCC
