
START    ORG    $1000

         LDX	  #1           ; Set starting month to January
         LDY    #1           ; Set starting day to 1
         
PRINT_LOOP
         LDA    MONTHS,X     ; Load current month name
         JSR    PRINT_STRING ; Print month name
         LDA    #' '         ; Load space character
         JSR    PRINT_CHAR   ; Print space
         LDA    #','
         JSR    PRINT_CHAR
         LDA    #' '
         JSR    PRINT_CHAR
         LDX    #0
         
DAY_LOOP
         LDA    DAYS,X       ; Load current day name
         JSR    PRINT_STRING ; Print day name
         LDA    #' '         ; Load space character
         JSR    PRINT_CHAR   ; Print space
         INX                 ; Increment day counter
         CPX    #7           ; Check if end of week
         BEQ    NEWLINE      ; If end of week, start new line
         
         LDA    #','
         JSR    PRINT_CHAR
         LDA    #' '
         JSR    PRINT_CHAR
         JMP    DAY_LOOP     ; Continue printing days
        
NEWLINE  LDA    #13          ; Load carriage return
         JSR    PRINT_CHAR   ; Print carriage return
         LDA    #10          ; Load line feed
         JSR    PRINT_CHAR   ; Print line feed
         LDA    #0           ; Load null terminator
         JSR    PRINT_CHAR   ; Print null terminator
         
         INY                 ; Increment month counter
         CPY    #12          ; Check if end of year
         BNE    NEXT_MONTH   ; If not end of year, continue to next month
         
         RTS                 ; End program if end of year
        
NEXT_MONTH
         LDA    #','
         JSR    PRINT_CHAR
         LDA    #' '
         JSR    PRINT_CHAR
         INX                 ; Increment month counter
         JMP    PRINT_LOOP   ; Continue to next month

PRINT_STRING
         STA    $2000,X      ; Store character in output buffer
         INX                 ; Increment buffer index
         RTS

PRINT_CHAR
         JSR    PRINT_STRING ; Print single character
         RTS

MONTHS   .BYTE  'January','February','March','April','May','June','July','August','September','October','November','December'
DAYS     .BYTE  'Sun','Mon','Tue','Wed','Thu','Fri','Sat'

         ORG    $2000
OUTPUT   .BLKB  20            ; Output buffer

         RTS

         END    START
