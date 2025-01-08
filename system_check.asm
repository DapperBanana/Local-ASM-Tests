
        .org $0600

chatbot:
        LDX #0                      ; Initialize index for messages
        LDA #0                      ; Initialize user input
        STA input
loop:
        LDX #0                      ; Reset index for messages
        
        ; Print chatbot prompt
        LDA #<chatPrompt
        STA $FC                     ; Load address of chatPrompt into $FC
        LDA #>chatPrompt
        STA $FD
        JSR $FFEF                   ; Call monitor routine to print message
        
        ; Get user input
        JSR $FFDA                   ; Call monitor routine to get user input
        
        ; Check user input for specific greetings
        LDA input
        CMP #<hello
        BNE notHello
        LDA input+1
        CMP #>hello
        BEQ helloResponse
        
notHello:
        CMP #<howAreYou
        BNE notHow
        LDA input+1
        CMP #>howAreYou
        BEQ howAreYouResponse
        
notHow:
        CMP #<bye
        BNE notBye
        LDA input+1
        CMP #>bye
        BEQ byeResponse
        
notBye:
        JSR $FFEF                   ; Print generic response
        BRA loop                    ; Repeat chatbot loop

helloResponse:
        LDA #<helloResponse
        STA $FC
        LDA #>helloResponse
        STA $FD
        JSR $FFEF
        BRA loop

howAreYouResponse:
        LDA #<howAreYouResponse
        STA $FC
        LDA #>howAreYouResponse
        STA $FD
        JSR $FFEF
        BRA loop

byeResponse:
        LDA #<byeResponse
        STA $FC
        LDA #>byeResponse
        STA $FD
        JSR $FFEF
        RTS

input:  .byte 0
chatPrompt: .asciiz "Say something: "
hello:  .asciiz "hello"
helloResponse: .asciiz "Hello! Nice to meet you."
howAreYou: .asciiz "how are you"
howAreYouResponse: .asciiz "I'm just a chatbot, so I'm doing fine."
bye: .asciiz "bye"
byeResponse: .asciiz "Goodbye! Have a great day."

        .end
