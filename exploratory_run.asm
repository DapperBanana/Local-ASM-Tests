
RAM_START     = $0200
DICTIONARY    = $0300
NUM_ITEMS     = 5

; Initialize variables
MAX_VALUE     = $00
MIN_VALUE     = $01

    org RAM_START
    
    ldx #0 ; Initialize index
    
find_max:
    lda DICTIONARY, x
    cmp MAX_VALUE
    bcc skip_update_max
    sta MAX_VALUE
    
skip_update_max:
    inx 
    cpx NUM_ITEMS
    bne find_max

    ldx #0 ; Reset index

find_min:
    lda DICTIONARY, x
    cmp MIN_VALUE
    bcs skip_update_min
    sta MIN_VALUE
    
skip_update_min:
    inx 
    cpx NUM_ITEMS
    bne find_min
    
    ; At this point, MAX_VALUE and MIN_VALUE contains 
    ; the maximum and minimum values in the dictionary
    
    ; Place code to handle the results here
    
    rts
