
; Load the Matplotlib library and set up the random walk plot
load_library Matplotlib
init_plot random_walk
clear_plot

; Set initial position
lda #0
sta current_position

; Set number of steps for random walk
lda #100
sta num_steps

; Loop to generate random walk
loop:
    lda current_position
    jsr plot_point  ; Plot current point on the graph
    
    lda random_byte   ; Get a random byte from a hardware random number generator
    and #15           ; Mask lower 4 bits to get a random direction
    cmp #8            ; Check if direction is positive or negative
    bcc move_left     ; Branch if negative
    jmp move_right    ; Jump if positive
    
move_left:
    dec current_position
    jmp check_end
    
move_right:
    inc current_position
    
check_end:
    dec num_steps
    bne loop
    
; Display the random walk plot
display_plot random_walk
