
        .text
        .globl _start
        
_start:
        lda #$00             ; Initialize sum to 0
        ldx #$05             ; Start loop for 5 digits
digit_loop:
        lda number, x       ; Load digit from number
        clc
        adc sum             ; Add digit to sum
        sta sum             ; Store new sum
        dex
        bpl digit_loop
        
        lda sum              ; Check if sum is equal to number
        cmp number
        beq is_perfect       ; Branch if sum is equal to number
        
not_perfect:
        lda #$00             ; Load 0 into register a
        sta $4000            ; Store 0 into address 4000
        lda #$01             ; Load 1 into register a
        sta $4001            ; Store 1 into address 4001
        lda #$00             ; Load 0 into register a
        sta $4002            ; Store 0 into address 4002
        brk                  ; Exit program

is_perfect:
        lda #$01             ; Load 1 into register a
        sta $4000            ; Store 1 into address 4000
        lda #$00             ; Load 0 into register a
        sta $4001            ; Store 0 into address 4001
        lda #$00             ; Load 0 into register a
        sta $4002            ; Store 0 into address 4002
        brk                  ; Exit program
        
        .data
number: .byte $01, $23, $45, $67, $89  ; Number to check (12345)
sum:    .byte $00                       ; Variable to store sum
