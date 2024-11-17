
ORG $1000

START LDX #$00    ; Initialize sum to 0
LDY #$00

LOOP LDA NUM,Y    ; Load the number at index Y
BEQ CHECK_SUM    ; Branch to check sum if the number is 0

PHA              ; Push the number to the stack
TYA              ; Transfer Y to Accumulator
JSR MULTIPLY     ; Call the MULTIPLY subroutine
PLA              ; Pull the number from the stack

INX              ; Increment X (loop counter)
INY              ; Increment Y (index counter)
BNE LOOP         ; Loop back to load next number

CHECK_SUM CMP SUM,X ; Compare the sum with the original number
BEQ IS_NARCISSISTIC ; Branch to IS_NARCISSISTIC if they are equal

NOT_NARCISSISTIC BRK ; Stop program if the number is not a narcissistic number

IS_NARCISSISTIC BRK ; Stop program and indicate that the number is a narcissistic number

MULTIPLY CLC          ; Clear carry flag
ADC NUM,Y            ; Add the number to the sum
STZ TEMP             ; Clear TEMP for storing the result
LDX #$00             ; Initialize index X to 0

MUL_LOOP LDA #$00    ; Initialize accumulator to 0
ADC SUM,X            ; Add current sum to accumulator
STA TEMP             ; Store the result in TEMP
LDA TEMP+1           ; Load the carry from the previous addition
ADC #$00             ; Add it to accumulator
STA TEMP+1           ; Store the result in TEMP+1
INX                  ; Increment index
INY                  ; Increment index
CPY #$00             ; Check if we have reached the end
BNE MUL_LOOP         ; Loop back if not
RTS

NUM     .BYTE $05, $13, $02, $10, $00     ; Sample input number
SUM     .DS  2                             ; Variable to store the sum
TEMP    .DS  2                             ; Temporary variable for multiplication

END START
