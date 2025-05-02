
PET_INIT equ $0200
PET_FEED equ PET_INIT
PET_PLAY equ PET_INIT+1
PET_SLEEP equ PET_INIT+2
PET_CLEAN equ PET_INIT+3
PET_HAPPINESS equ $0300

.pet_name .byte "PET"
.pet_hungry .byte 0
.pet_tired .byte 0
.pet_dirty .byte 0

.pet_loop
    lda PET_INIT
    cmp #"F" ; Check if user wants to feed the pet
    beq .feed_pet

    lda PET_INIT
    cmp #"P" ; Check if user wants to play with the pet
    beq .play_pet

    lda PET_INIT
    cmp #"S" ; Check if user wants the pet to sleep
    beq .sleep_pet

    lda PET_INIT
    cmp #"C" ; Check if user wants to clean the pet
    beq .clean_pet

    jmp .update_pet

.feed_pet
    inc .pet_hungry
    jmp .update_pet
    
.play_pet
    inc .pet_hungry
    inc .pet_tired
    jmp .update_pet

.sleep_pet
    inc .pet_tired
    jmp .update_pet
    
.clean_pet
    .pet_dirty = 0
    jmp .update_pet
    
.update_pet
    lda .pet_hungry
    clc
    adc .pet_tired
    adc .pet_dirty
    sta PET_HAPPINESS
    
    lda PET_HAPPINESS
    cmp #50 ; Check if pet is happy
    bcs .sad_pet
    
    lda #"PET IS HAPPY"
    jmp .print_message
    
.sad_pet
    lda #"PET IS SAD :("
    jmp .print_message
    
.print_message
    sta $D020
    lda #"PRESS F TO FEED"
    sta $D021
    lda #"PRESS P TO PLAY"
    sta $D022
    lda #"PRESS S TO SLEEP"
    sta $D023
    lda #"PRESS C TO CLEAN"
    sta $D024
    
    rts

.pet_name_end
