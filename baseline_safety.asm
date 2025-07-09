
.INCLUDE "6502.inc"

; Constants
MAX_ITEMS = 10
ITEM_SIZE = 2

; Variables
.inventory        .BLKW MAX_ITEMS * ITEM_SIZE
.num_items        .DSB 1

; Entry point
          .ORG $0200
          LDX #$00          ; Initialize index to 0
          STX num_items     ; Set number of items to 0
          JSR display_menu  ; Display the main menu

main_loop:
          JSR read_input    ; Read user input
          CMP #1            ; Compare input to 1 (Add item)
          BEQ add_item      ; Branch if equal
          CMP #2            ; Compare input to 2 (Remove item)
          BEQ remove_item   ; Branch if equal
          CMP #3            ; Compare input to 3 (List inventory)
          BEQ list_inventory ; Branch if equal
          CMP #4            ; Compare input to 4 (Exit)
          BEQ exit_program   ; Branch if equal
          JMP main_loop

add_item:
          JSR read_input    ; Read item number
          STA ,X            ; Store item number in inventory
          INX               ; Increment index
          JSR read_input    ; Read item quantity
          STA ,X            ; Store item quantity in inventory
          INX               ; Increment index
          INC num_items      ; Increment number of items
          JMP main_loop

remove_item:
          JSR read_input    ; Read item number to remove
          LDX #$00
compare_loop:
          CMP ,X            ; Compare item number
          BEQ found_item    ; Branch if equal
          INX               ; Increment index
          BNE compare_loop   ; Branch never
found_item:
          LDA num_items
          DEX               ; Decrement index
          BEQ remove_item_end ; Branch if equal
move_items:
          LDA ,X            ; Load next item number
          STA ,-X
          LDA ,X            ; Load next item quantity
          STA ,-X
          DEX               ; Decrement index
          DEX               ; Decrement index
          DEC num_items      ; Decrement number of items
remove_item_end:
          JMP main_loop

list_inventory:
          LDX #$00
list_loop:
          LDA ,X            ; Load item number
          JSR output_number ; Output item number
          INX               ; Increment index
          LDA ,X            ; Load item quantity
          JSR output_number ; Output item quantity
          INX               ; Increment index
          CPX num_items      ; Compare index to number of items
          BNE list_loop      ; Branch not equal
          JMP main_loop

exit_program:
          BRK

; Subroutines

read_input:
          LDX #$00
input_loop:
          LDA #$00
          JSR input_char
          CMP #$0D           ; Compare input to Enter key
          BEQ input_end      ; Branch if equal
          CMP #$30           ; Compare input to '0'
          BLT input_loop      ; Branch if less than
          CMP #$39           ; Compare input to '9'
          BGT input_loop      ; Branch greater than
          ASL A              ; Shift left to multiply by 2
          ASL A              ; Shift left to multiply by 4
          ASL A              ; Shift left to multiply by 8
          ADC #$F0           ; Add offset for number conversion
          STA ,X             ; Store input in memory
          INX                ; Increment index
          JMP input_loop

input_end:
          RTS

output_number:
          LSR A              ; Shift right to divide by 2
          LSR A              ; Shift right to divide by 4
          LSR A              ; Shift right to divide by 8
          AND #$0F           ; Mask upper nybble
          ADC #$30           ; Add offset for ASCII conversion
          STA ,OUTPUT        ; Output character
          INC OUTPUT         ; Increment output pointer
          RTS

; Data

OUTPUT    .DSB 1

          .END
