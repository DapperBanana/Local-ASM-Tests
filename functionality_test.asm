
; Random Password Generator
; Generates a random password of a given length

    .6800
    .var length     $00      ; length of password
    .var password    $01      ; password buffer
    .var count       $0A      ; current count
    
    .const passwordLength = 10  ; length of password to generate

start
    LDX #passwordLength
    STX length              ; store length in memory
    
generateLoop
    LDA #0                  ; clear A
    JSR generateRandom      ; generate random number
    STA password, X         ; store in password buffer
    DEX                     ; decrement length
    BNE generateLoop        ; loop until length is 0
    
    RTS
    
generateRandom
    PHA                     ; save A
    TYA                     ; transfer Y to A
    LDA #83                 ; use 83 as seed
    STA $C3                 ; store seed
    LDA #8                  ; use 8 as multiplier
    STA $C7                 ; store multiplier
    
nextRandom
    JSR LFSR                ; generate random number
    JSR updateSeed          ; update seed
    PLA                     ; restore A
    RTI
    
LFSR
    LDA $C8                 ; load current value
    STA $C6                 ; store in temporary
    LSR $C6                 ; shift right
    EOR $C6                 ; XOR
    EOR $C8                 ; XOR with original value
    STA $C8                 ; store result
    RTS
    
updateSeed
    LDA $C3                 ; load seed
    ADC $C7                 ; add multiplier
    STA $C3                 ; store result
    RTS
