
; Program to generate a random password of given length

; Input: X register contains the desired length of the password
; Output: Password is stored in memory starting at $1000

    .org $1000  ; Start of memory for password
    
start:
    LDX #$00     ; Initialize index
    LDA #$41     ; ASCII character 'A' (start of printable characters)
    
loop:
    LSR          ; Shift right to generate random byte
    ROR
    ROR
    ROR
    
    CMP #$5B     ; Check if random byte is greater than 'Z'
    BCS loop     ; If yes, generate another random byte
    
    STA $1000,X ; Store random byte in memory
    INX          ; Increment index
    INY          ; Increment Y register to simulate random
    
    CPX       ; Check if the desired length has been reached
    BNE loop  ; If not, generate another byte
    
    BRK       ; End program

    .org $FFFC    ; Reset vector
    .word start   ; Point to the start of the program
