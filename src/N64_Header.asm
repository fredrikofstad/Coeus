// N64 Header
// define endianess? 
// databytes 8b | datawords 32b | datahalfword 16b | datadouble 64
db $80
db $37
db $12
db $40

// Clock Rate for booting
dw $0000000F
// points to start
dw Start
dw $1444
db "CRC1"
db "CRC2"

dd 0

db   "initTest                   "
//   "123456789012345678901234567"
// 	 must be 27 chars

db $00 // Dev Id
db $00 // Cart Id
db $00 
db $00
db $00