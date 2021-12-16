// Simple init
arch n64.cpu
endian msb
output "initial.N64", create

fill $0010'1000 // Set ROM Size in hex

// 4096 B reserved for header (config etc)
// 1,048,576b copied to ram on boot
// leaving 1,052,672b for me
// 1052672 bytes = $0010 1000 in hex

origin $00000000
base $80000000 //needed for calculating branches and jumps

//everything in asm is written to rom, inc is written as needed
//bin treated as binary blob inserted byte by byte
include "../library/N64.INC"
include "N64_Header.asm"
insert "../library/N64_BOOTCODE.BIN"

//starts at $80001000
//cartridge authentication protection
Start:	                 
	lui t0, PIF_BASE     // t0 = $BFC0 << 16	
	addi t1, zero, 8	 // t1 = 0 + 8
	sw t1, PIF_CTRL(t0)  // 0xBFC007FC = 8	

Loop:  // while(true) infinite
	j Loop
	nop
	
	
