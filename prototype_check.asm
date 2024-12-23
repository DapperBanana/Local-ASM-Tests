
.INCLUDE "6502.mac"

; Constants
INVENTORY_SIZE = 10

; Memory locations
INVENTORY_START = $0200
CURRENT_ITEM = $FE
COMMAND = $FF

    .ORG $0200

inventory:
    .BLOCK INVENTORY_SIZE

    .ORG $FFFC
    .WORD start

start:
    LDY #0
    LDA #0
    STA CURRENT_ITEM

input_loop:
    LDX #0
    JSR clear_screen
    JSR print_menu
    JSR get_command

command_loop:
    LDA COMMAND
    CMP #'1'
    BEQ add_item
    CMP #'2'
    BEQ remove_item
    CMP #'3'
    BEQ list_items
    CMP #'4'
    BEQ exit_program

    JSR invalid_command
    JMP input_loop

add_item:
    JSR clear_screen
    JSR get_item_name

    LDA CURRENT_ITEM
    STA inventory, Y

    INC CURRENT_ITEM
    BNE command_loop

remove_item:
    JSR clear_screen
    JSR print_inventory

    JSR get_item_number

    LDX #0
    LDA CURRENT_ITEM
    STA CURRENT_ITEM
copy_loop:
    CMP #INVENTORY_SIZE
    BEQ exit_loop

    LDA inventory, X
    STA inventory, X
    INX
    INY
    INY
    JMP copy_loop

exit_loop:
    DEC CURRENT_ITEM
    BRA command_loop

list_items:
    JSR clear_screen
    JSR print_inventory
    JSR wait_for_input
    JMP command_loop

exit_program:
    BRK

clear_screen:
    LDX #0
clear_loop:
    LDA #" "
    JSR CHROUT
    INX
    CPX #40
    BNE clear_loop

    LDX #0
    INX
    LDA #13
    JSR CHROUT
    LDA #10
    JSR CHROUT

    RTS

print_menu:
    LDA #0
    LDY #0
    LDX #0
    JSR clear_screen

    LDA #"1"
    JSR CHROUT
    LDA #". Add item"
    JSR print_string

    LDA #13
    JSR CHROUT
    LDA #10
    JSR CHROUT

    LDA #"2"
    JSR CHROUT
    LDA #". Remove item"
    JSR print_string

    LDA #13
    JSR CHROUT
    LDA #10
    JSR CHROUT

    LDA #"3"
    JSR CHROUT
    LDA #". List items"
    JSR print_string

    LDA #13
    JSR CHROUT
    LDA #10
    JSR CHROUT

    LDA #"4"
    JSR CHROUT
    LDA #". Exit program"
    JSR print_string

    RTS

get_command:
    JSR get_key
    STA COMMAND

    RTS

invalid_command:
    LDA #0
    LDY #0
    LDX #0

    JSR clear_screen

    LDA #"Invalid command, please try again."
    JSR print_string

    JSR wait_for_input

    RTS

get_item_name:
    LDA #"Enter item name: "
    JSR print_string

    JSR get_string

    STA inventory, Y

    RTS

get_item_number:
    LDA #"Enter item number to remove: "
    JSR print_string

    JSR get_key
    STA CURRENT_ITEM

    RTS

print_inventory:
    LDX #0
    LDY #0

print_loop:
    LDA inventory, X
    BEQ exit_print
    JSR print_string

    LDA #13
    JSR CHROUT
    LDA #10
    JSR CHROUT

    INX
    INY
    JSR print_loop

exit_print:
    RTS

print_string:
    JSR CHROUT
    INY
    LDY #0

print_loop_str:
    LDA inventory, Y
    BEQ exit_print_str
    JSR CHROUT
    INY
    JMP print_loop_str

exit_print_str:
    RTS

get_string:
    LDY #0

input_loop_str:
    JSR get_key
    STA inventory, Y
    CPY #39
    BEQ exit_input_str

    INY
    JMP input_loop_str

exit_input_str:
    LDA #0
    STA inventory, Y

    RTS

get_key:
    LDA #$00
    STA $FF
    LDA #$C0
    STA $01

key_loop:
    LDA $FF
    CMP #$00
    BEQ key_loop

    LDA $01
    AND #$10
    BNE key_loop

    LDA $FF
    LSR A
    BCC key_loop

    LDA $FF
    AND #$0F

    RTS

wait_for_input:
    LDA #0
    JSR get_key

    RTS
