
    .org $2000

; Define variables
xml_start equ $2000
xml_end equ $4000
current_pos equ $2000
tag_start equ $0
tag_end equ $0
data_start equ $0
data_end equ $0
in_tag equ $0
tag_name equ $0
tag_name_index equ $0
tag_value equ $0
tag_value_index equ $0
output equ $C000

    .org $FFFC      
    .word start

start:
    lda xml_start
    sta current_pos

parse_loop:
    lda current_pos
    cmp xml_end
    beq end_of_file

    lda current_pos
    cmp #'<'
    beq start_of_tag

    jmp next_char

start_of_tag:
    lda current_pos
    sta tag_start
    lda #1
    sta in_tag
    jmp next_char

end_of_tag:
    lda current_pos
    sta tag_end
    lda #0
    sta in_tag
    lda tag_start
    sta data_start
    lda tag_end
    sta data_end

    lda #0
    sta tag_name_index
    lda #0
    sta tag_value_index

parse_tag_name:
    lda data_start, tag_name_index
    cmp #'>'
    beq end_of_tag_name
    sta tag_name, tag_name_index
    inc tag_name_index
    jmp parse_tag_name

end_of_tag_name:
    lda #0
    sta tag_name, tag_name_index

parse_tag_value:
    lda data_end, tag_value_index
    cmp #'<'
    beq end_of_tag_value
    sta tag_value, tag_value_index
    inc tag_value_index
    jmp parse_tag_value

end_of_tag_value:
    lda #0
    sta tag_value, tag_value_index

    ; Here you can add code to check if the current tag name matches your desired tag name
    ; If it does, you can print the tag value to the output
    ; For example:
    ; ldx #0
    ; print_value:
    ; lda tag_value, x
    ; cmp #0
    ; beq end_of_tag_value
    ; sta output, x
    ; inx
    ; jmp print_value

next_char:
    inc current_pos
    jmp parse_loop

end_of_file:
    rts
