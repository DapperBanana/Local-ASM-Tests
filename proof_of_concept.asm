
ORG $0200 ; Start of program

    LDX #0 ; Initialize index register

create_team:
    LDA #10 ; Load prompt for creating a team
    JSR $FFD2 ; Call to Kernel routine for outputting text
    LDA #0 ; Load null terminator for input buffer
    JSR $FFCE ; Call to Kernel routine for input
    STA $0400,X ; Store team name in memory
    INX ; Increment index register
    CPX #5 ; Check if team name is complete
    BNE create_team ; Loop until team name is complete

select_players:
    LDA #20 ; Load prompt for selecting players
    JSR $FFD2 ; Call to Kernel routine for outputting text
    LDA #0 ; Load null terminator for input buffer
    JSR $FFCE ; Call to Kernel routine for input
    STA $0500,X ; Store player name in memory
    INX ; Increment index register
    CPX #5 ; Check if all players are selected
    BNE select_players ; Loop until all players are selected

view_stats:
    LDA #30 ; Load prompt for viewing team stats
    JSR $FFD2 ; Call to Kernel routine for outputting text
    LDX #0 ; Initialize index register
print_stats:
    LDA $0400,X ; Load team name from memory
    JSR $FFD2 ; Call to Kernel routine for outputting text
    LDA #" - " ; Load separator
    JSR $FFD2 ; Call to Kernel routine for outputting text
    LDA $0500,X ; Load player name from memory
    JSR $FFD2 ; Call to Kernel routine for outputting text
    INX ; Increment index register
    CPX #5 ; Check if all players are printed
    BNE print_stats ; Loop until all players' stats are printed

    BRK ; End of program

    ; Data section
    .CHAR "Team1", 0
    .CHAR "Player1", 0
    .CHAR "Player2", 0
    .CHAR "Player3", 0
    .CHAR "Player4", 0
    .CHAR "Player5", 0
