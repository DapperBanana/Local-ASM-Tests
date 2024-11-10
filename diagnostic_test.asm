
LDA #<command
STA command_ptr
LDA #>command
STA command_ptr+1

LDA #<parameter
STA parameter_ptr
LDA #>parameter
STA parameter_ptr+1

JSR system
