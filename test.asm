
    .org $0200

reset:
    ; Set up stack
    LDX #$FF
    TXS
    
    ; Start of chatbot program
    LDY #$00 ; Initialize counter for conversation loop
    
conversation_loop:
    ; Greet user
    LDX #$00
    ; Load message address into address register
    LDA greet_message,X
    STA $02
    INX
    LDA greet_message,X
    STA $03
    ; Print message
    JSR print_message
    
    ; Receive user input
    JSR receive_input
    
    ; Respond to user
    LDX #$00
    ; Load response address into address register
    LDA responses,Y,X
    STA $02
    INX
    LDA responses,Y,X
    STA $03
    ; Print response
    JSR print_message
    
    ; Increment counter
    INY
    
    ; Check if conversation is over
    CPY #num_responses
    BCC conversation_loop
    
    ; End program
    BRK
    
print_message:
    LDA $02
    JSR $FFD2 ; Print character in A register
    LDA $03
    JSR $FFD2 ; Print character in A register
    RTS
    
receive_input:
    JSR $FFCF ; Get user input
    RTS
    
; Data section
greet_message:
    .text "Hello! How are you today?"
    .byte $00
    
responses:
    .text "I'm doing great, thank you for asking!"
    .byte $00
    .text "Not too bad, could be better."
    .byte $00
    .text "I'm not feeling well."
    .byte $00
    
num_responses = (* - responses) / 2
    
    .end
