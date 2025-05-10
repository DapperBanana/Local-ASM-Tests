
    processor 6502

    ; Define memory locations
    IMG_START = $1000     ; Start address of image data
    IMG_SIZE = 64         ; Image size in bytes
    GRAY_START = $1100    ; Start address of grayscale image data

    ; Load image data into memory at IMG_START
    LDX #$00
load_image:
    LDA image_data, X
    STA IMG_START, X
    INX
    CPX IMG_SIZE
    BNE load_image

    ; Convert image to grayscale
    LDX #$00
convert_grayscale:
    LDA IMG_START, X
    JSR rgb_to_grayscale
    STA GRAY_START, X
    INX
    CPX IMG_SIZE
    BNE convert_grayscale

    ; Halt execution
    BRK

rgb_to_grayscale:
    ; Convert RGB value to grayscale
    AND #$E0         ; Clear the lower 3 bits (blue)
    LSR              ; Shift right to get red value in lower 5 bits
    LSR
    LSR
    LSR
    LSR              
    TAX              ; Store red value in X register
    LDA #$60         ; Coefficient for red channel (30%)
    MUL              ; Multiply red value by coefficient
    LDA IMG_START, X ; Get green value from memory
    LDA #$1C         ; Coefficient for green channel (59%)
    MUL              ; Multiply green value by coefficient
    CLC              ; Clear carry flag for addition
    TAY              ; Store green value in Y register
    LDA #$0B         ; Coefficient for blue channel (11%)
    MUL              ; Multiply blue value by coefficient
    TAY              ; Store result in Y register
    TYA              ; Add green value to result
    CLC              ; Clear carry flag for addition
    ADC TAX          ; Add red value to result
    STA GRAY_START, X ; Store grayscale value in memory
    RTS

    image_data:
    ; Insert image data here
