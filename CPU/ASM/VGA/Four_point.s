NOP
NOP
NOP
NOP

LI R1 0X0000;ROW AND COL
LI R3 0X0000;COLOR

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000A
SW R6 R1 0X0000

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000D
SW R6 R3 0X0000
;
LI R1 0X0001;ROW AND COL
LI R3 0X0001;COLOR

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000A
SW R6 R1 0X0000

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000D
SW R6 R3 0X0000
;
LI R1 0X0002;ROW AND COL
LI R3 0X0002;COLOR

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000A
SW R6 R1 0X0000

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000D
SW R6 R3 0X0000
;
LI R1 0X0003;ROW AND COL
LI R3 0X0003;COLOR

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000A
SW R6 R1 0X0000

LI R6 0X00BF
SLL R6 R6 0X0000
ADDIU R6 0X000D
SW R6 R3 0X0000

BEGIN:
NOP
B BEGIN
NOP
