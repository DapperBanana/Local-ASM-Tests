
; Flight Reservation System

; Constants
.buffer_size equ 20
.departure_cities db "New York", 0
.arrival_cities db "Los Angeles", 0
.enter_departure_city db "Enter departure city: ", 0
.enter_arrival_city db "Enter arrival city: ", 0
.enter_name db "Enter passenger name: ", 0
.reservation_confirm db "Reservation confirmed for ", 0

; Variables
buffer ds .buffer_size
departure_city db 0
arrival_city db 0

; Entry point
start:
    lda #0
    sta departure_city
    sta arrival_city
    
    ; Get departure city
    ldx #0
    print enter_departure_city
get_departure_city:
    lda departure_cities, x
    beq invalid_departure_city
    jsr print_char
    inx
    jmp get_departure_city
invalid_departure_city:
    jsr read_string
    sta departure_city
    
    ; Get arrival city
    ldx #0
    print enter_arrival_city
get_arrival_city:
    lda arrival_cities, x
    beq invalid_arrival_city
    jsr print_char
    inx
    jmp get_arrival_city
invalid_arrival_city:
    jsr read_string
    sta arrival_city
    
    ; Get passenger name
    print enter_name
    jsr read_string
    
    ; Confirm reservation
    ldx #0
    print reservation_confirm
print_name:
    lda buffer, x
    beq confirm
    jsr print_char
    inx
    jmp print_name
confirm:
    rts

; Print a null-terminated string
print:
    lda #0
print_next:
    cmp #$ff
    beq print_done
    jsr print_char
    inx
    jmp print_next
print_done:
    rts

; Print a character
print_char:
    jsr $ffd2
    rts

; Read a string from the keyboard
read_string:
    ldx #0
read_next:
    jsr $ffcf
    sta buffer, x
    cmp #13
    beq read_done
    inx
    jmp read_next
read_done:
    sta buffer, x
    rts
