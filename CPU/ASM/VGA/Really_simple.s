NOP
NOP
NOP
NOP

LI R1 0X0000;ROW AND COL
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
LI R1 0X001D
SLL R1 R1 0X0000
LI R2 0X004F
OR R1 R2
LI R3 0X0001

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
