
        .org $0200

START   LDA #0            ; Load accumulator with 0
        STA $F0           ; Clear memory location F0 for input buffer
        LDA #$FF          ; Load accumulator with FF
        STA $F1           ; Clear memory location F1 for message buffer
        
INPUT   LDA $F0           ; Load input buffer
        CMP #13           ; Compare with carriage return
        BEQ PROCESS       ; If carriage return is pressed, process input
        JSR $FFD2         ; Input from keyboard
        STA $F0           ; Save input in input buffer
        JMP INPUT         ; Continue input loop

PROCESS LDX #$01          ; Load X register with 1
LOOP    LDA $F1,X         ; Load character from message buffer
        BEQ DISPLAY       ; If end of message, display it
        JSR $FFD2         ; Output to screen
        INX               ; Increment X register
        JMP LOOP          ; Continue looping
       
DISPLAY LDA #$00          ; Load accumulator with 0
        STA $F1           ; Clear message buffer
        
        LDA #"Hello, how can I assist you?"  ; Load message into accumulator
        JSR ADDMSG         ; Add message to message buffer
        
        LDA $F0           ; Load input buffer
        JSR ADDMSG         ; Add input to message buffer
        
        LDA #"Sorry, I don't understand."    ; Load message into accumulator
        JSR ADDMSG         ; Add message to message buffer
        
        JMP INPUT         ; Continue input loop

ADDMSG  STA $F1,X         ; Store message in message buffer
        INX               ; Increment X register
        RTS               ; Return from subroutine
  
        .end
