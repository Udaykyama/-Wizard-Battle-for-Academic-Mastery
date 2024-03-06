.intel_syntax noprefix

.data
ascii1:
    ascii1:
    .ascii "    _______\n"
    .ascii "   /      /,\n"
    .ascii "  /      //\n"
    .ascii " /______//\n"
    .ascii "(______(/\n\0"
ascii2:
    .ascii "     (   )\n"
    .ascii "  (   ) (\n"
    .ascii "   ) _   )\n"
    .ascii "    ( \_\n"
    .ascii "  _(_\ \)__\n"
    .ascii " (____\___)) \n\0"
Endurance:
    .quad 100
Knowledge:
    .quad 0
Stress:
    .quad 0
days:
    .quad 0
Value:
    .quad 0
DaysLeftMsg:
    .ascii " DAYS LEFT!\n\0"
IntroductionMessage:
    
    .ascii "WIZARD BATTLE FOR GAMES\n\n"
    .ascii "Rules: \n"
    .ascii "1. 120 days (1 semester) \n"
    .ascii "2. Your resources\n"
    .ascii "   * Your endurance drops 10-20% each week. If it reaches 0%, the game ends\n"
    .ascii "   * You will forget 1-5% of your knowledge each week.\n"
    .ascii "   * Your stress increases 10-30% each turn. If it reaches 100%, you cannot study. \n "
    .ascii "3. Your choices: \n"
    .ascii "   * Resting increases endurance (30-60%) \n"
    .ascii "   * Studying increases knowledge (15-30%) \n"
    .ascii "   * Playing dreases stress (30-60%). \n\n"
    .ascii "The goal is to survive the semester with the most knowledge possible. \n\0"


SaturdayMessage: 
                  .ascii "It's Saturday! Do you want to 1. Rest, 2. Study, 3. Play quidditch \n\0"
GainMessage:
                  .ascii "You Gained \0"
LostMessage: 
                  .ascii "You lost \0"
forgotMessage:
                  .ascii "You Forgot \0"
EnduranceMsg:
                  .ascii "% Endurance. \n\0"
KnowledgeMsg:
                  .ascii "% Knowledge. \n\0"
GameEnd:
                  .ascii "You ended the game with \0"
StressMessage:
                  .ascii "% Stress. \n\0"
EnduranceStatus:
                  .ascii "Your Endurance is at \0"
KnowledgeStatus:
                  .ascii "Your Knowledge is at \0"
MagicBook:
                  .ascii "You Found a Magic book! Knowledge increased by 20! \n\0"
ClassCancelled:
                  .ascii "Your Class is cancelled! Endurance is reset! \n\0"
StressStatus:
                  .ascii "Your Stress is at \0"
PercentSign:
                  .ascii "%. \n\0"
KnowledgeStudying:
                  .ascii "% knowledge from studying. \n\0"
TooStressed:
                  .ascii "You are too stressed to study!\n\0"
DidSomeThingFun:
                  .ascii "% stress by doing something fun.\n\0"

.text
.global _start
_start:

AssignVariables:

    mov rdi, 120
    mov days, rdi
    mov rdi, 100
    mov Endurance, rdi
    mov rdi, 0
    mov Stress, rdi
    mov rdi, 0
    mov Knowledge, rdi

PrintIntroduction:

    lea rdi, IntroductionMessage
    call WriteString

Loop:

    #Checks Endurance and Days Left

    mov rdi, Endurance
    cmp rdi, 0
    jle End
    mov rdi, days
    cmp rdi, 0
    jle End

    #Prints days left

    mov rdi, 2
    call SetForeColor
    mov rdi, days
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, DaysLeftMsg
    call WriteString
    
EnduranceVal:

    mov rdi, Endurance
    cmp rdi, 100
    jle Endurance2

EnduranceFix:

    mov rdi, 100
    mov Endurance, rdi

Endurance2:

   lea rdi, EnduranceStatus
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Endurance
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, PercentSign
    call WriteString

