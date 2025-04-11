
.ORG $0900

START:
    LDX #0              ; Initialize index for recipe array
    JSR PRINT_TITLE     ; Print title of the program
    JSR LINE_BREAK
    
    JSR PRINT_MENU       ; Print menu options
    JSR LINE_BREAK
    
INPUT_LOOP:
    JSR GET_INPUT        ; Get user input
    CMP #1              ; Check user input
    BEQ MEATLOAF         ; If input is 1, recommend meatloaf recipe
    CMP #2              ; Check user input
    BEQ CHICKEN_PARM     ; If input is 2, recommend chicken parmesan recipe
    JMP INVALID_INPUT    ; If input is invalid, display error message
    
MEATLOAF:
    JSR PRINT_MEATLOAF   ; Print meatloaf recipe
    JMP END_PROGRAM
    
CHICKEN_PARM:
    JSR PRINT_CHICKEN_PARM  ; Print chicken parmesan recipe
    JMP END_PROGRAM
    
INVALID_INPUT:
    JSR PRINT_INVALID_INPUT  ; Print error message
    JMP INPUT_LOOP
    
END_PROGRAM:
    RTS

PRINT_TITLE:
    LDA #$0D
    JSR CHROUT          ; Output carriage return
    LDA #$0A
    JSR CHROUT          ; Output line feed
    LDX #0
PRINT_TITLE_LOOP:
    LDA TITLE_TEXT,X    ; Load title text
    BEQ PRINT_TITLE_END  ; If end of string, return
    JSR CHROUT          ; Output character
    INX
    JMP PRINT_TITLE_LOOP
    
PRINT_TITLE_END:
    RTS

PRINT_MENU:
    LDX #0
PRINT_MENU_LOOP:
    LDA MENU_TEXT,X     ; Load menu text
    BEQ PRINT_MENU_END   ; If end of string, return
    JSR CHROUT          ; Output character
    INX
    JMP PRINT_MENU_LOOP
    
PRINT_MENU_END:
    RTS

PRINT_MEATLOAF:
    LDX #0
PRINT_MEATLOAF_LOOP:
    LDA MEATLOAF_TEXT,X
    BEQ PRINT_MEATLOAF_END
    JSR CHROUT
    INX
    JMP PRINT_MEATLOAF_LOOP
    
PRINT_MEATLOAF_END:
    RTS

PRINT_CHICKEN_PARM:
    LDX #0
PRINT_CHICKEN_PARM_LOOP:
    LDA CHICKEN_PARM_TEXT,X
    BEQ PRINT_CHICKEN_PARM_END
    JSR CHROUT
    INX
    JMP PRINT_CHICKEN_PARM_LOOP
    
PRINT_CHICKEN_PARM_END:
    RTS

PRINT_INVALID_INPUT:
    LDX #0
PRINT_INVALID_INPUT_LOOP:
    LDA INVALID_INPUT_TEXT,X
    BEQ PRINT_INVALID_INPUT_END
    JSR CHROUT
    INX
    JMP PRINT_INVALID_INPUT_LOOP
    
PRINT_INVALID_INPUT_END:
    RTS

GET_INPUT:
    LDA #0
    JSR GETIN           ; Get user input
    CMP #30             ; Check if input is a number
    BMI INVALID_INPUT   ; If input is not a number, display error message
    RTS
    
LINE_BREAK:
    LDA #$0D
    JSR CHROUT          ; Output carriage return
    LDA #$0A
    JSR CHROUT          ; Output line feed
    RTS

TITLE_TEXT: .BYTE "Recipe Recommendation System",0
MENU_TEXT: .BYTE "1. Meatloaf",0
           .BYTE "2. Chicken Parmesan",0
           .BYTE "Enter recipe number to get recommendation: ",0
MEATLOAF_TEXT: .BYTE "Meatloaf Recipe:",0
               .BYTE "1 lb ground beef",0
               .BYTE "1 cup breadcrumbs",0
               .BYTE "1/2 cup milk",0
CHICKEN_PARM_TEXT: .BYTE "Chicken Parmesan Recipe:",0
                   .BYTE "2 chicken breasts",0
                   .BYTE "1 cup breadcrumbs",0
                   .BYTE "1 cup tomato sauce",0
INVALID_INPUT_TEXT: .BYTE "Invalid input. Please enter a valid recipe number.",0

.END
