
START    LDX #NUM_COUNT      ; Load number of elements into X register
         LDY #NUMBERS         ; Load address of numbers array into Y register
         LDA (Y),Y           ; Load first number into accumulator
         STA CURRENT_LCM     ; Store first number as current LCM
LOOP     INY                  ; Increment Y register to point to next number
         LDA (Y),Y            ; Load next number into accumulator
         JSR CALCULATE_LCM    ; Calculate LCM of accumulator and current LCM
         STA CURRENT_LCM      ; Update current LCM with new value
         DEX                  ; Decrement X register
         BNE LOOP             ; Continue loop until all numbers processed
         RTS                  ; Return from subroutine

CALCULATE_LCM
         PHA                  ; Push accumulator to stack
         LDX CURRENT_LCM+1    ; Load high byte of current LCM into X register
         CMP #0               ; Check if high byte is zero
         BNE DIVIDE           ; If not zero, go to DIVIDE
         LDA CURRENT_LCM      ; Load low byte of current LCM into accumulator
         BEQ UPDATE_LCM       ; If low byte is zero, skip update
         JMP DONE             ; Jump to DONE
DIVIDE   JSR DIVIDE_BY_GCD    ; Divide current LCM by GCD of accumulator and current LCM
UPDATE_LCM
         STA CURRENT_LCM      ; Store new LCM value
         PLA                  ; Pop accumulator from stack
         RTS                  ; Return from subroutine

DIVIDE_BY_GCD
         JSR CALCULATE_GCD    ; Calculate GCD of accumulator and current LCM
         LDX CURRENT_LCM+1    ; Load high byte of current LCM into X register
         CLC                  ; Clear carry flag
         LDA CURRENT_LCM      ; Load low byte of current LCM into accumulator
         SEC                  ; Set carry flag
         SBC #0               ; Subtract result of GCD calculation from low byte of current LCM
         TAY                  ; Transfer result to Y register
         LDA DIVISOR+1        ; Load high byte of divisor into accumulator
         SBC #0               ; Subtract high byte of divisor from result
         STA DIVISOR+1        ; Store new high byte of divisor
         LDA DIVISOR          ; Load low byte of divisor into accumulator
         SBC #0               ; Subtract low byte of divisor from result
         STA DIVISOR          ; Store new low byte of divisor
         LDX #2               ; Reset X register for loop
DIV_LOOP DEY                  ; Decrement Y register
         BPL DIV_LOOP         ; Continue loop until Y is 0
         LDA DIVISOR          ; Load low byte of divisor into accumulator
         ORA DIVISOR+1        ; OR low byte with high byte
         BEQ DONE             ; If result is zero, divisor is 1, jump to DONE
         RTS                  ; Return from subroutine

CALCULATE_GCD
         PHA                  ; Push accumulator to stack
         JSR EUCLIDEAN_GCD    ; Calculate GCD using Euclidean algorithm
         PLA                  ; Pop accumulator from stack
         RTS                  ; Return from subroutine

EUCLIDEAN_GCD
         TAY                  ; Transfer accumulator to Y register
         LDX #2               ; Set X register for loop
E_LOOP   DEA                  ; Decrement accumulator
         BMI DONE             ; If accumulator is negative, jump to DONE
         BNE E_LOOP           ; Continue loop until accumulator is zero
         LDA Y                ; Load Y register into accumulator
         SEC                  ; Set carry flag
         SBC X                ; Subtract X register from accumulator
         BPL E_LOOP           ; Continue loop until result is positive
         TAX                  ; Transfer result to X register
         LDY #0               ; Load 0 into Y register
         LDA X                ; Load X register into accumulator
         STA Y                ; Store accumulator value in Y register
         LDA Y                ; Load Y register into accumulator
         RTS                  ; Return from subroutine

NUM_COUNT .BYTE 3              ; Number of elements in the list
NUMBERS   .BYTE 6, 8, 9        ; List of numbers to calculate LCM
CURRENT_LCM .WORD 1            ; Current LCM value
DIVISOR   .WORD 1              ; Divisor value
