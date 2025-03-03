
start:
    lda #input_number    ; Load the input number into the accumulator
    jsr is_prime         ; Check if the input number is prime
    beq start            ; If input number is prime, go to next 
    inx                  ; Increment input number
    jmp start            ; Continue checking until prime number is found

is_prime:
    cmp #$02             ; Compare input number with 2
    beq not_prime        ; If input number is 2, not prime

    lda #$02             ; Load divisor into accumulator
loop:
    cmp #$ff             ; Compare divisor with FF
    beq prime            ; If divisor reaches FF, input number is prime

    ldy #$00             ; Load index Y with 0
    jsr divide           ; Divide input number by divisor

    cpy #$00             ; Check if remainder is 0
    beq not_prime        ; If remainder is 0, input number is not prime

    inc divisor          ; Increment divisor
    jmp loop             ; Continue loop

divide:
    tay                  ; Transfer accumulator to Y
    clc                  ; Clear carry flag
    div                 ; Divide A by Y
    rts                  ; Return from subroutine

not_prime:
    rts                  ; Return from subroutine

prime:
    lda #input_number    ; Load input number into accumulator
    jsr print_number     ; Print the prime number
    rts                  ; Return from subroutine

print_number:
    ; Your code to print the number goes here
    rts                  ; Return from subroutine

input_number: .byte $05   ; Change this to your desired input number
divisor: .byte $02        ; Divisor starts at 2

    .org $fffc           ; Define reset vector
    .word start          ; Set reset vector to start address
