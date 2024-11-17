
PET_START   .text   "HELLO! I AM YOUR VIRTUAL PET."
            .text   "PLEASE TAKE CARE OF ME."

            .text   "1 - FEED"
            .text   "2 - PLAY"
            .text   "3 - SLEEP"
            .text   "9 - EXIT"

            LDA     #0         ; Initialize pet status
            STA     PET_STATUS

PET_LOOP            
            .text   "WHAT WOULD YOU LIKE TO DO?"
            .text   "ENTER YOUR CHOICE: "
            JSR     GET_INPUT
            
            CMP     #'1'       ; Check user input
            BEQ     FEED
            CMP     #'2'
            BEQ     PLAY
            CMP     #'3'
            BEQ     SLEEP
            CMP     #'9'
            BEQ     EXIT

            JMP     PET_LOOP   ; Loop if input is invalid

FEED        
            .text   "YOU FEED YOUR PET."
            INC     PET_STATUS  ; Increase pet status
            JMP     PET_LOOP

PLAY        
            .text   "YOU PLAY WITH YOUR PET."
            INC     PET_STATUS  ; Increase pet status
            JMP     PET_LOOP

SLEEP       
            .text   "YOUR PET GOES TO SLEEP."
            DEC     PET_STATUS  ; Decrease pet status
            JMP     PET_LOOP

EXIT        
            .text   "GOODBYE! THANK YOU FOR TAKING CARE OF YOUR PET."
            RTS

GET_INPUT   
            JSR     $FFBD      ; Input a character
            STA     INPUT
            RTS

PET_STATUS  .byte   0
INPUT       .byte   0

            .org    $C000      ; Start program at address $C000
            JMP     PET_START  ; Start the virtual pet simulation
