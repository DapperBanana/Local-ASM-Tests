
START:  LDX #00      ; Load index X with 0
LOOP:  LDA TEXT,X    ; Load character from text
       CMP #'$'      ; Compare character to end-of-string
       BEQ END       ; Branch to END if end-of-string found
       CMP #'@'      ; Compare character to '@'
       BEQ CHECK     ; Branch to CHECK if '@' found
       INX            ; Increment index X
       BNE LOOP      ; Branch back to LOOP
CHECK: LDA TEXT,X+  ; Load next character
       CMP #'.'      ; Compare character to '.'
       BEQ SAVE      ; Branch to SAVE if '.' found
       CMP #' '      ; Compare character to space
       BEQ LOOP      ; Branch back to LOOP if space found
       BNE INX       ; Branch back to INX if no match
SAVE:  STA EMAILADD,X  ; Save character to email address
       INX           ; Increment index X
       BNE LOOP      ; Branch back to LOOP
END:   BRK           ; Exit program

TEXT:  .string "This is my email address: test@example.com$"
EMAILADD: .block 50   ; Email address buffer