KnowledgeVal:

    lea rdi, KnowledgeStatus
    call WriteString
    mov rdi, Knowledge
    cmp rdi, 0
    jg Knowledge2

KnowledgeFix:

    mov rdi, 0
    mov Knowledge, rdi

Knowledge2:

    mov rdi, 2
    call SetForeColor
    mov rdi, Knowledge
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, PercentSign
    call WriteString

StressVal:

    lea rdi, StressStatus
    call WriteString
    mov rdi, Stress
    cmp rdi, 100
    jl Stress2

StressFix:

    mov rdi, 100
    mov Stress, rdi

Stress2:

    mov rdi, 2
    call SetForeColor
    mov rdi, Stress
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, PercentSign
    call WriteString
    lea rdi, SaturdayMessage
    call WriteString

switch:
   
    call ReadInt
    cmp rdi, 1
    je Case1
    cmp rdi, 2
    je Case2
    cmp rdi, 3
    je Case3


Case1:
   
     mov rdi, 7
    call SetForeColor
    mov rdi, 31
    call Random
    add rdi, 30
    mov Value, rdi
    add Endurance, rdi
    lea rdi, GainMessage
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Value
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, EnduranceMsg
    call WriteString
    mov rdi, 0
    mov Value, rdi
    mov rdi, 5
    call Random
    cmp rdi, 1
    call RandomEvent2
    jmp initializeVariables


Case2:

    mov rdi, 7
    call SetForeColor
    mov rdi, Stress
    cmp rdi, 100
    jl KnowledgeAdd

Stressed:

    lea rdi, TooStressed
    call WriteString
    jmp initializeVariables

KnowledgeAdd:

    mov rdi, 5
    call Random
    cmp rdi, 2
    je RandomEvent1
    mov rdi, 11
    Call Random
    add rdi, 10
    mov Value, rdi
    add Knowledge, rdi
    lea rdi, GainMessage
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Value
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, KnowledgeStudying
    call WriteString
    lea rdi, ascii1
    call WriteString
    mov rdi, 0
    mov Value, rdi

    jmp initializeVariables


Case3:

    mov rdi, 7
    call SetForeColor
    mov rdi, 31
    call Random
    add rdi, 30
    mov Value, rdi
    sub Stress, rdi
    lea rdi, LostMessage
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Value
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, DidSomeThingFun
    call WriteString
    mov rdi, 0
    mov Value, rdi
    jmp initializeVariables

RandomEvent1:

    mov rdi, 20
    add Knowledge, rdi
    lea rdi, MagicBook
    call WriteString
    jmp initializeVariables

RandomEvent2:

    mov rdi, 100
    mov Endurance, rdi
    lea rdi, ClassCancelled
    call WriteString
    jmp initializeVariables

initializeVariables:

    # Endurance Lost

    mov rdi, 11
    call Random
    add rdi, 10
    mov Value, rdi
    sub Endurance, rdi
    lea rdi, LostMessage
    call WriteString
    mov rdi, Value
    call WriteInt
    lea rdi, EnduranceMsg
    call WriteString
    mov rdi, 0
    mov Value, rdi


    #Knowledge Lost

    mov rdi, 5
    call Random
    add rdi,1 
    mov Value, rdi
    sub Knowledge, rdi
    lea rdi, LostMessage
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Value
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, KnowledgeMsg
    call WriteString
    mov rdi, 0
    mov Value, rdi

    # Gained stress

    mov rdi, 21
    call Random
    add rdi, 10
    mov Value, rdi
    add Stress, rdi
    lea rdi, GainMessage
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Value
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, StressMessage
    call WriteString
     mov rdi, 0
    mov Value, rdi

    # Sub Days

    mov rdi, days
    sub rdi, 7
    mov days, rdi

    jmp Loop

End:

    lea rdi, GameEnd
    call WriteString
    mov rdi, 2
    call SetForeColor
    mov rdi, Knowledge
    call WriteInt
    mov rdi, 7
    call SetForeColor
    lea rdi, KnowledgeMsg
    call WriteString
    lea rdi, ascii2
    call WriteString
    call Exit
