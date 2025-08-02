
; Program to calculate the area of a regular pentagonal prism

 .text
 .org $0200

start:
    ; Initialize variables
    LDA #$00   ; Initialize sum to 0
    STA sum
   
    ; Calculate the area of the pentagon
    LDA #5     ; Load the number of sides of the pentagon
    CLC
    ADC #1     ; Calculate the number of faces of the prism (pentagon + top face)
    STA num_faces
    
    LDA #10    ; Load the side length of the pentagon
    STA side_length

    LDX #0     ; Initialize counter X to 0 (for looping through faces)
    
loop:
    CLC
    LDA side_length
    ADC sum     ; Add the current face area to the sum
    STA sum

    INX          ; Increment counter X
    CPX num_faces  ; Compare counter to the total number of faces
    BCC loop     ; Loop back if not done

    ; Output the result
    LDA sum
    STA $FF     ; Store the result in memory location $FF

end:
    JMP end     ; End of program

sum: .byte $00
num_faces: .byte $00
side_length: .byte $00

