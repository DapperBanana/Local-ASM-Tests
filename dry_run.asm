
    .org $0200     ; start program at memory location $0200
    .segment "CODE"

    LDX #0         ; initialize index register X to 0
    LDY #0         ; initialize index register Y to 0

loop:
    LDA menu       ; load menu string address into A register
    JSR print_str  ; call subroutine to print menu string
    JSR read_str   ; call subroutine to read user input
    
    CMP #$31       ; compare user input with '1'
    BEQ add_item   ; if equal, jump to add_item
    CMP #$32       ; compare user input with '2'
    BEQ remove_item ; if equal, jump to remove_item
    CMP #$33       ; compare user input with '3'
    BEQ view_inventory ; if equal, jump to view_inventory
    JMP loop       ; return to loop if input is not 1, 2, or 3

add_item:
    JSR print_add_prompt   ; call subroutine to print add item prompt
    JSR read_str           ; call subroutine to read user input
    STA inventory,X        ; store user input at current index X in inventory array
    INX                    ; increment index X
    JMP loop               ; return to loop

remove_item:
    JSR print_remove_prompt  ; call subroutine to print remove item prompt
    JSR read_str             ; call subroutine to read user input
    STA temp                ; store user input in temp variable
    LDX #0                  ; initialize index register X to 0
loop_remove:
    CMP temp,Y              ; compare user input with item at index Y in inventory array
    BEQ item_found          ; if equal, jump to item_found
    INY                     ; increment index Y
    CPY #10                 ; compare index Y with number of items in inventory array
    BEQ item_not_found      ; if equal, item not found
    JMP loop_remove         ; return to loop_remove

item_found:
    LDX Y                   ; load index Y into X register
    LDA #$20                ; load ASCII space character into A register
    STA inventory,X         ; erase item at index X in inventory array
    INY                     ; increment index Y
    JMP loop                ; return to loop

item_not_found:
    JSR print_item_not_found ; call subroutine to print item not found message       
    JMP loop                 ; return to loop

view_inventory:
    LDA #$0D            ; load ASCII carriage return character into A register
    JSR print_char      ; call subroutine to print carriage return
    LDX #0              ; initialize index register X to 0
loop_view:
    LDA inventory,X     ; load item at index X in inventory array into A register
    JSR print_char      ; call subroutine to print item
    INX                 ; increment index X
    CPX #10             ; compare index X with number of items in inventory array
    BNE loop_view       ; if not equal, return to loop_view
    JMP loop            ; return to loop

segment "DATA"
menu: .asciiz "1. Add Item\n2. Remove Item\n3. View Inventory\nChoose an option: "
add_prompt: .asciiz "Enter item to add: "
remove_prompt: .asciiz "Enter item to remove: "
item_not_found_msg: .asciiz "Item not found in inventory"
inventory: .byte 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
temp: .byte 0

.segment "CODE"
print_str:
    LDA #$0D       ; load ASCII carriage return character into A register
    JSR print_char ; call subroutine to print carriage return
    LDY #0         ; initialize index register Y to 0
loop_print:
    LDA (A),Y      ; load character from string at address in A register indexed by Y into A register
    BEQ end_print  ; if character is 0, end of string, jump to end_print
    JSR print_char ; call subroutine to print character
    INY            ; increment index Y
    JMP loop_print ; return to loop_print
end_print:
    RTS

print_char:
    STA $D012      ; store character in A register in screen memory
    RTS

read_str:
    LDA #$0D       ; load ASCII carriage return character into A register
    JSR print_char ; call subroutine to print carriage return
    LDX #0         ; initialize index register X to 0
    LDA #$FF       ; load $FF into A register
loop_read:
    BIT $D011      ; read keyboard status
    BPL loop_read  ; if bit 7 of $D011 is 1, wait for key press
    JSR print_char ; call subroutine to print character
    CMP #$0D       ; compare input character with carriage return
    BEQ end_read   ; if equal, end of input, jump to end_read
    STA (A,X)      ; store input character in memory at address in A register indexed by X
    INX            ; increment index X
    JMP loop_read  ; return to loop_read
end_read:
    CLC            ; clear carry flag
    RTS

print_add_prompt:
    LDA add_prompt  ; load add item prompt string address into A register
    JSR print_str    ; call subroutine to print add item prompt
    RTS

print_remove_prompt:
    LDA remove_prompt    ; load remove item prompt string address into A register
    JSR print_str        ; call subroutine to print remove item prompt
    RTS

print_item_not_found:
    LDA #$0D             ; load ASCII carriage return character into A register
    JSR print_char       ; call subroutine to print carriage return
    LDA item_not_found_msg  ; load item not found message address into A register
    JSR print_str          ; call subroutine to print item not found message
    RTS
