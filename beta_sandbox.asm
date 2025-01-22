
; Virtual Pet Program

.petHunger  = $00
.petHappiness = $01
.petStatus = $02
.petDeath = $03

.petDeadMessage = "Your pet has died. Game over."

.org $1000

    LDX #0                  ; Initialize pet hunger
    STX .petHunger
    
    LDX #50                 ; Initialize pet happiness
    STX .petHappiness
    
    LDX #0                  ; Initialize pet status (alive)
    STX .petStatus
    
start:
    JSR displayStats        ; Display pet stats
    JSR getInput             ; Get user input
    JSR updatePet            ; Update pet stats
    JMP start

displayStats:
    LDA .petHunger
    STA $0400               ; Display hunger value
    
    LDA .petHappiness
    STA $0401               ; Display happiness value
    
    LDA .petStatus
    BEQ petDead
    
    RTS
    
petDead:
    LDX #0
    LDA .petDeadMessage,X
    JSR $FFD2               ; Print dead message
    RTS

getInput:
    JSR $FFCF               ; Get user input
    CMP #72                 ; Check if key pressed is 'H'
    BEQ feedPet
    CMP #74                 ; Check if key pressed is 'J'
    BEQ playWithPet
    RTS
    
feedPet:
    LDA .petHunger
    SEC
    SBC #10                 ; Decrease hunger by 10
    STA .petHunger
    
    RTS
    
playWithPet:
    LDA .petHappiness
    CLC
    ADC #10                 ; Increase happiness by 10
    STA .petHappiness
    
    RTS
    
updatePet:
    LDA .petHunger
    CMP #100                ; Check if hunger is at max
    BNE checkHappiness
    
    LDX #1
    STX .petStatus          ; Mark pet as dead
    
    RTS
    
checkHappiness:
    LDA .petHappiness
    CMP #100                ; Check if happiness is at max
    BNE RTS
    
    LDX #1
    STX .petStatus          ; Mark pet as dead
    
    RTS

EndProgram:
    BRK
    
    .end
